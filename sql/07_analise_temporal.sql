-- Vendas por ano

SELECT
    strftime('%Y', data_venda) AS Ano,
    COUNT(*) AS Total_Vendas
FROM vendas
GROUP BY strftime('%Y', data_venda)
ORDER BY Ano;

-- Vendas por ano e mes

SELECT
    strftime('%Y', data_venda) AS Ano,
    strftime('%m', data_venda) AS Mes,
    COUNT(*) AS Total_Vendas
FROM vendas
GROUP BY
    strftime('%Y', data_venda),
    strftime('%m', data_venda)
ORDER BY Ano, Mes;

-- Vendas em janeiro, novembro e dezembro

SELECT
    strftime('%Y', data_venda) AS Ano,
    strftime('%m', data_venda) AS Mes,
    COUNT(*) AS Total_Vendas
FROM vendas
WHERE strftime('%m', data_venda) IN ('01', '11', '12')
GROUP BY
    strftime('%Y', data_venda),
    strftime('%m', data_venda)
ORDER BY Ano, Mes;