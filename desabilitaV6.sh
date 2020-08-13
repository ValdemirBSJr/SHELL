#!/bin/bash


### Interfaces gráficas com o yad :3333

#yad --center

#pega data corrente
DATA=$(date +%d/%m/%Y-%T)

#pegamos o ip do cable
IP_CABLE=$( \
   yad --entry \
        --title="DESABILITA IPV6 - DIGITE O IP DE CABLE" \
        --width=200 \
        --height=200 \
        --entry-label="Ip de CABLE:" \
        --entry-text="0.0.0.0" \
        --sticky --center --timeout=60 \
        --timeout-indicator='left' \

) 

#descobrindo qual o vendor e jogando em uma variável

VENDOR=`snmpget -v2c -c public $IP_CABLE .1.3.6.1.2.1.1.5.0`
VENDOR=$(echo "$VENDOR" | cut -d" " -f 4)

#fazendo a tratativa

if [ "$VENDOR" = "C6500" ] || [ "$VENDOR" = "Humax" ]; then
                OID=".1.3.6.1.4.1.4413.2.2.2.1.7.1.4.0"
                VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
                VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
                if [ "$VERIFICA_OID" = "4" ]; then
                		MENSAGEM="Equipamento trabalhando em Dual Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM [s/n]"
                        #read ALTERA_MODE
                        MODE=2
                else
                        MENSAGEM="Equipamento trabalhando em V4 Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM  [s/n]"
                        #read ALTERA_MODE
                        MODE=4
                fi
fi

if [ "$VENDOR" = "FAST3284" ] || [ "$VENDOR" = "FAST3184" ]; then
                OID=".1.3.6.1.4.1.4413.2.2.2.1.7.1.4.0"
                VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
                VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
                if [ "$VERIFICA_OID" = "4" ]; then
                		MENSAGEM="Equipamento trabalhando em Dual Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM [s/n]"
                        #read ALTERA_MODE
                        MODE=5
                else
                        MENSAGEM="Equipamento trabalhando em V4 Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM  [s/n]"
                        #read ALTERA_MODE
                        MODE=4
                fi
fi
if [ "$VENDOR" = "TG862A" ] || [ "$VENDOR" = "TG1692A" ]; then
                OID=".1.3.6.1.4.1.4115.1.20.1.1.1.17.0"
                VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
                VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
                if [ "$VERIFICA_OID" = "3" ]; then
                		MENSAGEM="Equipamento trabalhando em Dual Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM [s/n]"
                        #read ALTERA_MODE
                        MODE=1
                else
                        MENSAGEM="Equipamento trabalhando em V4 Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM  [s/n]"
                        #read ALTERA_MODE
            			MODE=3
                fi
fi
if [ "$VENDOR" = "DPC3925" ] || [ "$VENDOR" = "DPC3928S" ]; then
                OID=".1.3.6.1.4.1.1429.79.2.1.1.1.0"
                VERIFICA_OID=`snmpget -v2c -c public $IP_CABLE $OID`
                VERIFICA_OID=$(echo "$VERIFICA_OID" | cut -d" " -f 4)
                if [ "$VERIFICA_OID" = "5" ]; then
                		MENSAGEM="Equipamento trabalhando em Dual Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM [s/n]"
                        #read ALTERA_MODE
                        MODE=2
                else
                        MENSAGEM="Equipamento trabalhando em V4 Mode. Gostaria de Alterar?"
                        #echo "$MENSAGEM [s/n]"
                        #read ALTERA_MODE
            			MODE=5
                fi
fi


#mostro os resultados da coleta. Caso clique em fazemos a mágika!!!
yad --title="Ip consultado: $IP_CABLE" \
	--text="Vendor: $VENDOR. $MENSAGEM" \
	--sticky --center \
	--width=300 \
    --height=200 \
    --button='SIM':1 --button='não':0 \

 #yad --title="$?" \

 #pega a escolha
ALTERA_MODE="$?"


#caso escolha sim, faz a mágika
if [ "$ALTERA_MODE" = "1" ]; then
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

#mostra mensagem
	yad --title="Ip do Equipamento: $IP_CABLE" \
	--text="Retorno do comando aplicado: $COMANDO" \
	--sticky --center \
	--width=400 \
    --height=200 \


#Escreve no Log
echo "$IP_CABLE,$VENDOR,$ALTERA_MODE,$MODE,$DATA,Interface_grafica" >> /home/user/Documentos/SCRIPTS/xupaV6-log/log_xupav6_ssh.txt

else

	yad --title="NADA FEITO!" \
	--text="Adiós,mi patrón!!!" \
	--sticky --center \
	--width=400 \
    --height=200 \


fi





#.EOF
