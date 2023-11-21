#!/bin/sh

# SET COLORS
CIANO='\033[1;36m'
FIMCIANO='\033[0m'

VERDE='\033[0;32m'
FIMVERDE='\033[0m'

echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Olá! Este é um script de instalação automatizado para sua VM!"
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Este script irá instalar automaticamente o docker, assim como a criação de um container com uma imagem SQL e a permissão para a execução de um arquivo JAVA de instalação em sua máquina..."
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Deseja continuar? [S/N]"
read choice

if [ "$choice" = "S" ] || [ "$choice" = "s" ]; then

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Iniciando instalação do docker"
    sudo apt install docker.io
    echo -e "${VERDE}Docker instalado.${FIMVERDE}"  

    sleep 5

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Iniciando serviço do docker"
    sudo systemctl start docker
    sudo systemctl enable docker
    echo -e "${VERDE}Docker iniciado.${FIMVERDE}"

    sleep 5

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Baixando a imagem do MySQL 5.7"
    sudo docker pull mysql:5.7
    echo -e "${VERDE}Imagem SQL instalado.${FIMVERDE}"

    # Criando e executando o container docker
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executando/criando container"
    sudo docker run -d -p 3306:3306 --name performee -e "MYSQL_ROOT_PASSWORD=01231153" mysql:5.7
    echo -e "${VERDE}Container criado.${FIMVERDE}"

    sleep 5

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executando script SQL"
    sudo docker exec -i performee mysql -u root -p01231153 < ./Performee-script.sql
    echo -e "${VERDE}Script SQL executado.${FIMVERDE}"

    sleep 5
    clear

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Dando permissão para executar o script JAVA/PYTHON"
    chmod +x java-python-script.sh
    echo -e "${VERDE}Permissão concedida.${FIMVERDE}"

    sleep 5

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executando script JAVA/PYTHON"
    ./java-python-script.sh

    clear
else
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Você não concordou com a instalação. Saindo..."
    exit 0

fi