Instalar Composer
Descargar PHP, MySQL, Git (zips, no los instalables)
Descomprimir PHP, MySQL y Git en carpetas
Agregar al PATH: PHP/bin, MySQL/bin y Git/bin

Sólo para MySql:
- Crear archivo my.ini con 

[mysqld]
# set basedir to your installation path
basedir=E:\\mysql
# set datadir to the location of your data directory
datadir=E:\\mydata\\data

- luego
// Para inicializar el directorio data ejecutar 
 $ mysqld --initialize--inscure

// Para instalar el servicio ejecutar como administrador 
 # mysqld --install

- luego encender el servicio de mysql desde services.msc


Para PHP, descomentar en php.ini
extension=fileinfo
