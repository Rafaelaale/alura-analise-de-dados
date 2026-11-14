-- Media dos meses de novembro, exceto 2022

WITH Media_Vendas_Anteriores AS (
    SELECT AVG(Qtd_Vendas) AS Media_Qtd_Vendas
    FROM (
        SELECT COUNT(*) AS Qtd_Vendas
        FROM vendas
        WHERE strftime('%m', data_venda) = '11'
          AND strftime('%Y', data_venda) != '2022'
        GROUP BY strftime('%Y', data_venda)
    )
),
Vendas_Atual AS (
    SELECT COUNT(*) AS Qtd_Vendas_Atual
    FROM vendas
    WHERE strftime('%m', data_venda) = '11'
      AND strftime('%Y', data_venda) = '2022'
)
SELECT
    ROUND(m.Media_Qtd_Vendas, 2) AS Media_Anterior,
    v.Qtd_Vendas_Atual,
    ROUND(
        (v.Qtd_Vendas_Atual - m.Media_Qtd_Vendas)
        * 100.0 / NULLIF(m.Media_Qtd_Vendas, 0),
        2
    ) AS Variacao_Percentual
FROM Media_Vendas_Anteriores m
CROSS JOIN Vendas_Atual v;
