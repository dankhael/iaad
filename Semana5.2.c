SELECT * 
FROM startup as s
LEFT JOIN programador as p
ON s.id_startup = p.id_startup
UNION
SELECT *
FROM startup as s
RIGHT JOIN programador as p
ON s.id_startup = p.id_startup;

Esse comando une os elementos da tabela de acordo com a chave id_startup junto com os elementos que tem null dos dois lados.
