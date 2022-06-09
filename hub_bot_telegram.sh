#!/bin/bash

: <<'COMENTARIO'

VERSÃO DO SCRIPT 0.1 (BETA) CRIADO POR VALDEMIR BEZERRA PARA O DTC NE - 09/06/2022

A função desse script é receber por parâmetros:
1-> O caminho do(s) ID(s) dos responsáveis por receber o PGP
2-> Assunto da mensagem do PGP 
3-> O texto do STATUS DO PGP propriamente dito
4-> Caminho do log de erros

*** ATENÇÃO ***

A passagem de parâmetros na ordem inválida a descrita irá ocasionar erro na execução do mesmo.

COMENTARIO

#TOKEN do BOT pgp_vigia_bot
TOKEN_BOT="YOUR_TOKEN_HERE"

#caminho absoluto do mailing das mensagens
ARQUIVO_MAILING_ID_TG=$1
#Assunto
ASSUNTO_PGP=$2
#Texto do PGP
TEXTO_PGP=$3
#Caminho absoluto do log de erros
LOG_ERRO=$4


if [[ $# -ne 4 ]]; then

echo -e "\n\nErro na execução do script! Para o mesmo rodar, é mandatário a passagem de 3 parâmetros nas seguintes posições:\n\n1-> O caminho do(s) ID(s) dos responsáveis por receber o PGP\n2-> Assunto da mensagem do PGP\n3-> O texto do STATUS DO PGP propriamente dito\n4-> Caminho do log de erros\n\nA passagem de parâmetros na ordem inválida a descrita irá ocasionar erro na execução do mesmo."

exit 0

fi

while IFS= read -r linha
do
   #pega o primeiro item da linha do arquivo de mailing e usa só se nao estiver comentado e nem vazio
   ID_TG=`echo "$linha" | cut -d':' -f1 | egrep -v "#.*"`;
   
   if [[ ! -z $ID_TG ]]; then
   
      curl --silent -X POST --data-urlencode "chat_id=$ID_TG" --data-urlencode "text=Assunto: $ASSUNTO_PGP&#10;$TEXTO_PGP" "https://api.telegram.org/bot$TOKEN_BOT/sendMessage?disable_web_page_preview=true&parse_mode=html" | grep -q '"ok":true,'
      
      #se o resultado do comando nao for zero, deu erro. Salva no log passado por parametro
      if [[ $? -ne 0 ]]; then
         
         NOME_USUARIO=$(echo "$linha" | cut -d':' -f2);
         
         echo "Ocorreu um erro no envio do PGP para o usuário/grupo: $NOME_USUARIO. Favor verificar!" >> $LOG_ERRO
         
      fi
   
   fi
   
done < "$ARQUIVO_MAILING_ID_TG"

exit 0
