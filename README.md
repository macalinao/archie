archie
==============

**archie** is a simple archetype system for Node.js.

Archetypes are essentially directories containing a ton of standard files.
Archetype variables are declared with `${varname}`, where `varname` is the name
of the variable that will be replaced in the file.

This module was greatly inspired by Apache Maven. If you do anything on the JVM,
check it out. It's holy.

Quickstart
----------
```
archie gen -a simple -n myproject
```

This should create a new directory named `myproject` containing some files.
This project is based off a direct clone from [https://github.com/simplyianm/node-simple-archetype].

A list of archetypes currently supported can be found in the `archetypes` directory.
To use an archetype, simply type its file name minus the `.json` at the end.

Usage (terminal)
------------

```
archie gen -a [archetype] -n [name] --arg1 ...
```

Type `archie gen` for help.

Usage (API)
-----------

```javascript
var archetype = require('archetype')

archetype.generateFromDir('path/to/archetype/dir', 'path/to/destination/dir', {
    var1: value,
    "var 2": value
});
```

Destination dir does not have to be created beforehand. It should be empty, however, or files present in the directory will be overwritten.

License
-------

**archie** is released under the Apache license version 2. See LICENSE.txt for more details.

© 2012 Ian Macalinao <ianmacalinao@gmail.com> 
