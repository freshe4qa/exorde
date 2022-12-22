#!/bin/bash

while true
do

# Logo

echo -e '\e[40m\e[91m'
echo -e '  ____                  _                    '
echo -e ' / ___|_ __ _   _ _ __ | |_ ___  _ __        '
echo -e '| |   |  __| | | |  _ \| __/ _ \|  _ \       '
echo -e '| |___| |  | |_| | |_) | || (_) | | | |      '
echo -e ' \____|_|   \__  |  __/ \__\___/|_| |_|      '
echo -e '            |___/|_|                         '
echo -e '\e[0m'

sleep 2

# Menu

PS3='Select an action: '
options=(
"Install"
"Run a node"
"Exit")
select opt in "${options[@]}"
do
case $opt in

"Install")
echo "============================================================"
echo "Install start"
echo "============================================================"

# set vars
if [ ! $CONTAINER_NAME ]; then
	read -p "Enter container name: " $CONTAINER_NAME
	echo 'export CONTAINER_NAME='$CONTAINER_NAME >> $HOME/.bash_profile
fi
if [ ! $ETH_ADDRESS ]; then
	read -p "Enter eth address: " $ETH_ADDRESS
	echo 'export ETH_ADDRESS='$ETH_ADDRESS >> $HOME/.bash_profile
fi
source $HOME/.bash_profile

# update
sudo apt update && sudo apt upgrade -y

apt install git

apt install apt-transport-https ca-certificates software-properties-common curl

curl -f -s -S -L https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

cd /root

sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

break
;;

"Run a node")

docker run -d --restart unless-stopped --pull always --name $CONTAINER_NAME exordelabs/exorde-cli -m $ETH_ADDRESS -l 3

break
;;

"Exit")
exit
;;
*) echo "invalid option $REPLY";;
esac
done
done
