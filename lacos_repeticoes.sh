#!/usr/bin/zsh

#for runlevel in 0 1 2 3 4
	#do
	   #mkdir rc${runlevel}.d
	   #echo "Criando o runlevel de inicialização rc$runlevel.d"
	#done
	
	
_INPUT_STRING="Olá"

while [[ "$_INPUT_STRING" != "tchau" ]]
	do
	  echo "VocÊ deseja ficar aqui?"
	  read _INPUT_STRING
	  
		if [[ $_INPUT_STRING = "tchau" ]]; then
	  
	  	   echo "Você disse tchau, saindo"
	  
	  	else
	  	   echo "Você ainda deseja ficar aqui"
	  	fi
	  	
	  
	done
	
while :
	do
	  echo "Você deseja continuar?"
	  read _INPUT_STRING
	  
	  if [[ $_INPUT_STRING != "tchau" ]]; then
	  	continue
	  	
	  else
	  	break
	  	
	  fi
	  
done	  
