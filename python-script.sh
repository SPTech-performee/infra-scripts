#!/bin/bash

# SET COLORS
CIANO='\033[1;36m'
FIMCIANO='\033[0m'

VERDE='\033[0;32m'
FIMVERDE='\033[0m'

VERMELHO='\033[0;31m'
FIMVERMELHO='\033[0m'


# URL E APP PYTHON
python_path="https://github.com/SPTech-performee/performee-gpu/raw/main/dist/GpuDados/GpuDados.exe"
python="GpuDados.exe"

echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Olá! Este é um script de instalação automatizado Python!"
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Este script irá instalar automaticamente o python e nossa aplicação Performee na sua máquina..."
echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Deseja continuar? [S/N]"
read choice


if [ "$choice" = "S" ] || [ "$choice" = "s" ]; then

    # Verificar se o PYTHON está instalado
    if [ ! -f "$python" ]; then
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Executável Python não encontrado. Iniciando sua instalação..."
        sleep 5
        sudo apt install pythonpy -y
        sudo apt-get install python3.9 -y
        sudo apt-get install python-pip -y
        pip install pyinstaller
        pip install cx_Freeze
        wget "$python_path" -O "$python"
        if [ $? -eq 0 ]; then
            echo -e "${VERDE}Executável Python instalado.${FIMVERDE}"
        else
            echo -e "${VERMELHO}Erro ao instalar o executável Python.${FIMVERVELHO}"
            exit 1
        fi
    else
        echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Máquina possui o executável Python."
    fi

    sleep 8
    clear

    # Executando o PYTHON
    echo "Executando Python"
    sudo chmod +x $python
    ./$python
    if [ $? -eq 0 ]; then
        echo -e "${VERDE}Executado com sucesso.${FIMVERDE}"
    else
        echo -e "${VERMELHO}Erro ao executar o PYTHON.${FIMVERMELHO}"
        exit 1
    fi

    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Fim do script python."

else
    echo -e "${CIANO}[BOT-Script]:${FIMCIANO} Você não concordou com a instalação python. Saindo..."
    exit 0
fi
