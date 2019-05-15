## Análisis de vulnerabilidades

- Devuelva las opciones X-Frame-Options o Content-Security-Policy (con la directiva "ancestro de los      elementos") encabezado HTTP con la respuesta de la página. Esto evita que el contenido de la página sea procesado por otro sitio cuando se usan las etiquetas HTML de marco o iframe.
> https://www.owasp.org/index.php/Clickjacking_Defense_Cheat_Sheet
> http://en.wikipedia.org/wiki/Clickjacking
                     
```
// En /etc/apache2/conf-enabled/security.conf descomentar la línea
Header set X-Frame-Options: "sameorigin"
```
- Reiniciar Apache `root@webserver:~# a2enmod headers`


- Se recomienda desactivar el método OPTIONS en el servidor web.
> https://www.owasp.org/index.php/Test_HTTP_Methods_(OTG-CONFIG-006)

Ingresar esto en /etc/apache2/apache2.conf dentro de `<Directory />`
```
        RewriteEngine On
        RewriteCond %{REQUEST_METHOD} !^(GET|POST|HEAD)
        RewriteRule .* - [R=405,L]
```
