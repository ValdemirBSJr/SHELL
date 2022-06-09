#!/usr/bin/zsh
echo "Olá mundo!"

: <<'COMENTARIO'
olouquinho meu
lalala
COMENTARIO

TEXTO="Marrapais..."
echo $TEXTO

EXPANSAO_VARIAVEL=$(echo "VAriavel expandida em subshell" | cut -f1 -d" ") #roda comando em segundo plano
echo $EXPANSAO_VARIAVEL #tras o resultado do comando executado

TRAVA_LINGUA=$(echo t{r,igr,rist}es)
echo $TRAVA_LINGUA

#arrays
MUNDO=("Shell script" "bash" "GNU" "Linux" "Debian")
echo ${MUNDO[1]}

echo ${#MUNDO[@]} #conta os elementos

echo ${MUNDO[*]} #exibe os elementos

echo ${MUNDO[@]:3} #exibe do elemento 3 ao final

echo ${MUNDO[@]:1:3} #exibe do primeiro ao terceiro

#deletar todo o array -> unset MUNDO
#deletar uma posição no array -> unset MUNDO[2]

echo "O array MUNDO possui ${#MUNDO[@]} elementos"

MinhaFuncao(){

local variavel_local="Nao posso ser chamada fora da funcao"
echo "Estou passando $# parametros"
echo "PArametros: $@"

}

MinhaFuncao $@

echo $variavel_local #Nao retorna nada pois a variavel é só da funcao

declare -r MInhaConstante="Variavel constante"

cd(){

echo "Função que recebe o nome de $@ diretórios"

}

#para usar o comando cd e não a função cd temos que fazer:
builtin cd Imagens/
ls
