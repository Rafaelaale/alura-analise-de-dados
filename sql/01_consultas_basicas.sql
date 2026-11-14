-- Consulta basica: vendas por ano e mes

SELECT
    strftime('%Y/%m', data_venda) AS Ano_Mes,
    COUNT(*) AS Qtd_Vendas
FROM vendas
GROUP BY strftime('%Y/%m', data_venda)
ORDER BY Ano_Mes;
