#!/usr/bin/env bash
#
# DESCRIÇÃO: Script lê página da web no terminal e lista imagens e links para acesso
# SINOPSE: visualiza_sites.sh [OPÇÕES]
# -e <PARÂMETRO>
# endereço WEB do site para exibição.
# EXEMPLO: ./visualiza_sites.sh google.com 
#
# VERSÃO: 0.1
#

######################################################################################3

funcaoColeta() {

echo ""
echo "começando a montagem da página..."

#echo "valor passado por parametro $1"
#Uso o comando wget em modo discreto para recolher os dados da página e salva em arquivo
wget $1 -q -O - > conteudoPagina.txt

echo ""
echo "Página montada. O que gostaria de fazer agora?"
echo ""
echo ""

echo "OPÇÕES:"
echo ""

echo "1 - Ler a página"
echo "2 - Ver os links"
echo "3 - Baixar imagens"
echo "4 - SAIR"

read escolha

case $escolha in
1)
#pega o conteudo e faz a primeira tratativa retirando as tag e trazendo o texto puro
echo "==========================================================================" > conteudoPaginaMontada.txt
echo "CONTEÚDO DA PÁGINA" >> conteudoPaginaMontada.txt
echo "" >> conteudoPaginaMontada.txt
sed 's/<[^>]*>//g;/^[[:space:]]*$/d;s/<script.*<\/script>//g;/<script/,/<\/script>/{/<script/!{/<\/script>/!d}};s/<script.*//g;s/.*<\/script>//g;s/<style.*<\/style>//g;/<style/,/<\/style>/{/<style/!{/<\/style>/!d}};s/<style.*//g;s/.*<\/style>//g' conteudoPagina.txt | sed  '/^.*{/d;/^.*}/d;/.*\;/d' | tr -s '\t' ' ' >> conteudoPaginaMontada.txt
echo "" >> conteudoPaginaMontada.txt

more conteudoPaginaMontada.txt;;

2)
#pega os links e mostra em tela
echo "==========================================================================" > conteudoPaginaMontada.txt
echo "LINKS DISPONÍVEIS NA PÁGINA" >> conteudoPaginaMontada.txt
echo "" >> conteudoPaginaMontada.txt
egrep -oi '<a [^>]+>' conteudoPagina.txt | egrep -oi 'href="[^\"]+"' | egrep -oi '(http|https)://[^/"]+' >> conteudoPaginaMontada.txt
echo "" >> conteudoPaginaMontada.txt
more conteudoPaginaMontada.txt;;

3)
#lista as imagens disponíveis e baixa
#echo "==========================================================================" > conteudoPaginaMontada.txt
#echo "LINKS DAS IMAGENS DISPONÍVEIS NA PÁGINA" >> conteudoPaginaMontada.txt

egrep -oi "(url\(|src=)['\"]?[^)'\"]*" conteudoPagina.txt | egrep -oi "[^\"'(]*.(jpg|png|gif)" > conteudoPaginaMontada.txt
#echo "" >> conteudoPaginaMontada.txt
#more conteudoPaginaMontada.txt;;

lista=()

while read linha
	do
	  [[ "$linha" != '' ]] && lista+=("$linha")
	done < conteudoPaginaMontada.txt
	
for i in "${!lista[@]}"
	do
	  echo "Índice: $i --> ${lista[i]}"
	done
	
echo "Digite o índice da imagem que gostaria de baixar"
read indiceImagem

echo "Baixando imagem..."

wget -q $@${lista[$indiceImagem]}

echo "imagem salva na pasta!";;

#echo $@${lista[0]}
#echo ${lista[0]};;

4)
echo "Saindo..."
exit;;

*)
echo "Opção inválida. Tente novamente!"
exit;;
esac









}

#######################################################################################


_RETORNO="s"
#seto na variável a quantidade de parmetros passados
endereco=$#

while [[ "$_RETORNO" != "n" ]]
	do

	echo ""
	echo "Exibição de site no terminal"
	echo ""
	#Abaixo eu verifico a qtde de parametros, se tiver algum faz a consulta, se nao tiver pede o parametro
	if [[ $endereco = 0 ]]; then

   		echo "Você não passou um endereço, digite agora o endereço..: "
   		read endereco
	else
   	#se tiver passado um parametro, ele será consultado
   	endereco=$1

	fi

	echo "Endereço a ser consultado..: $endereco"

	echo "Verificando se é um endereço válido..."

	wget -q --spider $endereco

	#acima raspo o endereco de modo discreto 0 tá acessível
        #abaixo vejo se o retorno do comando acima é 0, site acessivel

	if [[ $? != "0" ]]; then

   		echo "O endereço digitado $endereco não é válido. Verifique a digitação e tente novamente."
   		exit

	else 

		echo "O endereço é válido!"

		funcaoColeta $endereco
		
		#zero a variavel pra recomecar
		endereco=0
	  
	  	echo ""
	  	echo ""
	  	echo "==============================================================================================="
	  	echo "==============================================================================================="
	  	echo "Você deseja consultar outro site? [s|n]"
	  	read _RETORNO
	  	

	  	

	  
		if [[ $_RETORNO = "n" ]]; then
	  
	  	   echo ""
	  	   echo "Finalizando..."
	  	   exit
	  
	  
	  	fi
	  	
	  fi	
	  
	done
	
