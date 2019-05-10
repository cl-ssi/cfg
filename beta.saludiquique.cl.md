# Instalación y configuración servidor beta.saludiquique.cl

## Instalar el vim (preferencia personal) para editar archivos
`# apt-get install vim`

## Para setear la fecha y hora
`# dpkg-reconfigure tzdata`

## Para instalar linux containers
- `# apt-get install snapd`
- `# snap install lxd`
- `# apt-get install lxc`

## Relogear e iniciar lxd
`# lxd init`
> Seguir las instrucciones
```
root@beta:~# lxd init
Would you like to use LXD clustering? (yes/no) [default=no]: 
Do you want to configure a new storage pool? (yes/no) [default=yes]: 
Name of the new storage pool [default=default]: 
Name of the storage backend to use (btrfs, ceph, dir, lvm) [default=btrfs]: 
Create a new BTRFS pool? (yes/no) [default=yes]: 
Would you like to use an existing block device? (yes/no) [default=no]: 
Size in GB of the new loop device (1GB minimum) [default=100GB]: 
Would you like to connect to a MAAS server? (yes/no) [default=no]: 
Would you like to create a new local network bridge? (yes/no) [default=yes]: no
Would you like to configure LXD to use an existing bridge or host interface? (yes/no) [default=no]: 
Would you like LXD to be available over the network? (yes/no) [default=no]: yes
Address to bind LXD to (not including port) [default=all]: 
Port to bind LXD to [default=8443]: 
Trust password for new clients: 
Again: 
Would you like stale cached images to be updated automatically? (yes/no) [default=yes] 
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: yes
```

root@beta:~# lxc network create br0 ipv6.address=none ipv4.address=10.0.0.1/24 ipv4.nat=true
root@beta:~# lxc launch images:debian/buster/amd64 dbserver
root@beta:~# lxc network attach br0 dbserver eth0
root@beta:~# lxc config device set dbserver eth0 ipv4.address 10.0.0.5
root@beta:~# lxc exec dbserver bash
root@dbserver:~# reboot


> tutorial mysql https://www.digitalocean.com/community/tutorials/how-to-install-the-latest-mysql-on-debian-9

root@dbserver:~# apt-get install wget lsb-release gnupg
root@dbserver:~# wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
root@dbserver:~# dpkg -i mysql-apt-config*
root@dbserver:~# apt update
root@dbserver:~# apt install mysql-server
>si no aparece, es porque hay que cambiar en /etc/apt/sources.list.d/mysql.list buster por stretch
root@dbserver:~# systemctl status mysql
root@dbserver:~# mysql_secure_installation

root@dbserver:~# exit

root@dbserver:~ # iptables -t nat -I PREROUTING -i eno1 -p TCP -d 10.8.119.158 --dport 3306 -j DNAT --to-destination 10.0.0.5:3306 -m comment --comment "mysql"

## Agregar servidor remoto a lxd
- `root@leia:~# lxc remote add 10.8.119.158`
- `root@leia:~# lxc snapshot dbserver dbserver_snap1`

## No pude usar lxc copy porque no tenía criu, tuve que instalarlo, bajandolo
> criu_3.11-2_amd64.deb
- `# dpkg -i criu_3.11-2_amd64.deb `
- `# apt-get install -f`

> Igual ejecuté este comando pero no se si sirvió
> `# snap set lxd criu.enable=true`

