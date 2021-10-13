## Para clonar un respositorio
```
$ git clone https://github.com/<repositorio>
```

## Instalar dependencias de laravel
```
$ composer install
```

## Obtener maestro y descartar los cambios locales 
```
$ git fetch --all
$ git reset --hard origin/master
```

## Almacenar credenciales de git
```
$ git config credential.helper store
```

## Cuando un seeder no encuentra la clase en laravel
```
$ composer dump-autoload
```

## Cómo crear y subir una rama local
```
git branch <nueva-rama>
git checkout <nueva-rama>
git push -u origin <nueva-rama>
```
