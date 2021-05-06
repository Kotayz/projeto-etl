-- CRIANDO A DIMENSAO SALA
DROP TABLE if  EXISTS stg."fato_exibicao";
DROP TABLE IF EXISTS stg."dim_sala";
CREATE TABLE stg."dim_sala" (
	`id_sala`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`num_sala` 	INT,
	`capacidade`INT,
	`cinema`	TEXT,
	`local`		TEXT,
	`cidade`	TEXT,
	`estado`	TEXT,
	`regiao`	TEXT,
	`pais`		TEXT
);

		
-- CRIANDO A DIMENSAO FILME
DROP TABLE if  EXISTS stg."fato_exibicao";
DROP TABLE if  EXISTS stg."dim_filme";
CREATE TABLE if not EXISTS stg."dim_filme" (
	`id_filme` INTEGER PRIMARY KEY AUTOINCREMENT,
	`nome`	TEXT,
	`codfilme` INTEGER ,
	`genero`	TEXT
);


-- CRIANDO A DIMENSAO PARTIC	
DROP TABLE if  EXISTS stg."fato_exibicao";
DROP TABLE IF EXISTS stg."dim_participa";
CREATE  TABLE stg."dim_participa" (
	`id_particip` INTEGER PRIMARY KEY AUTOINCREMENT,
	`nome_artista`	TEXT,
	`codfilme` INTEGER ,
	`genero`	TEXT,
	`nome_filme` TEXT,
	`papel`	TEXT,
	`rank`	NUM
);


-- CRIANDO A DIMENSAO TEMPO
DROP TABLE if  EXISTS stg."fato_exibicao";
DROP TABLE IF EXISTS stg."dim_tempo";
CREATE TABLE stg."dim_tempo" (
	`data`	DATE,
	`mes_nome`	TEXT,
	`mes_abreviado`	TEXT,
	`dia`	BIGINT,
	`mes`	BIGINT,
	`ano`	BIGINT,
	`semana`	BIGINT,
	`dia_da_semana`	BIGINT,
	`dia_da_semana_nome`	TEXT,
	`dia_do_ano`	BIGINT,
	`trimestre`	BIGINT,
	`semestre`	INTEGER,
	`final_de_semana`	INTEGER,
	`feriado`	BIGINT,
	`dia_util`	INTEGER,
	`data_completa`	TEXT,
	`id_tempo`	 INTEGER PRIMARY KEY AUTOINCREMENT
);


-- CRIANDO A FATO EXIBIÇÃO
DROP TABLE IF EXISTS stg."fato_exibicao";
CREATE TABLE stg."fato_exibicao" (
	`id_exibit` INTEGER PRIMARY KEY AUTOINCREMENT,
	`cod_particip` INTEGER ,
	`cod_sala` INTEGER ,
	`cod_tempo` INTEGER,
	`data` DATE,
	`publico`	INTEGER,
	`arrecad`	DECIMAL ( 10 , 2 ),
	FOREIGN KEY(cod_particip) REFERENCES dim_participa(id_particip),
	FOREIGN KEY(cod_sala) REFERENCES dim_sala(id_sala),
	FOREIGN KEY(cod_tempo) REFERENCES dim_tempo(id_tempo)
);
