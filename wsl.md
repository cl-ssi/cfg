# Entorno de trabajo para Laravel en windows con WSL y Debian
## Instalar WSL 2

* Instalar WSL2 siguiendo los pasos de la guía oficial de microsoft
* Instalar Debian desde la tienda de Microsoft
* Instalar Windows Terminal desde la tienda de microsoft
 y cambiar a Debian para que se inicie predeterminadamente, en configuracion json -numero de debian

### En Debian (recomendación abrir desde windows terminal) 

* Cambiarse a administrador con `$ sudo su -` y ejecutar:
```
apt-get update
apt-get upgrade
apt-get install git
apt-get install php7.3
apt-get install php7.3-curl
apt-get install php7.3-mbstring
apt-get install php7.3-gd
apt-get install php7.3-dom
apt-get install php7.3-zip
apt-get install php7.3-xml
apt-get install php7.3-pdo-mysql
apt-get install mariadb-server
apt-get install vim
apt-get install wget
```

## Instalar composer siguiendo la guía de composer.org

## Clonar un proyecto con Git
* `$ cd ` (para llegar el home del usuario)
* `$ git clone http://github.com/cl-ssi/ionline`
* `$ cd ionline`
* `$ composer install`
* `$ php artisan key:generate`
* Logearse en git, escribir en un terminal
    * `$ git config --global user.name "adrianaol"`
    * `$ git config --global user.email "oviedolopezadriana13@gmail.com"`

## MySql 
* Cómo root encender mysql `# /etc/init.d/mysql start`
* Conectarse como root `# mysql -u root`
* Crear las bases de datos `create database NOMBRE_DE_LA_BD;`
* Crear un usuario `CREATE USER 'tic'@'localhost' IDENTIFIED BY 'password';`
* Dar permisos a todas las BDs al usuario `GRANT ALL PRIVILEGES ON *.* TO 'tic'@'localhost';`
* Reiniciar MySql `# /etc/init.d/mysql restart`

## Pasos para empezar a trabajar
* Iniciar MySql `$ sudo /etc/init.d/mysql start`
* Entrar al proyecto, por ejemplo 'ionline' en un nuevo terminal
    * `cd` 
    * `cd ionline`
    * Iniciar el servidor `php artisan serve`
    * abrir el code `$ code . `
    * Abrir el navegador y poner `localhost:8000`
