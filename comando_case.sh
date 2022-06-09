#!/usr/bin/zsh
MinhaFuncao() {

	case $1 in
		10) echo "é 10";;
		9) echo "é 9";;
		7|8) echo "é 7 ou 8";;
		*) echo "é menor que 6 ou maior que 10";;
	esac

}

MinhaFuncao $1
