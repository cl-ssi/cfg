# Entorno de trabajo para Laravel en windows con WSL y Debian 11
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
apt-get install php7.4
apt-get install php7.4-curl
apt-get install php7.4-mbstring
apt-get install php7.4-gd
apt-get install php7.4-dom
apt-get install php7.4-soap
apt-get install php7.4-zip
apt-get install php7.4-xml
apt-get install php7.4-pdo-mysql
apt-get install mariadb-server
apt-get install vim
apt-get install wget
apt-get install curl
apt-get install nodejs npm
```

## Instalar composer siguiendo la guía de composer.org

## MySql 
* Cómo root encender mysql `# /etc/init.d/mariadb start`
* Conectarse como root `# mariadb -u root`
* Crear las bases de datos `create database NOMBRE_DE_LA_BD;`
* Crear un usuario `CREATE USER 'tic'@'localhost' IDENTIFIED BY 'password';`
* Dar permisos a todas las BDs al usuario `GRANT ALL PRIVILEGES ON *.* TO 'tic'@'localhost';`
* Reiniciar MySql `# /etc/init.d/mariadb restart`

## Clonar un proyecto con Git
* `$ cd ` (para llegar el home del usuario)
* `$ git clone http://github.com/cl-ssi/ionline`
* `$ cd ionline`
* `$ composer install`
* `$ cp .env.example .env`
* `$ php artisan key:generate`
* editar archivo .env y poner los datos de la base de datos.
* `$ php artisan migrate:fresh --see`
* Logearse en git, escribir en un terminal
    * `$ git config --global user.name "AquaroTorres"`
    * `$ git config --global user.email "atorresf@gmail.com"`

## Pasos para empezar a trabajar
* Iniciar MySql `$ sudo /etc/init.d/mariadb start`
* Entrar al proyecto, por ejemplo 'ionline' en un nuevo terminal
    * `cd` 
    * `cd ionline`
    * Iniciar el servidor `php artisan serve`
    * Abrir el code `$ code . `
    * Abrir el navegador y poner `http://localhost:8000`


## Google Cloud

### Instalar cloud_sql_proxy
* `# wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/bin/cloud_sql_proxy`
* `# chmod +x /usr/bin/cloud_sql_proxy`
### Instala Cloud SDK
* https://cloud.google.com/sdk/docs/install

