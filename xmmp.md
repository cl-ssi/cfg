```
# apt-get install prosody lua-dbi-mysql
# prosodyctl adduser alvaro.torres@intranet.saludiquique.cl

# vi /etc/prosody/prosody.cfg.lua
reemplazar example.com por intranet.saludiquique.cl
setear admins = { "alvaro.torres@intranet.saludiquique.cl" }
allow_registration = true;
storage = sql
sql = { driver = "MySQL, database = "prosody" ......}
VirtualHost "intranet.saludiquique.cl"


# openssl genrsa -out /etc/prosody/certs/intranet.saludiquique.cl.key 2048
# openssl req -new -x509 -key /etc/prosody/certs/intranet.saludiquique.cl.key -out /etc/prosody/certs/intranet.saludiquique.cl.crt -days 1095
# chown prosody:prosody /etc/prosody/certs/intranet.*

```
