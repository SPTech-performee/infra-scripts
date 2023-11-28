#!/bin/bash

# SET COLORS
CIANO='\033[1;36m'
FIMCIANO='\033[0m'

VERDE='\033[0;32m'
FIMVERDE='\033[0m'

VERMELHO='\033[0;31m'
FIMVERMELHO='\033[0m'


# URL AND APP JAR
jar_path="https://github.com/SPTech-performee/performee-jar/raw/main/target/java-performee-1.0-SNAPSHOT-jar-with-dependencies.jar"
jar="java-performee-1.0-SNAPSHOT-jar-with-dependencies.jar"


echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Olá! Este é um script de instalação automatizado para sua VM!"
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Este script irá instalar automaticamente o JAVA em sua máquina e uma aplicação JAVA para o monitoramento dos componentes de sua máquina..."
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Deseja continuar? [S/N]"
read choice

if [ "$choice" = "S" ] || [ "$choice" = "s" ]; then

    # Verificando se o JAVA está instalado e se está atualizado
    if ! command -v java &> /dev/null || ! java --version | grep -q "openjdk 17"; then
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} JAVA não encontrado ou desatualizado."
        sleep 5
        sudo add-apt-repository ppa:linuxuprising/java -y
        echo "Atualizando os pacotes."
        sleep 5
        sudo apt update -y

        echo "Instalando o JAVA."
        sleep 5
        sudo apt-get install openjdk-17-jdk -y
        echo "Java 17 instalado! Atualizando..."
        sleep 5
        sudo apt update && sudo apt upgrade -y
    else
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Máquina possui o JAVA."
    fi

    sleep 8
    clear

    # Verificar se o JAR está instalado
    if [ ! -f "$jar" ]; then
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} JAR não encontrado. Iniciando sua instalação..."
        sleep 5
        sudo apt install wget -y
        wget "$jar_path" -O "$jar"
        if [ $? -eq 0 ]; then
            echo -e "${VERDE}JAR instalado.${FIMVERDE}"
        else
            echo -e "${VERMELHO}Erro ao instalar o JAR.${FIMVERVELHO}"
            exit 1
        fi
    else
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Máquina possui o JAR."
    fi

    sleep 8
    clear

    # Executando JAR
    echo "Executando JAR"
    sudo chmod +x $jar
    java -jar $jar
    if [ $? -eq 0 ]; then
        echo -e "${VERDE}Executado com sucesso.${FIMVERDE}"
    else
        echo -e "${VERMELHO}Erro ao executar o JAR.${FIMVERMELHO}"
        exit 1
    fi

    sleep 5

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Deseja executar o script Python? [S/N]"
    read choice2

    if [ "$choice2" = "S" ] || [ "$choice2" = "s" ]; then

    sudo apt install gnome-terminal -y
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executando o script Python..."
    ./python-script.sh

    else

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Você não desejou executar o script Python."
    sleep 5

    fi

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Fim do script java."

else
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Você não concordou com a instalação java. Saindo..."
    exit 0
fi
