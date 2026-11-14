-- Media de vendas de novembro, exceto 2022
-- Inclui anos posteriores, caso existam.

WITH Media_Referencia AS (
    SELECT AVG(Total) AS Media
    FROM (
        SELECT COUNT(*) AS Total
        FROM vendas
        WHERE strftime('%m', data_venda) = '11'
          AND strftime('%Y', data_venda) != '2022'
        GROUP BY strftime('%Y', data_venda)
    )
),
Vendas_2022 AS (
    SELECT COUNT(*) AS Total
    FROM vendas
    WHERE strftime('%m', data_venda) = '11'
      AND strftime('%Y', data_venda) = '2022'
)
SELECT
    ROUND(m.Media, 2) AS Media_Referencia,
    v.Total AS Vendas_Novembro_2022,
    ROUND(
        (v.Total - m.Media) * 100.0 /
        NULLIF(m.Media, 0),
        2
    ) AS Variacao_Percentual
FROM Media_Referencia m
CROSS JOIN Vendas_2022 v;