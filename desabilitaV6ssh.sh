#!/bin/bash

################################################
#                                              #
#  APLICATIVO PARA ALTERAR O MODO DE OPERAÇÃO  #
#  DOS EMTA'S, SÓ IPV4 OU IPV4+IPV6.           #
#                                              #
#  UTILIZANDO IP DE CABLE E SNMP               #
#                                              #
#  DESENVOLVIDO POR VANDERLAN E VALDEMIR       #
#  NET JOÃO PESSOA                             #
################################################

#LIMPA TELA E ALTERA VARIÁVEL DO LAÇO
clear
ENQUANTO=s

#IDENTIFICAÇÃO DE USUÁRIO
select USUARIO in user1 user2 user3 user4
   do
     echo "Bem vindo $USUARIO"
     break;
   done

#LAÇO DE REPETIÇÃO DO PROGRAMA
while [ $ENQUANTO != n ]

do
#REDEFINE VARIÁVEIS A CADA REPETIÇÃO
ALTERA_MODE=n
VERIFICA_OID=""
OID=""
MODE=""
IP_CABLE=""
VENDOR=""
COMANDO=""
DATA=$(date +%d/%m/%Y-%T)

#INTERAÇÃO COM O USUÁRIO
echo ""
echo "DIGITE O IP DE CABLE..:"
read IP_CABLE
echo ""

#CONSULTA VENDOR/MODELO DO EMTA
VENDOR=`snmpget -v2c -c public $IP_CABLE .1.3.6.1.2.1.1.5.0`
VENDOR=$(echo "$VENDOR" | cut -d" " -f 4)
echo $VENDOR

#VERIFICA O MODO DE OPERAÇÃO ATUAL PARA A TOMADA DE DECISÃO DO USUÁRIO
##EMTA PACE E HUMAX##
if [ "$VENDOR" = "C6500" ] || [ "$VENDOR" = "Humax" ]; then
      OID=".1.3.6.1.4.1.4413.2.2.2.1.7.1.4.0"
      VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
      VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
      if [ "$VERIFICA_OID" = "4" ]; then
            echo "Equipamento trabalhando em Dual Mode. Gostaria de Alterar? [s/n]"
            read ALTERA_MODE
            MODE=2
      else
            echo "Equipamento trabalhando em V4 Mode. Gostaria de Alterar?  [s/n]"
            read ALTERA_MODE
            MODE=4
                fi
fi

##EMTA VENDOR SAGEMCOM##
if [ "$VENDOR" = "FAST3184" ]; then
      OID=".1.3.6.1.4.1.4413.2.2.2.1.7.1.4.0"
      VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
      VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
      if [ "$VERIFICA_OID" = "4" ]; then
            echo "Equipamento trabalhando em Dual Mode. Gostaria de Alterar? [s/n]"
            read ALTERA_MODE
            MODE=5
      else
            echo "Equipamento trabalhando em V4 Mode. Gostaria de Alterar?  [s/n]"
            read ALTERA_MODE
            MODE=4
      fi
fi

##EMTA VENDOR SAGEMCOM##
if [ "$VENDOR" = "FAST3284" ] || [ "$VENDOR" = "FAST3486AC" ]; then
      OID=".1.3.6.1.4.1.4413.2.2.2.1.7.1.4.0"
      VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
      VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
      if [ "$VERIFICA_OID" = "5" ]; then
            echo "Equipamento trabalhando em Dual Mode. Gostaria de Alterar? [s/n]"
            read ALTERA_MODE
            MODE=4
      else
            echo "Equipamento trabalhando em V4 Mode. Gostaria de Alterar?  [s/n]"
            read ALTERA_MODE
            MODE=4
      fi
fi

##EMTA VENDOR PACE##
if [ "$VENDOR" = "DWG874" ] || [ "$VENDOR" = "DWG850-4" ]; then
      OID=".1.3.6.1.4.1.4413.2.2.2.1.7.1.4.0"
      VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
      VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
      if [ "$VERIFICA_OID" = "4" ]; then
            echo "Equipamento trabalhando em Dual Mode. Gostaria de Alterar? [s/n]"
            read ALTERA_MODE
            MODE=3
      else
            echo "Equipamento trabalhando em V4 Mode. Gostaria de Alterar?  [s/n]"
            read ALTERA_MODE
            MODE=4
      fi
fi

##EMTA VENDOR ARRIS##
if [ "$VENDOR" = "TG862A" ] || [ "$VENDOR" = "TG1692A" ]; then
      OID=".1.3.6.1.4.1.4115.1.20.1.1.1.17.0"
      VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
      VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
      if [ "$VERIFICA_OID" = "3" ]; then
            echo "Equipamento trabalhando em Dual Mode. Gostaria de Alterar? [s/n]"
            read ALTERA_MODE
            MODE=1
      else
            echo "Equipamento trabalhando em V4 Mode. Gostaria de Alterar?  [s/n]"
            read ALTERA_MODE
            MODE=3
                fi
fi

##EMTA VENDOR CISCO##
if [ "$VENDOR" = "DPC3925" ] || [ "$VENDOR" = "DPC3928S" ]; then
      OID=".1.3.6.1.4.1.1429.79.2.1.1.1.0"
      VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
      VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
      if [ "$VERIFICA_OID" = "5" ]; then
            echo "Equipamento trabalhando em Dual Mode. Gostaria de Alterar? [s/n]"
            read ALTERA_MODE
            MODE=2
      else
            echo "Equipamento trabalhando em V4 Mode. Gostaria de Alterar?  [s/n]"
            read ALTERA_MODE
            MODE=5
      fi
fi

#EXECUÇÃO DO PROGRAMA COM BASE NA DECISÃO DO USUÁRIO
if [ "$ALTERA_MODE" = "s" ]; then
	if [ "$VENDOR" = "TG862A" ] || [ "$VENDOR" = "TG1692A" ]; then
		#Aplica TLV 202.1
		COMANDO=`snmpset -v2c -c public $IP_CABLE .1.3.6.1.4.1.4115.1.20.1.1.1.17.0 i $MODE`
		#Apply Save
		COMANDO=`snmpset -v2c -c public $IP_CABLE .1.3.6.1.4.1.4115.1.20.1.1.9.0 i 1`
		#Reboot
		COMANDO=`snmpset -v2c -c public $IP_CABLE .1.3.6.1.2.1.69.1.1.3.0 i 1`
	else
		#Aplica TLV 202.1
		COMANDO=`snmpset -v2c -c public $IP_CABLE $OID i $MODE`
	fi
fi

#Escreve no Log
echo "$IP_CABLE,$VENDOR,$ALTERA_MODE,$MODE,$DATA,$USUARIO" >> /home/user/Documentos/SCRIPTS/xupaV6-log/log_xupav6_ssh.txt


echo ""
echo "Deseja fazer outro teste? -> [s/n]"
read ENQUANTO

done
