-- Quantidade de itens de venda por fornecedor

SELECT
    f.nome AS Nome_Fornecedor,
    COUNT(iv.produto_id) AS Qtd_Itens_Venda
FROM itens_venda iv
JOIN produtos p
    ON p.id_produto = iv.produto_id
JOIN fornecedores f
    ON f.id_fornecedor = p.fornecedor_id
GROUP BY f.nome
ORDER BY Qtd_Itens_Venda DESC;
