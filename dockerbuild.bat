@echo off
rem AUTOMAÇÃO PARA CRIAÇÃO DA IMAGEM DO BANCO DE DADOS
rem V 1.0
rem AUTOR Willian Andrade

echo ... BUILDING
echo Construindo a imagem do banco de dados
set project=isgood
set VERSION=v%1
set LOCAL_FILES=%2
set PERSISTENT_PATH=D:\FIAP\Fase 04\Entregavel\rabbitmq\mq-data
set POD_NAME=rabbitmq
set DOCKERCOMPOSE_FILE="D:\FIAP\Fase 04\Entregavel\Docker-up.bat"
set DOCKER_PERSISTENT_PATH=/var/lib/rabbitmq/mnesia/

if "%VERSION%"=="" (
    echo ERRO: Nao foi informado o parametro de VERSAO 
    exit
)

if "%LOCAL_FILES%"=="" (
    set LOCAL_FILES=.
)
echo INFO Versao: '%VERSION%'

SET IMAGENAME=%project%/%POD_NAME%:%VERSION%
docker build -t %IMAGENAME% %LOCAL_FILES%
echo.
docker images %IMAGENAME%
echo.

echo Image builded: %IMAGENAME% 
echo.

rem CRIANDO ESPAÇO PERSISTENTE DO BANCO DE DADOS:
if EXIST "%PERSISTENT_PATH%/" (
    echo INFO Local para persistencia de pre-existente'
) else (
    echo INFO Criando local para persistencia de dados...
    mkdir "%PERSISTENT_PATH%"
)
echo INFO Local para persistencia de dados: '%PERSISTENT_PATH%'
dir /w %PERSISTENT_PATH%

echo.
echo Comando para subir o container:
set DOCKER_UP_CMD=docker run -d --name %POD_NAME% -p 15672:15672 -p 5671:5671 -p 5672:5672 -v "%PERSISTENT_PATH%:%DOCKER_PERSISTENT_PATH%" %IMAGENAME%
echo %DOCKER_UP_CMD%
echo.
rem call %DOCKER_UP_CMD%
echo %DOCKER_UP_CMD% >> %DOCKERCOMPOSE_FILE%
echo.

