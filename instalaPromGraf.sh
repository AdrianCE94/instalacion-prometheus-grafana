#!/bin/bash
# Script para instalar Prometheus y Grafana en un sistema Linux
# Autor: Adrian Cabezuelo Exposito
# Fecha: 10/11/2020
# gh --> https://github.com/AdrianCE94

echo "Bienvenido al asistente de instalación automática de Prometheus y Grafana en el sistema"
comprobarRoot() {
    if [ "$(id -u)" != "0" ]; then
        echo "Este script necesita permisos de superusuario para ejecutarse"
        exit 1
    fi
}
actualizarSistema() {
    echo "Actualizando sistema...."
    apt update
}

instalarPrometheus() {
    echo "Instalando Prometheus...."
    apt install -y prometheus
}

instalarGrafana() {
    echo "Instalando Grafana...."
    echo "Instalando paquetes necesarios"
    apt install -y apt-transport-https software-properties-common wget

    echo "Añadiendo clave de Grafana"
    wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -

    echo "Añadiendo repositorio de Grafana"
    echo "deb https://packages.grafana.com/oss/deb stable main" | tee /etc/apt/sources.list.d/grafana.list

    echo "Actualizando repositorios"
    apt update

    echo "Instalando Grafana"
    apt install -y grafana

    echo "Encendiendo el servicio de Grafana"
    systemctl daemon-reload
    systemctl enable grafana-server
    systemctl start grafana-server

    echo "Grafana instalado correctamente"
    echo "Puede acceder a Grafana en http://localhost:3000"
}


menu(){
    clear
    echo "1. Instalar Prometheus"
    echo "2. Instalar Grafana"
    echo "3. Salir"
}

comprobarRoot
menu
read -p "Seleccione una opción: " opcion
while [ "$opcion" != 3 ]; do
    case $opcion in
        1)
            actualizarSistema
            instalarPrometheus
            ;;
        2)
            instalarGrafana
            ;;
        3)
            echo "Saliendo del asistente de instalación,Gracias por usarlo"
            ;;
        *)
            echo "Opción incorrecta"
            ;;
    esac
    read -p "Pulse una tecla para continuar..." intro
    menu
    read -p "Seleccione una opción: " opcion
done