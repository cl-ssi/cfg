# Configuraciones varias

## Configuración del servidor

Escenario:
Instalar ubuntu server con lo mínimo.
Servidor con IP: 10.8.119.35 
DNS server: 10.8.134.35

#### instalar lxd e iniciarlo
- `apt install lxd lxd-client`
- `sudo lxd init`

Crear dos contenedores
- webserver: 10.0.0.100
- dbserver : 10.0.0.200

### Pasos
1. Crear una red puente en el host
2. Crear los dos contenedores
3. Asociar la red puente a eth0 en ambos contenedores
4. Asignar un IP a cada contenedor
5. Reiniciar los contenedores
6. Agregar reglas para cada contenedor en iptables
7. Fijar las reglas en iptables con el paquete "iptables-persistent"



### Crear un puente con red 10.0.0.*
`lxc network create br0 ipv6.address=none ipv4.address=10.0.0.1/24 ipv4.nat=true`
### opcional editar: lxc network edit br0

### crear un contenedor con debian buster
`lxc launch images:debian/buster/amd64 webserver`
`lxc launch ubuntu:18.04 nombre-contenedor`

### Atachar la red a un contenedor
`lxc network attach br0 webserver eth0`

### Setear el IP 10.0.0.100 al contenedor
`lxc config device set webserver eth0 ipv4.address 10.0.0.100`

### Reiniciar el contender
`lxc restart webserver`

### Para ejecutar un shell desde el host
`lxc exec webserver -- /bin/bash`

### Agregar reglas a iptables
```
PORT=50022
PUBLIC_IP=10.8.119.35
CONTAINER_IP=10.0.0.100

iptables -t nat -I PREROUTING -i eno1 -p TCP -d $PUBLIC_IP --dport $PORT -j DNAT --to-destination $CONTAINER_IP:$PORT -m comment --comment "ssh"
```

### Instalar iptables-persistent, preguntara si guardar las reglas, guardar todo
`apt-get install iptables-persistent`

### En caso de agregar o cambiar una regla, guardarla con 
`netfilter-persistent save`


### lista las imagenes para crear contenedores
`lxc image list images:`



### Para listar las rutas
`iptables -t nat -L PREROUTING --line-numbers`

### Para borrar la ruta 1
`iptables -t nat -D PREROUTING 1`

### setear IP de máquina webserver
This file describes the network interfaces available on your system
and how to activate them. For more information, see interfaces(5).

# The loopback network interface
```
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
        address 10.0.0.2
        netmask 255.255.255.0
        gateway 10.0.0.1
```

Insale en webserver
apache2 ssh
configuré en iptables un forward para el puerto 80 y el 22

cambié en /etc/ssh/sshd_config el puerto 22 al 2233

apt-get install sqlite3 php php-zip php-mysql php-sqlite3

## creando dbserver
lxc launch images:debian/9/amd64 dbserver
lxc network attach br0 dbserver eth0
lxc exec dbserver bash
#vi /etc/network/interfaces

setear IP
iface eth0 inet static
        address 10.0.0.5
        netmask 255.255.255.0
        gateway 10.0.0.1
        
# MariaDB
`# apt-get install mariadb-server
`# mysql_secure_installation
//clave: Salud#123

Configurar mariadb para que permita conexiones remotas.
`# vi /etc/mysql/mariadb.conf.d/50-server.cnf
Comentar las líneas del archivo
` #skip-networking
` #bind-address = <some ip-address>


Permitir conexión de root dentro de la red
`GRANT ALL PRIVILEGES ON *.* TO 'root'@'10.8.%.%' IDENTIFIED BY 'Salud&123' WITH GRANT OPTION;

Después crear los usuarios desde un cliente de mysql como HeidiSql

De todas formas para crear un usuario a mano es así:
Crear el usuario "tic" y la base de datos "intranet" y asignarsela
`CREATE USER 'tic'@'localhost' IDENTIFIED BY 'Salud&123';
`create database intranet;
`GRANT ALL ON intranet.* TO 'tic'@'localhost';
me falta crear el usuario para que se conecte remotamente. eso no lo hice ya que ocupe el HeidiSql para crearlo
