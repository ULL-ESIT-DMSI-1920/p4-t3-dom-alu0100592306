## Buscar elementos

Aquí está el documento con la tabla y el formulario.

¿Como encontrar?

Abra la página [table.html](table.html) en una ventana separada y utilice las herramientas del navegador para eso.

1. La tabla con id="age-table".

```html
let table = document.getElementById('age-table')
undefined

table
<table id=​"age-table">​…​</table>​
```

2. Todos los elementos label dentro de esa tabla (debe haber 3 de ellos).

```html
table.getElementsByTagName('label')
HTMLCollection(3) [label, label, label]

document.querySelectorAll('#age-table label')
NodeList(3) [label, label, label]
```

3. El primero td en esa tabla (con la palabra "Edad").

```html
table.rows[0].cells[0]
<td>​Age:​</td>​

table.getElementsByTagName('td')[0]
<td>​Age:​</td>​

table.querySelector('td')
<td>​Age:​</td>​
```

4. El form con name="search".

```html
let form = document.getElementsByName('search')[0]

document.querySelector('form[name="search"]')
```

5. El primero input en ese form.

```html
form.getElementsByTagName('input')[0]

form.querySelector('input')
```

6. El último input en ese form.

```html
let inputs = form.querySelectorAll('input') // Encuentra todos los inputs
inputs[inputs.length-1] // toma el ultimo input
```



