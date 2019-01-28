# Configuraciones varias

## Configuración del servidor

Escenario:

Instalar debian o ubuntu server con lo mínimo (sin entorno gráfico ni nada, sólo red)
- Servidor con IP: 10.8.119.35 
- DNS server: 10.8.134.35

#### Cambiar puerto de ssh de la máquina base

```
# vi /etc/ssh/sshd_config
```
Descomentar y cambiar el puerto 22 al 2233 (:wq = guardar y salir)

#### Reiniciar el servicio ssh

```
# service sshd restart
```

#### Modificar /etc/apt/sources.list
- En la línea: "deb:http://deb.debian.org/debian/ buster main" agregar  `contrib non-free`

#### instalar lxd e iniciarlo
- `apt install lxd lxd-client`
- `lxd init`



## Crear dos contenedores
- webserver: 10.0.0.2
- dbserver : 10.0.0.5

## Pasos
1. Crear una red puente en el host
2. Crear los dos contenedores
3. Asociar la red puente a eth0 en ambos contenedores
4. Asignar un IP a cada contenedor
5. Reiniciar los contenedores
6. Agregar reglas para cada contenedor en iptables
7. Fijar las reglas en iptables con el paquete "iptables-persistent"


### Crear un puente con red 10.0.0.*
```
# lxc network create br0 ipv6.address=none ipv4.address=10.0.0.1/24 ipv4.nat=true
```
> opcional editar: lxc network edit br0

### Crear contenedor "webserver" con debian buster
```
# lxc launch images:debian/buster/amd64 webserver
```
> Ejemplo de como crear un contenedor con ubuntu `lxc launch ubuntu:18.04 nombre-contenedor`

### Atachar la red a un contenedor

```
# lxc network attach br0 webserver eth0
```

### Setear el IP 10.0.0.2 al contenedor

```
# lxc config device set webserver eth0 ipv4.address 10.0.0.2
```

### Reiniciar el contender
```
# lxc restart webserver
```

### Para ejecutar un shell desde el host
```
# lxc exec webserver bash
```

### Instalar ssh, apache y php en el contenedor webserver
```
root@webserver:~# apt-get install ssh apache2 php7 php7-xml php7-zip php7-sqlite3 sqlite3 
```
- Habilitar mod_rewrite `#a2enmod rewrite`
- `AllowOverride All` en alias o configuracion de apache

### setear IP del contenedor webserver
```
root@webserver:~# vi /etc/network/interfaces
```

```
iface eth0 inet static
        address 10.0.0.2
        netmask 255.255.255.0
        gateway 10.0.0.1
```

### Reiniciar el contenedor

```
root@webserver:~# reboot
```

### En el servidor base agregar reglas a iptables
```
# PORT=22
# PUBLIC_IP=10.8.119.35
# CONTAINER_IP=10.0.0.2

# iptables -t nat -I PREROUTING -i eno1 -p TCP -d $PUBLIC_IP --dport $PORT -j DNAT --to-destination $CONTAINER_IP:$PORT -m comment --comment "ssh"
```


### Crear contenedor dbserver
```
lxc launch images:debian/9/amd64 dbserver
lxc network attach br0 dbserver eth0
lxc exec dbserver bash
```

```
root@dbserver:~# vi /etc/network/interfaces
```

```
setear IP
iface eth0 inet static
        address 10.0.0.5
        netmask 255.255.255.0
        gateway 10.0.0.1
```

##### MariaDB
```
root@dbserver:~# apt-get install mariadb-server
root@dbserver:~# mysql_secure_installation
```

#### Configurar mariadb para que permita conexiones remotas.

```
root@dbserver:~# vi /etc/mysql/mariadb.conf.d/50-server.cnf
```

Comentar las líneas del archivo

```
#skip-networking
#bind-address = <some ip-address>
```


#### Permitir conexión de root dentro de la red
```
root@dbserver:~# mysql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'10.8.%.%' IDENTIFIED BY '*******' WITH GRANT OPTION;
```

#### Después crear los usuarios desde un cliente de mysql como HeidiSql

> De todas formas para crear un usuario a mano es así:

> Crear el usuario "tic" y la base de datos "intranet" y asignarsela
```
CREATE USER 'tic'@'localhost' IDENTIFIED BY '*****';
create database intranet;
GRANT ALL ON intranet.* TO 'tic'@'localhost';
```
>me falta crear el usuario para que se conecte remotamente. eso no lo hice ya que ocupe el HeidiSql para crearlo


### En el servidor base agregar reglas a iptables para mysql
```
# PORT=3306
# PUBLIC_IP=10.8.119.35
# CONTAINER_IP=10.0.0.5

# iptables -t nat -I PREROUTING -i eno1 -p TCP -d $PUBLIC_IP --dport $PORT -j DNAT --to-destination $CONTAINER_IP:$PORT -m comment --comment "mysql"
```

## Instalar iptables-persistent en el servidor base, preguntará si guardar las reglas, guardar todo
`apt-get install iptables-persistent`

### En caso de agregar o cambiar una regla, guardarla con 
`netfilter-persistent save`

### Para listar las rutas
`iptables -t nat -L PREROUTING --line-numbers`

### Para borrar la ruta 1
`iptables -t nat -D PREROUTING 1`


## Otros apuntes
### lista las imagenes para crear contenedores
`lxc image list images:`


## SFTP server para estadistica
```
root@leia:~# lxc launch images:debian/buster/amd64 sftpserver
root@leia:~# lxc network attach br0 sftpserver eth0
root@leia:~# lxc config device set sftpserver eth0 ipv4.address 10.0.0.50
root@leia:~# lxc exec sftpserver bash
root@sftpserver:~# vi /etc/network/interfaces

iface eth0 inet static
        address 10.0.0.50
        netmask 255.255.255.0
        gateway 10.0.0.1

root@sftpserver:~# vi /etc/resolv.conf
domain lxd
search lxd
nameserver 10.0.0.1

root@sftpserver:~# reboot
root@leia:~# lxc exec sftpserver bash
root@sftpserver:~# groupadd sftpusers
root@sftpserver:~# useradd -g sftpusers -d /home/estadistica -s /sbin/nologin estadistica
root@sftpserver:~# passwd estadistica
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully

root@sftpserver:/# apt-get install ssh

root@sftpserver:/# vi /etc/ssh/sshd_config
// Cambiar 
Port:22  --> Port : 2222
// Comentar línea en archivo /etc/ssh/sshd_config 
#Subsystem       sftp    /usr/libexec/openssh/sftp-server
// Agregar la siguiente línea en el mismo archivo, /etc/ssh/sshd_config
Subsystem       sftp    internal-sftp
// Agregar al final del archivo /etc/ssh/sshd_config
Match Group sftpusers
        ChrootDirectory /home/%u
        ForceCommand internal-sftp

root@sftpserver:/# mkdir /home/estadistica
root@sftpserver:/# mkdir /home/estadistica/archivos
root@sftpserver:/# chown estadistica:sftpusers /home/estadistica/archivos
root@sftpserver:/# vi /etc/ssh/sshd_config  
root@sftpserver:/# service sshd restart

exit

root@leia:~# PORT=2222
root@leia:~# PUBLIC_IP=10.8.119.35
root@leia:~# CONTAINER_IP=10.0.0.50
root@leia:~# iptables -t nat -I PREROUTING -i eno1 -p TCP -d $PUBLIC_IP --dport $PORT -j DNAT --to-destination $CONTAINER_IP:$PORT -m comment --comment "sftp"
root@leia:~# netfilter-persistent save

Probar con un cliente de sftp
sftp -P 2222 estadistica@10.0.0.50  password:salud2019

```
