
### Como instalar WSL

/instalar wls2 siguiendo los pasos de la pagina
instalr windows terminal
cambiar a debian para que se inicie predeterminadamente
en configuracion json -numero de debian

ejecutar los siguientes comandos:

para acceder a permisos de administracion sudo su-
```
apt-get update
apt-get upgrade
apt-get install git
apt-get install php7.4
apt-get install php7.4-curl
apt-get install php7.4-mbstring
apt-get install php7.4-gd
apt-get install php7.4-dom
apt-get install php7.4-zip
apt-get install php7.4-xml
apt-get install vim
```

como root apt-get install mariadb-server

 en otra ventana debian
cd para irme a la direccion raiz
git clone http://github.com/cl-ssi/ionline

como root composer install

encender mysql
 /etc/init.d/mysql start

conectarse como root
crear un usuario 
```
CREATE USER 'tic'@'localhost' IDENTIFIED BY 'password';
```
y dar permisos a usuario
GRANT ALL PRIVILEGES ON *.* TO 'tic'@'localhost';

entrar a maria
mysql -u root

crear 3 bd
create database nombrebd;
reiniciar 
/etc/init.d/mysql restart

exportar el ionline


como root 
apt-get install wget
apt-get install php7.4-pdo-mysql

logearme en git poner en terminal

git config --global user.name "adrianaol"
git config --global user.email "oviedolopezadriana13@gmail.com"

pasos para empezar a trabajar


entrar como root
sudo su-

encender el mysql
/etc/init.d/mysql start

entrar al ionline en un nuevo terminal
cd 
cd ionline
echara a andar el servidor
php artisan serve

abrir el code
code .
en el navegador localhost:8000

en el code hacer un pull




