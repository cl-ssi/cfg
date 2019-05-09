# Instalación y configuración servidor beta.saludiquique.cl

## Instalar el vim (preferencia personal) para editar archivos
`# apt-get install vim`

##Para setear la fecha y hora
`# dpkg-reconfigure tzdata`

## Para instalar linux containers
- `# apt-get install snapd`
- `# snap install lxd`
- `# apt-get install lxc`

## Relogear e iniciar lxd
`# lxd init`
> Seguir las instrucciones


## Agregar servidor remoto a lxd
- `root@leia:~# lxc remote add 10.8.119.158`
- `root@leia:~# lxc snapshot dbserver dbserver_snap1`

## No pude usar lxc copy porque no tenía criu, tuve que instalarlo, bajandolo
> criu_3.11-2_amd64.deb
- `# dpkg -i criu_3.11-2_amd64.deb `
- `# apt-get install -f`

### Igual ejecuté este comando pero no se si sirvió
`# snap set lxd criu.enable=true`
