SELECT clientes.nome, COUNT(*) 
FROM pedidos
JOIN clientes ON (pedidos.codigo_cliente = clientes.codigo_cliente)
GROUP BY clientes.nome;