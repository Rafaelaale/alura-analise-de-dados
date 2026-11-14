-- Exploracao inicial do banco de dados

SELECT * FROM vendas LIMIT 5;

SELECT * FROM categorias;
SELECT * FROM produtos;
SELECT * FROM fornecedores;
SELECT * FROM marcas;

-- Contagem de registros

SELECT COUNT(*) AS Total_Categorias FROM categorias;
SELECT COUNT(*) AS Total_Clientes FROM clientes;
SELECT COUNT(*) AS Total_Fornecedores FROM fornecedores;
SELECT COUNT(*) AS Total_Itens_Venda FROM itens_venda;
SELECT COUNT(*) AS Total_Marcas FROM marcas;
SELECT COUNT(*) AS Total_Produtos FROM produtos;
SELECT COUNT(*) AS Total_Vendas FROM vendas;

-- Anos distintos

SELECT DISTINCT
    strftime('%Y', data_venda) AS Ano
FROM vendas
ORDER BY Ano;