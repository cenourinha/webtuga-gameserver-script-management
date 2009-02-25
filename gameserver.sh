#!/bin/bash
# CONFIGURADOR DE GAMESERVERS WEBTUGA by cenourinha
Principal() {
   clear
echo "================================="
echo "             _"
echo "            | |     _"
echo " _ _ _ _____| |__ _| |_ _   _  ____ _____"
echo "| | | | ___ |  _ (_   _) | | |/ _  (____ |"
echo "| | | | ____| |_) )| |_| |_| ( (_| / ___ |"
echo " \___/|_____)____/  \__)____/ \___ \_____|"
echo "                             (_____|"
echo "================================="

   echo "CONFIGURADOR DE GAMESERVERS WEBTUGA"
   echo "------------------------------------------------- by cenourinha"
   echo "Opções:"
   echo
   echo "1. Iniciar servidor"
   echo "2. Parar servidor"
   echo "3. Fazer Update ao servidor"
   echo "4. Criar cliente"
   echo "5. Sair"
   echo
   echo -n "Qual a opção desejada? "
   read opcao
   case $opcao in
      1) Iniciar ;;
      2) Parar ;;
      3) Update ;;
      4) CriarCliente ;;
      5) clear; echo "Até logo!"; sleep 3s; clear; exit ;;
      *) "Opção desconhecida." ; echo ; Principal ;;
   esac
}
Iniciar() {
clear
echo -n "Iniciar uma GameServer"
echo
sleep 1s
clear
echo "Qual o cliente (username)?"
read user
clear
echo "Qual o nome do servidor?"
read nomeservidor
clear
echo Qual a porta?
read porta
clear
echo Quantas slots?
read slots
if [ $slots -lt 12 ];  then
    clear
    echo "Devera ter no minimo 12 slots"
    read
    Iniciar
fi
clear
echo Qual o mapa?
   echo
   echo "1. de_dust2"
   echo "2. de_dust"
   echo "3. cs_assault"
   echo 
read mapa
   case $mapa in   
      1)
mapa="de_dust2";;
      2)
mapa="de_dust";;
      3)
mapa="cs_assault" ;;
      *) clear; echo "Opção desconhecida." ; echo ; Iniciar ;;
   esac
clear
cd /home/cs/$user
screen -r $user -X quit
screen -dmS $user ./hlds_run -game cstrike +ip 81.92.204.166 +port $porta +maxplayers $slots +exec server.cfg +map $mapa +hostname "$nomeservidor"
echo Servidor iniciado com sucesso!
}

Parar() {
   clear
   echo "Qual o cliente(username)?"
   read user
   clear
   echo -n "Tem a certeza? [y/n] "
   read var
   if [ $var = "y" ]; then
        screen -wipe
        screen -r $user -X quit
        clear
        echo "Server parado com sucesso!"
        sleep 2s
   elif [ $var = "n" ]; then
       Principal
  fi
   Principal
}

CriarCliente() {
clear
echo "Criar cliente"
sleep 1s
clear
echo "Qual username?"
read username
clear
echo "Qual a password?"
read password
clear
echo "Insira a password root"
su --command="useradd -d /home/cs/$username -s /usr/bin/rc -p $password -G cs -m -k /home/cs/server/ $username; chmod 777 /home/cs/$username; exit;" -
clear
echo "Cliente criado com sucesso"
sleep 2s
Principal
}
Update() { 
clear
echo "Qual o cliente(username)?"
read user
clear
echo "A actualizar..."
./steam -command update -game cstrike -dir /home/$USER/$user
sleep 3s
echo "Actualizado com sucesso..."
clear
}
Principal
