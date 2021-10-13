## Instalar Debian basico
docker container ls
docker container ls


//lista todas las imagenes disponibles
docker images

// eliminar contenedor
docker rm "nombre del contenedor"

// nuevo contenedor httpd con un directrorio montado
sudo docker container run -d --name webserver -p 80:80 -v /home/tic/htdocs/:/usr/local/apache2/htdocs/ httpd
