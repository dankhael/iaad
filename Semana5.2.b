I- 
Junção com clausula WHERE:
SELECT nome_programador, nome_startup FROM programador, startup
WHERE Programador.id_startup = Startup.id_startup;

Junção com INNER JOIN:
SELECT nome_programador, nome_startup
FROM programador
INNER JOIN startup
ON programador.id_startup = startup.id_startup;

Junção com NATURAL JOIN:
SELECT nome_programador, nome_startup
FROM programador
NATURAL JOIN startup;

II-
SELECT p.nome_programador, lp.linguagem
FROM programador as p
JOIN programador_linguagem as pl
ON p.id_programador = pl.id_programador
JOIN linguagem_programação as lp
ON pl.id_linguagem = lp.id_linguagem;

III-
SELECT p.nome_programador,  lp.linguagem
FROM programador as p
LEFT JOIN programador_linguagem as pl
ON p.id_programador = pl.id_programador
LEFT JOIN linguagem_programação as lp
ON pl.id_linguagem = lp.id_linguagem;

IV-
SELECT p.nome_programador
FROM programador as p
LEFT JOIN programador_linguagem as pl
ON p.id_programador = pl.id_programador
WHERE pl.id_linguagem IS NULL;

V-

