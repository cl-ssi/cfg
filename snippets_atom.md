# Your snippets
#
# Atom snippets allow you to enter a simple prefix in the editor and hit tab to
# expand the prefix into a larger code block with templated values.
#
# You can create a new snippet in this file by typing "snip" and then hitting
# tab.
#
# An example CoffeeScript snippet to expand log to console.log:
#
# '.source.coffee':
#   'Console log':
#     'prefix': 'log'
#     'body': 'console.log $1'
#
# Each scope (e.g. '.source.coffee' above) can only be declared once.
#
# This file uses CoffeeScript Object Notation (CSON).
# If you are unfamiliar with CSON, you can read more about it in the
# Atom Flight Manual:
# http://flight-manual.atom.io/using-atom/sections/basic-customization/#_cson

'.text.html.php':

  'Add $table->':
    'prefix': 'addtable'
    'body': """$table->$1('$2');$3"""


  'Add BelongTo':
    'prefix': 'addbt'
    'body': """
    public function $1() {
        return $this->belongsTo('App\\\\$2');
    }"""

  'Add BelongsToMany':
    'prefix': 'addbtm'
    'body': """
    public function $1() {
        return $this->belongsToMany('App\\\\$2');
    }"""

  'Add HasOne':
    'prefix': 'addho'
    'body': """
    public function $1() {
        return $this->hasOne('App\\\\$2');
    }"""

  'Add HasMany':
    'prefix': 'addhm'
    'body': """
    public function $1() {
        return $this->hasMany('App\\\\$2');
    }"""

  'Add Fillable':
    'prefix': 'addfillable'
    'body': """
        /**
         * The attributes that are mass assignable.
         *
         * @var array
         */
        protected $fillable = [
            $1
        ];"""

  'Add Hidden':
    'prefix': 'addhidden'
    'body': """
        /**
         * The attributes that should be hidden for arrays.
         *
         * @var array
         */
        protected $hidden = [
            'created_at', 'updated_at' $1
        ];"""

  'Add Layouts':
    'prefix': 'layouts'
    'body': """
        @extends('layouts.app')

        @section('title', '$1')

        @section('content')
        <h3 class="mb-3">$1</h3>
        $2

        @endsection

        @section('custom_js')

        @endsection
        """

  'Add use Controller':
    'prefix': 'usecontroller'
    'body': 'use App\\\\Http\\\\Controllers\\\\Controller;'

  'Add Laravel Form':
    'prefix': 'bt4form'
    'body': """
        <form method="POST" class="form-horizontal" action="{{ route(\'$1\') }}">
            @csrf
            @method('PUT')

            $2
        </form>
        """

  'Add input':
    'prefix': 'bt4input'
    'body': """
        <fieldset class="form-group col">
            <label for="for_$2">$1</label>
            <input type="text" class="form-control" id="for_$2" placeholder="$3" name="$2" required="">
        </fieldset>
        $4
        """

  'Add select':
    'prefix': 'bt4select'
    'body': """
        <fieldset class="form-group col">
            <label for="for_$2">$1</label>
            <select name="$2" id="for_$2" class="form-control">
                <option value="$3">$4</option>
            </select>
        </fieldset>
        $5
        """

  'Add file input':
    'prefix': 'bt4file'
    'body': """
        <fieldset class="form-group">
            <label for="for_$2">$1</label>
            <div class="custom-file">
              <input type="file" class="custom-file-input" id="$2">
              <label class="custom-file-label" for="$2">Seleccionar Archivo</label>
            </div>
        </fieldset>
        $3
        """

  'Add button':
    'prefix': 'bt4button'
    'body': """
        <button type="submit" class="btn btn-primary">$1</button>
        $2
        """
  'Add table soft deletes':
    'prefix': 'addtablesoft'
    'body': '$table->softDeletes();'

  'Add use SoftDeletes':
    'prefix': 'usesoftdelete'
    'body': """use Illuminate\\\\Database\\\\Eloquent\\\\SoftDeletes;"""

  'Add SoftDeletes':
    'prefix': 'addsoftdeletes'
    'body': """
        use SoftDeletes;

        /**
         * The attributes that should be mutated to dates.
         *
         * @var array
         */
        protected $dates = ['deleted_at'];
        """

  'Add Factory':
    'prefix': 'factory'
    'body': 'factory(App\\\\$1::class, 20)->create();'

  'Add request fill':
    'prefix': 'addfill'
    'body': '\$$1 = new $2$1(\$request->All());'

  'Add request fill udpate':
    'prefix': 'addfillup'
    'body': '\$$1->fill($request->all());$2'

  'Add auth id':
    'prefix': 'authid'
    'body': '{{ Auth::user()->id }}'

  'Add flash return':
    'prefix': 'addflash'
    'body': "session()->flash('info', '');"
