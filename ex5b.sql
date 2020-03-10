SELECT* 
FROM pedidos
JOIN item_pedidos ON (pedidos.numero_pedido = item_pedidos.numero_pedido)
WHERE quantidade > 1;