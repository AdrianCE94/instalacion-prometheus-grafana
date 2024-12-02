# instalacion-prometheus-grafana
Tutorial para instalar prometheus y grafana

# CONCEPTOS
PROMETHEUS → HERRAMIENTA DE MONITORIZACION
NODE EXPORT → LIBRERIA PARA LAS METRICAS
GRAFANA → PARA VERLO GRAFICAMENTE

![graf](image.png)

# Instalación de Prometheus y Grafana
Tengo una máquina Debian12 a la cual nos vamos a conectar pos ssh para que sea mas comodo. Me paso a root

## Prometheus
```bash
# Actualizamos el sistema
apt install update
# Instalamos prometheus
apt install prometheus -y
systemctl daemon-reload
# Comprobamos que el servicio esta corriendo
systemctl status prometheus
```
## Grafana
```bash
# Instalacion de paquetes necesarios
apt install -y apt-transport-https
software-properties-common wget
# Añadimos la clave de grafana
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
# Añadimos el repositorio de grafana
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list
# si queremos buscar la key
apt-key list | grep grafana
# Actualizamos los repositorios
apt update
# Instalamos grafana
apt install grafana -y
# Encendemos el servicio
systemctl daemon-reload
systemctl enable grafana-server
systemctl start grafana-server
```

# ACCESO
para acceder a grafana, abrimos un navegador y ponemos la ip de la maquina y el puerto 3000. Por defecto el usuario y contraseña es admin/admin y nos pedira cambiar la contraseña.

# Script de instalación
Si quieres automatizar la instalación, puedes usar el script de instalación que esta en el repositorio.
```bash	
git clone https://github.com/AdrianCE94/instalacion-prometheus-grafana
cd instalacion-prometheus-grafana
chmod a+x instalaPromGraf.sh
./instalaPromGraf.sh
```