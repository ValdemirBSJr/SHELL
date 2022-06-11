#!/usr/bin/env bash

# DESCRIÇÃO: meu script - Mostra como usar do iniciante ao avançado
# SINOPSE: parametros.sh [OPÇÕES]
# USO/EXEMPLO ./parametros.sh -h
#	      ./parametros.sh --help
# OPÇÕES: -h --help
# Mostra a ajuda do programa
#
# -u --user
# Mostra o usuário
#
# -b <PARAMETRO>
# Retorna o parametro digitado
#
# -c
# Retorna o valor que tá setado nele (1) 
#	  
# -u
# Retorna o usuário atual
#
# AUTOR: Valdemir
# VERSÃO: 0.0.0.1

while getopts h{help}b:u{user}:-c-- OPCAO; do
	case "${OPCAO}" in
	   h|help) opcao_h=1 ;;
	   b) parametro_b="${OPTARG}" ;;
	   c) recebi_c=1 ;;
	   u|user) recebe_u=$(echo $USER)
	   
	esac
done

[ ${opcao_h} ] && sed -n '/^# /p' $0 | sed 's/# //g';
[ ${parametro_b} ] && echo "O parâmetro de -b é: ${parametro_b}";
[ ${recebi_c} ] && echo "A opção c existe e o valor é: ${recebi_c}";
[ ${recebe_u} ] && echo "O usuário logado é: ${recebe_u}";

exit 0  	  
