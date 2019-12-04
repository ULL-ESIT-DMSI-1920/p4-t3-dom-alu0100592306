# Styles and classes

Generalmente hay dos formas de diseñar un elemento:

1. Cree una clase en CSS y agréguela: `<div class =" ... ">`
2. Escriba las propiedades directamente en `style`:` <div style = "..."> `.

JavaScript puede modificar tanto las clases como las propiedades de 'estilo'.

Siempre deberíamos usar las clases CSS. `style` solo debe usarse si las clases "no pueden manejarlo".

Por ejemplo, `style` es aceptable si calculamos las coordenadas de un elemento dinámicamente y queremos establecerlas desde JavaScript, así:

```js
let top = /* complex calculations */;
let left = /* complex calculations */;

elem.style.left = left; // e.g '123px', calculated at run-time
elem.style.top = top; // e.g '456px'
```

Para otros casos, como poner el texto en rojo, agregar un ícono de fondo, descríbelo en CSS y luego agrega la clase (JavaScript puede hacer eso). Eso es más flexible y más fácil de soportar.

## className and classList

Cambiar una clase es una de las acciones más utilizadas en los scripts.

Para las clases se introdujo la propiedad de aspecto similar `" className "`: el `elem.className` corresponde al atributo` "class" `.

Por ejemplo:

```html
<body class="main page">
  <script>
    alert(document.body.className); // main page
  </script>
</body>
```

Si asignamos algo a `elem.className`, reemplaza toda la cadena de clases. A veces eso es lo que necesitamos, pero a menudo queremos agregar / eliminar una sola clase.

Hay otra propiedad para eso: `elem.classList`.

El `elem.classList` es un objeto especial con métodos para` agregar / eliminar / alternar` una sola clase.

Por ejemplo:

```html
<body class="main page">
  <script>
    // add a class
    document.body.classList.add('article');

    alert(document.body.className); // main page article
  </script>
</body>
```

Por lo tanto, podemos operar tanto en la cadena de clase completa usando `className` como en clases individuales usando` classList`. Lo que elegimos depende de nuestras necesidades.

Métodos de `classList`:

- `elem.classList.add / remove ("class")` - agrega / elimina la clase.
- `elem.classList.toggle ("class")` - agrega la clase si no existe, de lo contrario la elimina.
- `elem.classList.contains ("class")` - comprueba la clase dada, devuelve `verdadero / falso`.

Además, `classList` es iterable, por lo que podemos enumerar todas las clases con `for..of`, así:

```html
<body class="main page">
  <script>
    for (let name of document.body.classList) {
      alert(name); // main, and then page
    }
  </script>
</body>
```

## Element style

La propiedad `elem.style` es un objeto que corresponde a lo que está escrito en el atributo` "style" `. Configurar `elem.style.width =" 100px "` funciona igual que si tuviéramos en el atributo `style` una cadena` width: 100px`.

Para la propiedad de varias palabras, se usa camelCase:

```js
background-color  => elem.style.backgroundColor
z-index           => elem.style.zIndex
border-left-width => elem.style.borderLeftWidth
```

Por ejemplo:

```js
document.body.style.backgroundColor = prompt('background color?', 'green');
```

## Resetting the style property

A veces queremos asignar una propiedad de estilo y luego eliminarla.

Por ejemplo, para ocultar un elemento, podemos establecer `elem.style.display =" none "`.

Luego, es posible que queramos eliminar el `style.display` como si no estuviera configurado. En lugar de `eliminar elem.style.display` deberíamos asignarle una cadena vacía:` elem.style.display = "" `.

```js
// si ejecutamos este código, el <body> parpadeará
document.body.style.display = "none"; // hide

setTimeout(() => document.body.style.display = "", 1000); // volver a la normalidad
```

Si establecemos `style.display` en una cadena vacía, entonces el navegador aplica las clases CSS y sus estilos incorporados normalmente, como si no hubiera tal propiedad` style.display` en absoluto.

Para establecer el estilo completo como una cadena, hay una propiedad especial `style.cssText`:

```html
<div id="div">Button</div>

<script>
  // podemos establecer banderas de estilo especiales como "importantes" aquí
  div.style.cssText=`color: red !important;
    background-color: yellow;
    width: 100px;
    text-align: center;
  `;

  alert(div.style.cssText);
</script>
```

Esta propiedad rara vez se usa, porque dicha asignación elimina todos los estilos existentes: no agrega, sino que los reemplaza. Puede ocasionalmente eliminar algo necesario. Pero podemos usarlo con seguridad para nuevos elementos, cuando sabemos que no eliminaremos un estilo existente.

## Mind the units

No olvide agregar unidades CSS a los valores.

Por ejemplo, no debemos establecer `elem.style.top` en` 10`, sino más bien en `10px`. De lo contrario no funcionaría:

```html
<body>
  <script>
    // doesn't work!
    document.body.style.margin = 20;
    alert(document.body.style.margin); // '' (empty string, the assignment is ignored)

    // now add the CSS unit (px) - and it works
    document.body.style.margin = '20px';
    alert(document.body.style.margin); // 20px

    alert(document.body.style.marginTop); // 20px
    alert(document.body.style.marginLeft); // 20px
  </script>
</body>
```

Tenga en cuenta que el navegador "desempaqueta" la propiedad `style.margin` en las últimas líneas e infiere `style.marginLeft` y `style.marginTop`.

## Computed styles: getComputedStyle

Entonces, modificar un estilo es fácil. Pero si queremos leerlo, por ejemplo, queremos saber el tamaño, los márgenes, el color de un elemento.

**La propiedad `style` opera solo en el valor del atributo` "style" `, sin ninguna cascada CSS.**

Por lo tanto, no podemos leer nada que provenga de clases CSS usando `elem.style`.

Por ejemplo, aquí `style` no ve el margen:

```html
<head>
  <style> body { color: red; margin: 5px } </style>
</head>
<body>

  The red text
  <script>
    alert(document.body.style.color); // empty
    alert(document.body.style.marginTop); // empty
  </script>
</body>
```

Pero, ¿qué sucede si necesitamos, por ejemplo, aumentar el margen en '20 px'? Nos gustaría el valor actual de la misma.

Hay otro método para eso: `getComputedStyle`.

La sintaxis es:

```js
getComputedStyle(element, [pseudo])
```

element

Elemento para el que leer el valor.

pseudo

Un pseudo-elemento si es necesario, por ejemplo `:: before`. Una cadena vacía o sin argumento significa el elemento en sí.

El resultado es un objeto con estilos, como `elem.style`, pero ahora con respecto a todas las clases CSS.

Por ejemplo:

```html
<head>
  <style> body { color: red; margin: 5px } </style>
</head>
<body>

  <script>
    let computedStyle = getComputedStyle(document.body);

    // ahora podemos leer el margen y el color

    alert( computedStyle.marginTop ); // 5px
    alert( computedStyle.color ); // rgb(255, 0, 0)
  </script>

</body>
```