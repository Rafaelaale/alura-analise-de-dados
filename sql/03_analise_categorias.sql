-- Participacao percentual das categorias

SELECT
    c.nome_categoria AS Nome_Categoria,
    COUNT(iv.produto_id) AS Qtd_Vendas,
    ROUND(
        COUNT(iv.produto_id) * 100.0 /
        NULLIF(
            (SELECT COUNT(*) FROM itens_venda),
            0
        ),
        2
    ) AS Porcentagem
FROM itens_venda iv
JOIN produtos p
    ON p.id_produto = iv.produto_id
JOIN categorias c
    ON c.id_categoria = p.categoria_id
GROUP BY c.nome_categoria
ORDER BY Qtd_Vendas DESC;
