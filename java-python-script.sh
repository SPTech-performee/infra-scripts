#!/bin/bash

# SET COLORS
CIANO='\033[1;36m'
FIMCIANO='\033[0m'

VERDE='\033[0;32m'
FIMVERDE='\033[0m'

VERMELHO='\033[0;31m'
FIMVERMELHO='\033[0m'


# URL AND APP JAR
# MUDAR PARA SUA VERSÂO / SEU JAR
jar_path="caminho_executavel"
jar="nome_executavel.jar"

echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Olá! Este é um script de instalação automatizado para sua VM!"
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Este script irá instalar automaticamente o JAVA em sua máquina e uma aplicação JAVA para o monitoramento dos componentes de sua máquina..."
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Deseja continuar? [S/N]"
read choice

if [ "$choice" = "S" ] || [ "$choice" = "s" ]; then

    # Verificando se o JAVA está instalado e se está atualizado
    if ! command -v java &> /dev/null || ! java --version | grep -q "openjdk 17"; then
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} JAVA não encontrado ou desatualizado."
        sleep 3
        sudo add-apt-repository ppa:linuxuprising/java -y
        echo "Atualizando os pacotes."
        sleep 3
        sudo apt update -y

        echo "Instalando o JAVA."
        sleep 3
        sudo apt-get install openjdk-17-jdk -y
        echo "Java 17 instalado! Atualizando..."
        sleep 3
        sudo apt update && sudo apt upgrade -y
    else
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Máquina possui o JAVA."
    fi

    sleep 3
    clear

    # Verificar se o JAR está instalado
    if [ ! -f "$jar" ]; then
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} JAR não encontrado. Iniciando sua instalação..."
        sleep 3
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

    sleep 3
    clear

    # - - -
    # INSERIR CONFIG PARA EXECUTÁVEL EM PYTHON AQUI
    # - - -

    echo "Executando JAR"
    java -jar "$jar"
    if [ $? -eq 0 ]; then
        echo -e "${VERDE}Executado com sucesso.${FIMVERDE}"
    else
        echo -e "${VERMELHO}Erro ao executar o JAR.${FIMVERMELHO}"
        exit 1
    fi

    sleep 3
    clear

    # - - -
    # ABRIR UM NOVO TERMINAL E EXECUTAR O PYTHON
    #sudo apt install gnome-terminal
    #echo "Executando PYTHON"
    #gnome-terminal -- bash -c "exec $SHELL; aqui_vem_executavel_python"
    #if [ $? -eq 0 ]; then
    #    echo -e "${VERDE}Executado com sucesso.${FIMVERDE}"
    #else
    #    echo -e "${VERMELHO}Erro ao executar o PYTHON.${FIMVERMELHO}"
    #    exit 1
    #fi

    #sleep 3
    #clear
    # - - -

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Fim do script."

else
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Você não concordou com a instalação. Saindo..."
    exit 0
fi
