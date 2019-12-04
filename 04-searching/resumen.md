# Searching: getElement*, querySelector*

## document.getElementById or just id

Si un elemento tiene el atributo `id`, podemos obtener el elemento usando el método `document.getElementById (id) `, sin importar dónde se encuentre.

Por ejemplo:

```html
<div id="elem">
  <div id="elem-content">Element</div>
</div>

<script>
  // get the element
  let elem = document.getElementById('elem');

  // make its background red
  elem.style.background = 'red';
</script>
```

Además, hay una variable global nombrada por `id` que hace referencia al elemento:

```html
<div id="elem">
  <div id="elem-content">Element</div>
</div>

<script>
  // elem es una referencia al elemento DOM con id = "elem"
  elem.style.background = 'red';

  // id = "elem-content" tiene un guión dentro, por lo que no puede ser un nombre de variable
  // ... pero podemos acceder usando corchetes: window ['elem-content']
</script>
```

Eso a menos que declaremos una variable de JavaScript con el mismo nombre, entonces tiene prioridad:

```html
<div id="elem"></div>

<script>
  let elem = 5; // ahora elem es 5, no una referencia a <div id = "elem">

  alert(elem); // 5
</script>
```

## querySelectorAll 

Es el método más versátil, `elem.querySelectorAll (css)` devuelve todos los elementos dentro de `elem` que coinciden con el selector CSS dado.

Aquí buscamos todos los elementos `<li>` que son los últimos hijos:

```html
<ul>
  <li>The</li>
  <li>test</li>
</ul>
<ul>
  <li>has</li>
  <li>passed</li>
</ul>
<script>
  let elements = document.querySelectorAll('ul > li:last-child');

  for (let elem of elements) {
    alert(elem.innerHTML); // "test", "passed"
  }
</script>
```

Este método es realmente poderoso, porque puede usar cualquier selector CSS.

## querySelector

La llamada a `elem.querySelector (css)` devuelve el primer elemento para el selector CSS dado.

En otras palabras, el resultado es el mismo que `elem.querySelectorAll (css) [0]`, pero este último busca *todos* elementos y elige uno, mientras que `elem.querySelector` solo busca uno. Por lo tanto, es más rápido y también más corto de escribir.

## matches

Los métodos anteriores estaban buscando el DOM.

Elem.matches (css) no busca nada, simplemente comprueba si `elem` coincide con el selector CSS dado. Devuelve `verdadero` o `falso`.

El método es útil cuando iteramos sobre elementos (como en una matriz) y tratamos de filtrar aquellos que nos interesan.

Por ejemplo:

```html
<a href="http://example.com/file.zip">...</a>
<a href="http://ya.ru">...</a>

<script>
  // puede ser cualquier colección en lugar de document.body.children
  for (let elem of document.body.children) {
    if (elem.matches('a[href$="zip"]')) {
      alert("The archive reference: " + elem.href );
    }
  }
</script>
```

## closest

*Los antepasados​​* de un elemento son: padre, padre del padre, su padre, etc. Los antepasados ​​juntos forman la cadena de padres desde el elemento hasta la cima.

El método `elem.closest (css)` busca el ancestro más cercano que coincide con el selector CSS. El `elem` en sí también se incluye en la búsqueda.

En otras palabras, el método 'más cercano' sube desde el elemento y verifica a cada uno de los padres. Si coincide con el selector, la búsqueda se detiene y se devuelve el ancestro.

Por ejemplo:

```html
<h1>Contents</h1>

<div class="contents">
  <ul class="book">
    <li class="chapter">Chapter 1</li>
    <li class="chapter">Chapter 1</li>
  </ul>
</div>

<script>
  let chapter = document.querySelector('.chapter'); // LI

  alert(chapter.closest('.book')); // UL
  alert(chapter.closest('.contents')); // DIV

  alert(chapter.closest('h1')); // null (porque h1 no es un ancestro)
</script>
```

## getElementsBy*

También hay otros métodos para buscar nodos por etiqueta, clase, etc.

Hoy en día, son principalmente historia, ya que `querySelector` es más potente y más corto de escribir.

Así que aquí los cubrimos principalmente para completarlos, mientras que aún puede encontrarlos en los viejos scripts.

- `elem.getElementsByTagName (etiqueta)` busca elementos con la etiqueta dada y devuelve la colección de ellos. El parámetro `tag` también puede ser una estrella` "*" `para" cualquier etiqueta ".
- `elem.getElementsByClassName (className)` devuelve elementos que tienen la clase CSS dada.
- `document.getElementsByName (name)` devuelve elementos con el atributo `name` dado, en todo el documento. muy raramente usado.

Por ejemplo:
```js
// get all divs in the document
let divs = document.getElementsByTagName('div');
```

Let's find all `input` tags inside the table:

```html run height=50
<table id="table">
  <tr>
    <td>Your age:</td>

    <td>
      <label>
        <input type="radio" name="age" value="young" checked> less than 18
      </label>
      <label>
        <input type="radio" name="age" value="mature"> from 18 to 50
      </label>
      <label>
        <input type="radio" name="age" value="senior"> more than 60
      </label>
    </td>
  </tr>
</table>

<script>
  let inputs = table.getElementsByTagName('input');

  for (let input of inputs) {
    alert( input.value + ': ' + input.checked );
  }
</script>
```

## Live collections

Todos los métodos `" getElementsBy* "` devuelven una colección *live*. Dichas colecciones siempre reflejan el estado actual del documento y la "actualización automática" cuando cambia.

En el siguiente ejemplo, hay dos scripts.

1. El primero crea una referencia a la colección de `<div>`. A partir de ahora, su longitud es `1`.
2. La segunda secuencia de comandos se ejecuta después de que el navegador se encuentra con uno más <<div> `, por lo que su longitud es` 2`.

```html
<div>First div</div>

<script>
  let divs = document.getElementsByTagName('div');
  alert(divs.length); // 1
</script>

<div>Second div</div>

<script>
  alert(divs.length); // 2
</script>
```

Por el contrario, `querySelectorAll` devuelve una colección *static*. Es como una matriz fija de elementos.

Si lo usamos en su lugar, ambos scripts generan `1`:


```html run
<div>First div</div>

<script>
  let divs = document.querySelectorAll('div');
  alert(divs.length); // 1
</script>

<div>Second div</div>

<script>
  alert(divs.length); // 1
</script>
```

Ahora podemos ver fácilmente la diferencia. La colección estática no aumentó después de la aparición de un nuevo `div` en el documento.