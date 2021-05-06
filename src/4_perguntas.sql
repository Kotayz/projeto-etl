-- QUERIES TO VALIDATE


-- Evolução semanal da arrecadação

SELECT semana, sum(fato_exibicao.arrecad) as total_arrecadado 
FROM stg.dim_tempo
INNER JOIN stg.fato_exibicao
on fato_exibicao.cod_tempo = dim_tempo.id_tempo
GROUP by semana;


-- Média de público das exibições por ator

SELECT  nome_artista, papel, round(avg(fato_exibicao.publico), 2) as media_publico
FROM stg.dim_participa
INNER JOIN stg.fato_exibicao
on fato_exibicao.cod_particip = dim_participa.id_particip
where papel = "Ator"
GROUP by nome_artista, papel;


-- Média de público das exibições por diretor

SELECT nome_artista, papel, round(avg(fato_exibicao.publico), 2) as media_publico
FROM stg.dim_participa
INNER JOIN stg.fato_exibicao
on fato_exibicao.cod_particip = dim_participa.id_particip
where papel = "Diretor"
GROUP by nome_artista, papel;


-- Total arrecadado por mês em cada estado

SELECT dim_sala.estado as UF, dim_tempo.mes_nome, sum(fato_exibicao.arrecad) as total_arrecadado
FROM stg.fato_exibicao
INNER JOIN stg.dim_sala
on dim_sala.id_sala = fato_exibicao.cod_sala
INNER JOIN stg.dim_tempo
on dim_tempo.id_tempo = fato_exibicao.cod_tempo
GROUP by 1, 2;