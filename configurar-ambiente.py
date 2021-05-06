import sqlite3

print ('Configurando ambiente...\n')

path = '/home/elson/projeto-etl'
path_extracao = '%s/src/1_extracao.sql' % path
path_transformacao = '%s/src/2_transformacao.sql' % path
path_carga = '%s/src/3_carga.sql' % path
path_distrib_stg = '%s/data/distrib_stg.db' % path

with open(path_extracao, 'r') as script_extracao:
    script_extracao = script_extracao.read()

with open(path_transformacao, 'r') as script_transformacao:
    script_transformacao = script_transformacao.read()

with open(path_carga, 'r') as script_carga:
    script_carga = script_carga.read()

db = sqlite3.connect(path_distrib_stg)
cursor = db.cursor()

print ('Iniciando Extração')
cursor.executescript(script_extracao)

print ('Iniciando Transformação')
cursor.executescript(script_transformacao)

print ('Iniciando Carga \n')
cursor.executescript(script_carga)
db.commit()
db.close()

print ('Ambiente Configurado com Sucesso!')