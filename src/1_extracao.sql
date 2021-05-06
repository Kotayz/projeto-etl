ATTACH database '/home/elson/projeto-etl/data/distrib_oltp.db' as oltp;
ATTACH database '/home/elson/projeto-etl/data/distrib_stg.db' as stg;


-- CRIANDO E POPULANDO A TABELA stg_participa
DROP TABLE if  EXISTS stg."stg_participa";
CREATE TABLE stg."stg_participa" (
	`codartista`	INT,
	`codfilme`	TEXT,
	`papel`	TEXT,
	`rank`	NUM
);
INSERT INTO stg."stg_participa"
SELECT * FROM oltp.partic;

-- CRIANDO E POPULANDO A TABELA stg_genero
DROP TABLE if  EXISTS stg."stg_genero";
CREATE TABLE stg."stg_genero" (
	`num`	integer,
	`nome`	text,
	PRIMARY KEY(`num`)
);
INSERT INTO stg."stg_genero"
SELECT * FROM oltp.genero;

-- CRIANDO E POPULANDO A TABELA stg_filmedesc
DROP TABLE if  EXISTS stg."stg_filmedesc";
CREATE TABLE stg."stg_filmedesc" (
	`num`	INT,
	`desc`	TEXT
);
INSERT INTO stg."stg_filmedesc"
SELECT * FROM oltp.filmedesc;

-- CRIANDO E POPULANDO A TABELA stg_filme
DROP TABLE if  EXISTS stg."stg_filme";
CREATE TABLE stg."stg_filme" (
	`codfilme`	INT,
	`nome`	TEXT,
	`genero`	TEXT,
	PRIMARY KEY(`codfilme`)
);
INSERT INTO stg."stg_filme"
SELECT * FROM oltp.filme;

-- CRIANDO E POPULANDO A TABELA stg_exibe
DROP TABLE if  EXISTS stg."stg_exibe";
CREATE TABLE stg."stg_exibe" (
	`codexibe`	integer,
	`data`	date,
	`codsala`	integer,
	`codfilme`	integer,
	`publico`	integer,
	`arrecad`	decimal ( 10 , 2 ),
	PRIMARY KEY(`codexibe`)
);
INSERT INTO stg."stg_exibe"
SELECT * FROM oltp.exibt;

-- CRIANDO E POPULANDO A TABELA stg_cidade
DROP TABLE if  EXISTS stg."stg_sala"; -- TEM QUE SER APAGADA ANTES DE LOCAL POR CAUSA DA FK
DROP TABLE if  EXISTS stg."stg_local"; -- TEM QUE SER APAGADA ANTES DE CIDADE POR CAUSA DA FK
DROP TABLE if  EXISTS stg."stg_cidade";
CREATE TABLE stg."stg_cidade" (
	`codcidade`	integer,
	`nome`	text,
	`codestado`	integer,
	PRIMARY KEY(`codcidade`)
);
INSERT INTO stg."stg_cidade"
SELECT * FROM oltp.cidade;

-- CRIANDO E POPULANDO A TABELA stg_estado
DROP TABLE if  EXISTS stg."stg_estado";
CREATE TABLE stg."stg_estado" (
	`codestado`	integer,
	`nome`	text,
	`codregiao`	integer,
	PRIMARY KEY(`codestado`)
);
INSERT INTO stg."stg_estado"
SELECT * FROM oltp.estado;

-- CRIANDO E POPULANDO A TABELA stg_pais
DROP TABLE if  EXISTS stg."stg_pais";
CREATE TABLE stg."stg_pais" (
	`codpais`	integer,
	`nome`	text,
	PRIMARY KEY(`codpais`)
);
INSERT INTO stg."stg_pais"
SELECT * FROM oltp.pais;

-- CRIANDO E POPULANDO A TABELA stg_regiao
DROP TABLE if  EXISTS stg."stg_regiao";
CREATE TABLE stg."stg_regiao" (
	`codregiao`	integer,
	`nome`	text,
	`codpais`	integer,
	PRIMARY KEY(`codregiao`)
);
INSERT INTO stg."stg_regiao"
SELECT * FROM oltp.regiao;

-- CRIANDO E POPULANDO A TABELA stg_cinema
DROP TABLE if  EXISTS stg."stg_cinema";
CREATE TABLE stg."stg_cinema" (
	`codcinema`	integer,
	`nome`	text,
	PRIMARY KEY(`codcinema`)
);
INSERT INTO stg."stg_cinema"
SELECT * FROM oltp.cinema;

-- CRIANDO E POPULANDO A TABELA stg_artista
DROP TABLE if  EXISTS stg."stg_artista";
CREATE TABLE stg."stg_artista" (
	`codartista`	integer,
	`nome`	text,
	PRIMARY KEY(`codartista`)
);
INSERT INTO stg."stg_artista"
SELECT * FROM oltp.artista;

-- CRIANDO E POPULANDO A TABELA stg_local
DROP TABLE if  EXISTS stg."stg_local";
CREATE TABLE IF NOT EXISTS stg."stg_local" (
	`codlocal`	INT,
	`nomelocal`	TEXT,
	`codcidade`	INT,
	`codestado`	INT,
	`codregiao`	INT,
	`codpais`	INT,

	PRIMARY KEY(`codlocal`)
	FOREIGN KEY(codcidade) REFERENCES stg_cidade(codcidade)
	FOREIGN KEY(codestado) REFERENCES stg_estado(codestado)
	FOREIGN KEY(codregiao) REFERENCES stg_regiao(codregiao)
	FOREIGN KEY(codpais) REFERENCES stg_pais(codpais)
);
INSERT INTO stg."stg_local"
SELECT * FROM oltp.local;

-- CRIANDO E POPULANDO A TABELA stg_sala
DROP TABLE if  EXISTS stg."stg_sala";
CREATE TABLE IF NOT EXISTS stg."stg_sala" (
	`codsala`	integer,
	`codlocal`	integer,
	`capacidade`	integer,
	`codcinema`	integer,
	PRIMARY KEY(`codsala`),
	FOREIGN KEY(codlocal) REFERENCES stg_local(codlocal)
);
INSERT INTO stg."stg_sala"
SELECT * FROM oltp.sala;
