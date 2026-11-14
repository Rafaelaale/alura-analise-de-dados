-- Comparacao de vendas entre 2020 e 2023

SELECT
    Mes,
    SUM(CASE WHEN Ano = '2020' THEN Total ELSE 0 END) AS "2020",
    SUM(CASE WHEN Ano = '2021' THEN Total ELSE 0 END) AS "2021",
    SUM(CASE WHEN Ano = '2022' THEN Total ELSE 0 END) AS "2022",
    SUM(CASE WHEN Ano = '2023' THEN Total ELSE 0 END) AS "2023"
FROM (
    SELECT
        strftime('%m', data_venda) AS Mes,
        strftime('%Y', data_venda) AS Ano,
        COUNT(*) AS Total
    FROM vendas
    GROUP BY
        strftime('%Y', data_venda),
        strftime('%m', data_venda)
) AS Resumo
GROUP BY Mes
ORDER BY Mes;