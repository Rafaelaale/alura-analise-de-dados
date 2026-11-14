import sqlite3
import sys
import re
from pathlib import Path
from datetime import datetime

PROJETO = Path(__file__).resolve().parent.parent

PASTA_SQL = PROJETO / "sql"
PASTA_RELATORIOS = PROJETO / "relatorios"

PASTA_RELATORIOS.mkdir(exist_ok=True)

print("\n===== PROCURANDO BANCO DE DADOS =====")

locais = [
    PROJETO / "banco",
    Path.home() / "Downloads",
    Path.home() / "Desktop",
]

candidatos = []

for local in locais:
    if local.exists():
        for arquivo in local.iterdir():
            if (
                arquivo.is_file()
                and re.fullmatch(
                    r"banco_de_dados_vendas\.db(?:\.\d+)?",
                    arquivo.name,
                    re.IGNORECASE,
                )
            ):
                candidatos.append(arquivo)

if not candidatos:
    print("BANCO NAO ENCONTRADO.")
    print("Exporte o banco SQLite Online para Downloads.")
    print("Nenhum teste SQL foi executado.")
    sys.exit(2)

candidatos.sort(
    key=lambda p: p.stat().st_mtime,
    reverse=True
)

banco = None

for candidato in candidatos:
    with candidato.open("rb") as f:
        assinatura = f.read(16)

    if assinatura == b"SQLite format 3\x00":
        banco = candidato
        break

if banco is None:
    print("Arquivos encontrados, mas nenhum tem formato SQLite valido.")
    sys.exit(2)

print("Banco:", banco)

print("\n===== ABRINDO BANCO SOMENTE PARA LEITURA =====")

con = sqlite3.connect(
    banco.as_uri() + "?mode=ro",
    uri=True
)

con.execute("PRAGMA query_only = ON")

relatorio = [
    "# Auditoria SQL - Alura",
    "",
    f"Data: {datetime.now():%Y-%m-%d %H:%M:%S}",
    f"Banco analisado: {banco.name}",
    "",
]

print("\n===== VERIFICANDO INTEGRIDADE =====")

integridade = con.execute(
    "PRAGMA integrity_check"
).fetchone()[0]

print("Integridade:", integridade)

relatorio.append(f"Integridade: {integridade}")
relatorio.append("")

if integridade != "ok":
    con.close()
    print("Falha na integridade do banco.")
    sys.exit(1)

print("\n===== MAPEANDO TABELAS =====")

tabelas = con.execute(
    "SELECT name FROM sqlite_master "
    "WHERE type='table' ORDER BY name"
).fetchall()

relatorio.append("## Estrutura do banco")
relatorio.append("")

for (tabela,) in tabelas:
    print("\nTabela:", tabela)
    relatorio.append(f"### {tabela}")

    colunas = con.execute(
        "PRAGMA table_info(" +
        '"' + tabela.replace('"', '""') + '"' +
        ")"
    ).fetchall()

    for coluna in colunas:
        nome = coluna[1]
        tipo = coluna[2]

        print("  ", nome, tipo)
        relatorio.append(f"- {nome}: {tipo}")

    relatorio.append("")

print("\n===== TESTANDO CONSULTAS SQL =====")

relatorio.append("## Validacao das consultas")
relatorio.append("")

aprovadas = 0
falhas = 0

arquivos = sorted(PASTA_SQL.glob("*.sql"))

for arquivo in arquivos:
    print("\nArquivo:", arquivo.name)

    try:
        consulta = arquivo.read_text(
            encoding="utf-8-sig"
        )

        cursor = con.execute(consulta)

        colunas = [
            item[0] for item in cursor.description or []
        ]

        resultados = cursor.fetchmany(5)

        print("STATUS: APROVADO")
        print("Colunas:", colunas)

        for linha in resultados:
            print("Resultado:", linha)

        aprovadas += 1
        relatorio.append(f"- APROVADO: {arquivo.name}")

    except Exception as erro:
        print("STATUS: ERRO")
        print("Detalhes:", erro)

        falhas += 1
        relatorio.append(
            f"- ERRO: {arquivo.name}: {erro}"
        )

con.close()

print("\n===== RESULTADO FINAL =====")
print("Consultas encontradas:", len(arquivos))
print("Consultas aprovadas:", aprovadas)
print("Consultas com erro:", falhas)

relatorio.extend([
    "",
    "## Resultado final",
    "",
    f"Consultas encontradas: {len(arquivos)}",
    f"Consultas aprovadas: {aprovadas}",
    f"Consultas com erro: {falhas}",
])

saida = PASTA_RELATORIOS / "auditoria_sql.md"

if saida.exists():
    saida = PASTA_RELATORIOS / "auditoria_sql_recuperacao.md"

if saida.exists():
    print("Relatorio anterior preservado.")
    print("Nao foi criado outro relatorio.")
else:
    saida.write_text(
        "\n".join(relatorio) + "\n",
        encoding="utf-8"
    )
    print("Relatorio salvo:", saida)

print("\nAUDITORIA EXECUTADA.")

if falhas:
    sys.exit(1)
