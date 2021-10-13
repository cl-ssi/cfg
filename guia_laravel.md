## Ejemplo de CRUD
```
$ php artisan make:model Resources/Printer -a
```
- Se crea la migración.
```
$ php artisan make:migration create_name_table --create=name
```
- Editar el archivo migracion
```  
  $table->string('brand');
  $table->string('model');
  $table->enum('type', ['laser', 'inyection']);
  $table->ipAddress('ip')->nullable();
```
- Comprobamos la edición de la estructura de la tabla
```
$columns = \Schema::getColumnListing('<name>');
```
- creamos el seeder
```
$ php artisan make:seeder PrintersTableSeeder
```
- Se realiza migración y carga de seeder en BB.DD (Refresh)
```
$ php artisan migrate:fresh --seed  
```  
- Agregar PrintersTableSeeder a DatabaseSeeders.php
```
public function run()
    {
        $this->call(PrintersTableSeeder::class);
    }
```
- Editar el modelo y agregar los que sean asignables -> Http\
```
    protected $fillable = [
        'brand', 'model', 'type', 'ip'
    ];
```
- Agregar la ruta de tipo recurso
```
  Route::resource('tickets','TicketController')->middleware('auth');
```
```
  Route::resource('printers','Resources\PrinterController');
```
- Probar en tinker
```
$ php artisan tinker
```
- Editar el controlador PrinterController
```
use App\Http\Controllers\Controller;
```
- Modificar el metodo index del controlador
```
        $printers = Printer::all();
        return view('resources/printer/index')->withPrinters($printers);
```

- Crear vista para el index resources/printer/index.blade.php

- Crear vista para create resources/printer/create.blade.php

- Editar método create en el controlador
```
  return view('resources/printer/create');
```

- Crear vista para método store
```
   $computer = new Printer($request->All());
   return redirect()->route('printers.index');

```


### faker
Para probar en tinker un método de faker
```
$faker = Faker\Factory::create();
$faker->name
```
