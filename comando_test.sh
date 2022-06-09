#!/usr/bin/zsh
test 1 = 1; echo $? # 0 verdadeiro
test 1 = 2; echo $? # falso

#testar se o arquivo meuscript existe
test -e meuscript.sh; echo $?
#testar se o arquivo é um arquivo normal
test -f  meuscript.sh; echo $?
#testa se é um diretorio
test -d meuscript.sh; echo $?

#O IF pode testar um comando. Podemos usar o if em conjunto com o test
MinhaFuncao(){
VARIAVEL=$1 #pega o parametro passado
if test "$VARIAVEL" -gt 10 #greater than -> maior que
	then
	    echo "é maior que 10"
elif [[ "$VARIAVEL" -eq 10 ]];
	then
	echo "é igual a 10"	    
else
	    echo "É menor que 10"	    
   
fi	    	    
}

MinhaFuncao $1 #o que mandar ele calcula

#Os [] são alias para o comando test. Usar dois pares
