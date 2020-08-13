#!/bin/bash

echo "Estamos pingando para o o ip 127.0.0.2 do terminal de bancada B42A.0E18.9063. Caso o ip ou MAC mude, alterar script....."

if ! ping -c 5 127.0.0.2 >logg; then
echo "Internet down!!!"
else
echo "Internet ok !!!"
exit 1
fi
exit
