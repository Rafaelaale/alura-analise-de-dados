-- Comparacao mensal de tres fornecedores
-- Abrange todos os meses com registros.

SELECT
    Ano_Mes,
    SUM(CASE WHEN Nome = 'NebulaNetworks'
        THEN Total ELSE 0 END) AS NebulaNetworks,
    SUM(CASE WHEN Nome = 'HorizonDistributors'
        THEN Total ELSE 0 END) AS HorizonDistributors,
    SUM(CASE WHEN Nome = 'AstroSupply'
        THEN Total ELSE 0 END) AS AstroSupply
FROM (
    SELECT
        strftime('%Y/%m', v.data_venda) AS Ano_Mes,
        f.nome AS Nome,
        COUNT(iv.produto_id) AS Total
    FROM itens_venda iv
    JOIN vendas v ON v.id_venda = iv.venda_id
    JOIN produtos p ON p.id_produto = iv.produto_id
    JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
    WHERE f.nome IN (
        'NebulaNetworks',
        'HorizonDistributors',
        'AstroSupply'
    )
    GROUP BY
        strftime('%Y/%m', v.data_venda),
        f.nome
) AS Resumo
GROUP BY Ano_Mes
ORDER BY Ano_Mes;