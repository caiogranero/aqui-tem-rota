aqui-tem-rota 
===================

CodeClimate badge: [![codeclimate](https://codeclimate.com/github/caiogranero/aqui-tem-rota/badges/gpa.svg)](https://codeclimate.com/github/caiogranero/aqui-tem-rota)

Aplicação web desenvolvida com base nos dados no padrão GTFS disponibilizados pela SPTrans a respeito das rotas de ônibus da cidade de São Paulo, disponível em [aquitemrota.tk]

Desenvolvido como trabalho de conclusão de curso em Sistemas de Informação pela EACH-USP por: [Caio Granero][caiogranero] e [Prof. Dr. Daniel Cordeiro][cordeiro]

## Introdução

TODO

## Funcionalidades

- [x] Buscar localização atual do usuário
- [x] Opção para centralizar o mapa na localização do usuário
- [x] Exibir todas as rotas após clicar no mapa
- [x] Exibir todas os pontos após clicar no mapa
- [x] Criar um menu lateral com as informações básicas de rotas e pontos de ônibus
- [x] Ao passar o mapa pela descrição da rota, destacar essa rota no mapa
- [x] Ao clicar em um ponto de ônibus no mapa, mostrar apenas as rotas desse ponto
- [ ] Permitir ao usuário alterar o raio de busca
- [ ] Disponibilizar mais informações a respeito das rotas para o usuário
- [ ] Permitir buscar as rotas de um endereço específico

Sugestões de funcionalidades? Crie uma [issue] ou me mande um e-mail: caio.granero@usp.br
## Arquitetura utilizada

Desenvolvido utilizando Node.js, Vue.js, Ruby e PostgreSQL

### PostgreSQL + PostGIS

Por padrão, [PostgreSQL] tem suporte para dados do tipo geométricos. Para dados georreferenciados existe uma extensão para o mesmo que é o [PostGIS], esse incrementa as funcionalidades permitindo que atributos com posições geométricas serem usadas em consultas SQL.

Isso permitiu que fosse possível buscar todas as informações que estão na base de dados referentes a uma distância de um determinado ponto (latitude, longitude).

### Node.js + Express

Para a comunicação entre a aplicação e o banco de dados, foi desenvolvido um projeto em [Node.js] com o framework [Express], aonde é exposto uma API com alguns endpoints que dado determinados parâmetros, ela retorna a informação necessária.

### Vue.js

No desenvolvimento da interface da aplicação, foi utilizado o framework [Vue.js]. Como biblioteca de mapa, foi usado o projeto [Vue2Leaflef] que é uma implementação do [leaflet.js] para o Vue.js.

### Ruby

Para a manipulação e inserção dos dados disponibilizados pela SPTrans, foi desenvolvido um script em Ruby faz todo o serviço de extrair e adicionar no banco de dados já com os dados no formato que o PostGIS utiliza.

## Baixando e rodando

``` bash
# Instalando o node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# Instalando o ruby
sudo apt-get install ruby-full

sudo apt-get install ruby-bundler

# Instalando o PostgreSQL
sudo apt-get install postgresql

# Instalando o PostGIS
sudo apt-get install postgis

# Clonando o repositório
git clone git@github.com:caiogranero/aqui-tem-rota.git

# Para fazer o upload da base de dados no seu banco de dados local, rode:
cd database
bundle install
rake gtfs:import

# Para executar a API em node.js, execute:

cd api
npm run dev

# Para executar o front-end em Vue.js, execute

cp web-app
npm run dev
```

Executando `rake gtfs:import`, todos os dados fornecidos pela SPTrans no padrão GTFS serão instalados em seu banco de dados local.

## TODOs

- [ ] Testes de unidade na api
- [ ] Testes de unidade no web-app
- [ ] Testes de aceitação no web-app
- [ ] Continuar integração com o travis
- [ ] Organizar a área dos links úteis
- [ ] Automatizar o deploy

## Perguntas?

Sugestões, críticas ou dúvidas? Crie uma [issue] ou me mande um e-mail: caio.granero@usp.br  =D

## Links úteis

https://www.postgresql.org/docs/9.5/static/functions-geometry.html

https://www.postgresql.org/docs/9.4/static/datatype-geometric.html

https://www.compose.com/articles/what-postgresql-has-over-other-open-source-sql-databases/

http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS23UbuntuPGSQL96Apt

http://postgis.net/docs/manual-2.1/using_postgis_dbmanagement.html#PostGIS_Geography

https://www.postgresql.org/docs/9.5/static/functions-geometry.html

https://gis.stackexchange.com/questions/24486/inserting-point-into-postgishttps://gis.stackexchange.com/questions/24486/inserting-point-into-postgis

[PostgreSQL]: https://www.postgresql.org/
[PostGIS]: http://postgis.net/
[api-project]: https://github.com/caiogranero/aqui-tem-rota/tree/master/api
[Node.js]: https://nodejs.org/en/
[Express]: http://expressjs.com/pt-br/
[Vue.js]: https://vuejs.org/
[Docker]: http://docker.io/
[Vue2Leaflef]: https://github.com/KoRiGaN/Vue2Leaflet
[leaflet.js]: http://leafletjs.com/
[issue]: https://github.com/caiogranero/aqui-tem-rota/issues
[cordeiro]: https://github.com/cordeiro
[caiogranero]: https://github.com/caiogranero
[aquitemrota.tk]: http://aquitemrota.tk/#/