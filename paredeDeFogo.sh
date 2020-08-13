#!/bin/bash

iniciar(){

#permite qualquer navegação internet e comunicação entre os serviços do PC pela loopback
#
#iptables -A INPUT -i lo -j ACCEPT

#Permite nossos ips de casa, acesso remoto.
#iptables -A INPUT -s 127.0.35.92 -p TCP --dport 22 -j ACCEPT
#iptables -A INPUT -s 127.0.244.78 -p TCP --dport 22 -j ACCEPT

#Permite todas as portas de dentro da rede de FRONT para o Desktop
#iptables -A INPUT -s 127.0.0.0/24 -p TCP -j ACCEPT
#iptables -A INPUT -s 127.0.0.0/24 -p UDP -j ACCEPT

#Acesso SSH dos DTC's
#iptables -A INPUT -s 127.0.2.252/32 -p TCP --dport 22 -j ACCEPT
#iptables -A INPUT -s 127.0.2.252/32 -p UDP --dport 22 -j ACCEPT
#iptables -A INPUT -s 127.0.2.253/32 -p TCP --dport 22 -j ACCEPT
#iptables -A INPUT -s 127.0.2.253/32 -p UDP --dport 22 -j ACCEPT
#iptables -A INPUT -s 127.0.2.254/32 -p TCP --dport 22 -j ACCEPT
#iptables -A INPUT -s 127.0.2.254/32 -p UDP --dport 22 -j ACCEPT


#permite acesso da nossa rede de front a porta 80 de fora pra dentro

#iptables -A INPUT -s 127.0.0.0/24 -p TCP --dport 80 -j ACCEPT

#nega qualquer requisição de fora da porta 80
iptables -A INPUT -p TCP --dport 80 -j DROP

#fecha a porta 22 ssh de fora para dentro:
iptables -A INPUT -p TCP --dport 22 -j DROP

#portas abertas identificadas no NMAP
iptables -A INPUT -p TCP --dport 139 -j DROP
iptables -A INPUT -p TCP --dport 445 -j DROP
iptables -A INPUT -p TCP --dport 111 -j DROP
iptables -A INPUT -p UDP --dport 111 -j DROP
iptables -A INPUT -p UDP --dport 5353 -j DROP

echo "A parade tá pegano fogo!"
}

parar(){
####iptables -F
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -t nat -F
/sbin/iptables -t nat -X
/sbin/iptables -t mangle -F
/sbin/iptables -t mangle -X
echo "Regras de firewall desativadas"
}

case "$1" in
"start") iniciar ;;
"stop") parar ;;
"restart") parar; iniciar ;;
*) echo "Use os parâmetros start, stop ou restart..."
esac
