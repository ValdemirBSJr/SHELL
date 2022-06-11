#!/usr/bin/env bash

#exemplo yad
#
#apt install yad

saida=$(yad --form --image blog-min.png --image-on-top \
	--title "Teste com yad" \
	--text "Exemplo <b>YAD</b> por <big>VALDEMIR</big>" \
	--field Nome "Valdemir" \
	--field Nascimento:DT 09/02/1984 \
	--field "Há quanto usa <b>LINUX</b>:NUM" '1!0..20!1' \
	--field "Sites preferidos:CB" 'Teminal Root!BR-Linux!Dicas-l!VIva o linux!Outros' \
	--field "Vou passar a usar o YAD:CHK" TRUE \
	--field "Vou continuar no ZENITY:CHK")
	${appName}: ${sessionName}
echo $saida
IFS=',' read Nome Nascimento HaQtoTempo Sites Yad Zenity <<< "$saida"
echo $saida
#echo $saida | tr '|' ',' >> saida_yad.csv
