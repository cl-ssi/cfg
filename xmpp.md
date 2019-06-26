## Crear servidor XMMP

### Preparar el contenedor
```
// Crear contenedor xmpp
root@leia:~# lxc launch images:debian/buster/amd64 xmpp

// Atachar red br0 a eth0
root@leia:~# lxc network attach br0 xmpp eth0

// Entrar al contenedor
root@leia:~# lxc exec xmpp -- bash

// Setear la IP del contenedor
root@xmpp:~# vi /etc/network/interfaces

// Reiniciar para que tome la nueva IP
root@xmpp:~# reboot

```

### Dentro del servidor XMMP
```
root@xmpp:~# apt-get install prosody lua-dbi-mysql

root@xmpp:~# vi /etc/prosody/prosody.cfg.lua
reemplazar example.com por intranet.saludiquique.cl
setear admins = { "alvaro.torres@intranet.saludiquique.cl" }
allow_registration = true;
storage = sql
sql = { driver = "MySQL, database = "prosody" ......}
VirtualHost "intranet.saludiquique.cl"

root@xmpp:~# prosodyctl adduser alvaro.torres@intranet.saludiquique.cl
root@xmpp:~# openssl genrsa -out /etc/prosody/certs/intranet.saludiquique.cl.key 2048
root@xmpp:~# openssl req -new -x509 -key /etc/prosody/certs/intranet.saludiquique.cl.key -out /etc/prosody/certs/intranet.saludiquique.cl.crt -days 1095
root@xmpp:~# chown prosody:prosody /etc/prosody/certs/intranet.*
root@xmpp:~# service prosody restart; service prosody status

```

### Cliente
- Abrir cliente como el pidgin
- usuario alvaro.torres
- dominio intranet.saludiquique.cl


### Agregar usuarios y grupos por BD
#### Query
```
SET @usuario = 'alvaro.torres';
SET @nombre = 'Alvaro Torres Fuchslocher';
SET @grupo = 'TIC';
SET @clave = '****';


INSERT INTO prosody (`host`, `user`, `store`, `key`, `type`, `value`) 
VALUES ('intranet.saludiquique.cl', @usuario, 'accounts', 'password', 'string', @clave);

INSERT INTO prosody (`host`, `user`, `store`, `key`, `type`, `value`) 
SELECT `host`, `user`, 'roster' as `store`, 
	concat(@usuario, '@intranet.saludiquique.cl') as `key`, 'json' as `type`, 
	concat('{"name":"',@nombre,'","groups":{"',@grupo,'":true},"subscription":"both"}') as `value` 
FROM prosody WHERE `store`='accounts' and `user` != @usuario;

INSERT INTO prosody (`host`, `user`, `store`, `key`, `type`, `value`) 
SELECT `host`, @usuario as `user`, `store`, `key`, `type`, `value`
FROM prosody where `store`='roster' AND `key` != concat(@usuario, '@intranet.saludiquique.cl') group by `key`;
```
