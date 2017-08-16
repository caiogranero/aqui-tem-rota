# aqui-tem-rota 

CodeClimate badge: [![codeclimate](https://codeclimate.com/github/caiogranero/aqui-tem-rota/badges/gpa.svg)](https://codeclimate.com/github/caiogranero/aqui-tem-rota)

Aplicação web desenvolvida com base nos dados no padrão GTFS disponibilizados pela SPTrans a respeito do transporte público da cidade de São Paulo.

## Dependencias

* postgis: `sudo apt-get install postgis`
* postgresql

## Baixando e rodando

```
git clone git@github.com:caiogranero/aonde-vou.git
cd rake_database
bundle install
rake gtfs:import
```

Executando `rake gtfs:import`, todos os dados fornecidos pela SPTrans no padrão GTFS serão instalados em seu banco de dados local.

## Por que PostgreSQL?

Por padrão, [PostgreSQL][postgresql] tem suporte para dados do tipo geométricos, e além disso tem uma extensão que se chama [PostGIS][postgis] que incrementa essas funcionalidades permitindo que atributos com posições geométricas serem usadas em consultas SQL.

Essa extensão também tem suporte para o [Ruby On Rails][ruby-on-rails] que é feito com a [gem activerecord-postgis-adapter][activerecord-postgis-adapter]

Obs: No MySQL 5.7.8 e no MariaDB 5.3.3 também se tornou possível a manipulação de dados do tipo geométrico nos respectivos SGBD, entretando, para realizar a inserção desses dados, é necessário ser feita a conversão deles breviamente, diferente do PostgreSQL.

## Links úteis

https://www.postgresql.org/docs/9.5/static/functions-geometry.html

https://www.postgresql.org/docs/9.4/static/datatype-geometric.html

https://www.compose.com/articles/what-postgresql-has-over-other-open-source-sql-databases/

http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS23UbuntuPGSQL96Apt

http://postgis.net/docs/manual-2.1/using_postgis_dbmanagement.html#PostGIS_Geography

https://www.postgresql.org/docs/9.5/static/functions-geometry.html

https://gis.stackexchange.com/questions/24486/inserting-point-into-postgishttps://gis.stackexchange.com/questions/24486/inserting-point-into-postgis

[postgresql]: https://www.postgresql.org/
[postgis]: http://postgis.net/
[ruby-on-rails]: http://rubyonrails.org/
[activerecord-postgis-adapter]: https://github.com/rgeo/activerecord-postgis-adapter