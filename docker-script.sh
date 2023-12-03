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

    # Instalando docker e em seguida habilitando ele
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Iniciando instalação do docker"
    sudo apt install docker.io -y
    echo -e "${VERDE}Docker instalado.${FIMVERDE}"  

    sleep 15

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Iniciando serviço do docker"
    sudo systemctl start docker
    sudo systemctl enable docker
    echo -e "${VERDE}Docker iniciado.${FIMVERDE}"

    sleep 15

    # Verificando se existe o container performee
    if docker ps -a --format '{{.Names}}' | grep -q '^performee$'; then
        sudo docker exec -i performee mysql -u root -p001performee -e "DROP DATABASE IF EXISTS performee" # Caso exista o banco já criado -> delete
        sudo docker rm -f performee
        echo "O container performee foi removido."
    fi

    sleep 5

    # Verificando se a imagem SQL está instalada
    if docker image inspect mysql:5.7 &> /dev/null; then
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Baixando a imagem do MySQL 5.7"
        sudo docker pull mysql:5.7
        echo -e "${VERDE}Imagem SQL instalado.${FIMVERDE}"
    else
        echo "A imagem MySQL 5.7 está instalada no Docker."
    fi

    # Criando e executando o container docker
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executando/criando container"
    sudo docker run -d -p 3306:3306 --name performee -e "MYSQL_ROOT_PASSWORD=001performee" mysql:5.7
    echo -e "${VERDE}Container criado.${FIMVERDE}"

    sleep 15

    # Executando script SQL
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executando script SQL"
    sudo docker exec -i performee mysql -u root -p001performee -h localhost < ./Performee-script.sql
    echo -e "${VERDE}Script SQL executado.${FIMVERDE} Iniciando processo de autorização para executar script java-python..."

    sleep 15
    clear

    # Dando permissão para o user sobre o arquivo java e python e em seguida o executando o arquivo java
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Dando permissão para executar o script Java e Python"
    chmod +x java-script.sh
    chmod +x python-script.sh
    echo -e "${VERDE}Permissão concedida.${FIMVERDE}"

    sleep 5

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executando script java..."
    ./java-script.sh

    clear
else
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Você não concordou com a instalação docker. Saindo..."
    exit 0

fi