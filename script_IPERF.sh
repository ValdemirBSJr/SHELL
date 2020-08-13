#!/bin/bash
echo "
     ████████╗███████╗███████╗████████╗███████╗    
     ╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝██╔════╝    
        ██║   █████╗  ███████╗   ██║   █████╗      
        ██║   ██╔══╝  ╚════██║   ██║   ██╔══╝      
        ██║   ███████╗███████║   ██║   ███████╗    
        ╚═╝   ╚══════╝╚══════╝   ╚═╝   ╚══════╝    
                                              
        ██╗██████╗ ███████╗██████╗ ███████╗           
        ██║██╔══██╗██╔════╝██╔══██╗██╔════╝           
        ██║██████╔╝█████╗  ██████╔╝█████╗             
        ██║██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝             
        ██║██║     ███████╗██║  ██║██║                
        ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     "           
echo "                                              
 

                  +-+-+-+-+-+-+-+  
                  |P|o|w|e|r|e|d|  
                  +-+-+-+-+-+-+-+  
                       |b|y|          
                  +-+-+-+-+-+-+-+-+
                  |N|5|6|6|9|2|0|3|
                  +-+-+-+-+-+-+-+-+ "
echo ""
echo ""

ENQUANTO=s



while [ $ENQUANTO != n ]

do

echo "DIGITE O IP..:"
read IP
echo "DIGITE A VELOCIDADE"
read VELOCIDADE
echo "PARA O TEMPO, DIGITE: [1 - 60s / 2 - 120s] "
read TEMPO
echo ""
echo ""

if [ TEMPO = 1 ]; then
TEMPO=60
else
TEMPO=120
fi

iperf -c"$IP" -b"$VELOCIDADE""M" -t"$TEMPO"

echo ""
echo ""
echo "Deseja fazer outro teste? -> [s/n]"
read ENQUANTO

done
