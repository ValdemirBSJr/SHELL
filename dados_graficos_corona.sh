#!/usr/bin/env bash

#DEPENDENCIAS:
# pip3 install termgraph >>> Para gerar os gráficos
#
#
# sudo apt-get install -y jq >>> PAra tratar os dados json via terminal
#
# curl 'https://corona.lmao.ninja/countries?sort=deaths'
#

# PEgo os dados em formato json

curl --silent 'https://corona.lmao.ninja/v3/covid-19/countries' > covid-mortes.json

#pegar os 10 primeiros paises e mando pro arquivo 

jq '.[:10][] | "\(.country);\(.deaths);\(.recovered)"' covid-mortes.json | tr -d \" > input-termgraph.dat

#fazendo o termgraph gerar os gráficos

termgraph --delim ';' --title 'Países com maior casos de mortes por COVID-19'  input-termgraph.dat | sed 's/\.00$//'

#curl 'https://corona.lmao.ninja/v3/covid-19/countries/brazil'
#termgraph --delim ';' --title 'Países com maior casos de mortes por COVID-19' input-termgraph.dat --space-between | sed 's/\.00$//'
