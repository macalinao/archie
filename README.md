archetype
==============

**archetype** is a simple archetype system for Node.js.

Archetypes are essentially directories containing a ton of standard files.
Archetype variables are declared with `${varname}`, where `varname` is the name
of the variable that will be replaced in the file.

This module was greatly inspired by Apache Maven. If you do anything on the JVM,
check it out. It's holy.

Usage (terminal)
------------

```
node-arch archetype-name project-name --arg1 "My Argument"
```

* `archetype-name` is the name of the archetype you wish to use. This could also be a path to a directory if you specify the `--dir` option.
* `project-name` is the name of the project. The directory created is named this.
* `--var1 "My Variable"` represents a variable.

Usage (API)
-----------

```javascript
var archetype = require('archetype')

archetype.generateFromDir('path/to/archetype/dir', 'path/to/destination/dir', {
    var1: value,
    "var 2": value
});
```

License
-------

**archetype** is released under the Apache license version 2. See LICENSE.txt for more details.

© 2012 Ian Macalinao <ianmacalinao@gmail.com> 
