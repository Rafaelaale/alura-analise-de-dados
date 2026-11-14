# Etapa SQL - Analise de Dados

## Conteudos estudados

- Exploracao de tabelas
- Contagem de registros
- Manipulacao de datas
- Agrupamentos anuais e mensais
- JOIN entre tabelas
- Analise de fornecedores
- CASE WHEN e pivotamento
- Subconsultas
- AVG, SUM e COUNT
- CTEs
- Comparacao percentual

## Melhorias aplicadas

- Padronizacao dos aliases
- Remocao de consultas repetidas
- Agrupamento por ano e mes
- Organizacao dos exercicios por assunto
- Protecao contra divisao por zero
- Separacao de consultas independentes

## Observacoes analiticas

As consultas de novembro nao representam
automaticamente as vendas realizadas apenas
na data oficial da Black Friday.

COUNT(produto_id) contabiliza registros de
itens, nao necessariamente unidades vendidas.

A media de referencia exclui 2022, mas pode
incluir anos posteriores.

## Validacao

Status: pendente.

O banco SQLite ainda precisa ser disponibilizado
localmente para verificar resultados, integridade
e compatibilidade com o esquema real.

## Proximas etapas

- Importar o banco SQLite
- Executar auditoria
- Documentar resultados reais
- Adicionar testes automatizados
- Publicar as melhorias validadas