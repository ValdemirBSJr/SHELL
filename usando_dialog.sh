#!/usr/bin/env bash
#DEPENDENCIAS
# #apt install dialog

dialog --msgbox 'Meu primeiro programa com o Dialog SHELL. Olá mundo!' 5 50
# 5 => altura | 50 largura

# sh -vx ./script.sh PRA DEPURAR CODIGO. ELE TRAS MAIS INFORMAÇÕES DO ERRO
# sh -n ./script.sh PROCURA ERRO DE SINTAXE MAS NAO EXECUTA
# sh -x ./script.sh MOSTRA AS LINHAS QUE ESTA EXECUTANDO
# sh -v ./script.sh MOSTRA A LINHA ATUAL

while true ;

	do
	
	distros=$(dialog --stdout --title "Escolha sua distro" --menu "Qual a sua distro preferida?" 0 0 0 \
				1 "Debian"    \
				2 "REd Hat"   \
				3 "Gentoo"    \
				4 "Slackware" \
				5 "Ubuntu"    \
				0 "sair"    )
				
	[ $? -ne 0 ] && echo "Cancelou ou Apertou ESC." && break
	
		case "$distros" in
		 1) dialog --stdout --msgbox "Essa é a melhor distro! :) (SQN)" 5 30 ;;
		 2) dialog --title "Red Hat" --infobox "\nEla agora é enterprise :(" 5 30; break ;;
		 3) dialog --title "Gentoo" --msgbox "\nVocÊ gosta de sofrer, viu!" 5 25 ;;
		 4) dialog --title "SLACKWARE" --yesno "VocÊ é ATEU?" 5 70;
			 if [ $? = 0 ]; then
				 dialog --title "Slackware Ateu" --infobox "\nSabia!" 0 0;
			 else
				 dialog --title "Slackware não ateu" --infobox "\nAmarelou" 0 0;
				 
			fi
		break ;;
		
		 5) dialog --title "Ubuntu" --timebox "\nTão foda que vou registrar a hora que você falou essa lindeza" 0 0; break ;;
		 0) echo "VocÊ escolheu sair" ; break ;;
	
		esac
	
	done
