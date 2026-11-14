-- Comparativo de vendas de novembro por ano

SELECT
    strftime('%Y', data_venda) AS Ano,
    COUNT(*) AS Qtd_Vendas
FROM vendas
WHERE strftime('%m', data_venda) = '11'
GROUP BY strftime('%Y', data_venda)
ORDER BY Ano;
