# Attributes and properties

Cuando el navegador carga la página, "lee" (otra palabra: "analiza") el HTML y genera objetos DOM a partir de él. Para los nodos de elementos, la mayoría de los atributos HTML estándar se convierten automáticamente en propiedades de los objetos DOM.

Por ejemplo, si la etiqueta es `<body id =" page ">`, entonces el objeto DOM tiene `body.id =" page "`.

## DOM properties

Ya hemos visto propiedades DOM integradas. Hay muchas pero técnicamente nadie nos limita, y si no hay suficientes, podemos agregar los nuestros.

Los nodos DOM son objetos JavaScript normales. Podemos alterarlos.

Por ejemplo, creemos una nueva propiedad en `document.body`:
```js
document.body.myData = {
  name: 'Caesar',
  title: 'Imperator'
};

alert(document.body.myData.title); // Imperator
```

También podemos agregar un método:

```js
document.body.sayTagName = function() {
  alert(this.tagName);
};

document.body.sayTagName(); // BODY (el valor de "this" en el método es document.body)
```

También podemos modificar prototipos incorporados como `Element.prototype` y agregar nuevos métodos a todos los elementos:

```js
Element.prototype.sayHi = function() {
  alert(`Hello, I'm ${this.tagName}`);
};

document.documentElement.sayHi(); // Hello, I'm HTML
document.body.sayHi(); // Hello, I'm BODY
```

Por lo tanto, las propiedades y los métodos DOM se comportan igual que los objetos JavaScript normales:

- Pueden tener cualquier valor.
- Son sensibles a mayúsculas y minúsculas (escriba `elem.nodeType`, no` elem.NoDeTyPe`).

## HTML attributes

En HTML, las etiquetas pueden tener atributos. Cuando el navegador analiza el HTML para crear objetos DOM para etiquetas, reconoce los atributos *estándar* y crea propiedades DOM a partir de ellos.

Entonces, cuando un elemento tiene `id` u otro atributo *estándar*, se crea la propiedad correspondiente. Pero eso no sucede si el atributo no es estándar.

Por ejemplo:

```html
<body id="test" something="non-standard">
  <script>
    alert(document.body.id); // test
    // el atributo no estándar no produce una propiedad
    alert(document.body.something); // undefined
  </script>
</body>
```

Tenga en cuenta que un atributo estándar para un elemento puede ser desconocido para otro. Por ejemplo, `" type "` es estándar para `<input>` HTMLInputElement, pero no para `<body>` HTMLBodyElement. Los atributos estándar se describen en la especificación para la clase de elemento correspondiente.

Aquí podemos verlo:

```html
<body id="body" type="...">
  <input id="input" type="text">
  <script>
    alert(input.type); // text
    alert(body.type); // undefined: Propiedad DOM no creada, porque no es estándar
  </script>
</body>
```

Entonces, si un atributo no es estándar, no habrá una propiedad DOM para él. Se puede acceder a todos los atributos utilizando los siguientes métodos:

- `elem.hasAttribute (name)`: verifica la existencia.
- `elem.getAttribute (name)`: obtiene el valor.
- `elem.setAttribute (name, value)`: establece el valor.
- `elem.removeAttribute (name)`: elimina el atributo.

Estos métodos funcionan exactamente con lo que está escrito en HTML.

También se pueden leer todos los atributos usando `elem.attributes`: una colección de objetos que pertenecen a una clase [Attr](https://dom.spec.whatwg.org/#attr) incorporada, con` name` y propiedades de `valor`.

Aquí hay una demostración de la lectura de una propiedad no estándar:

```html
<body something="non-standard">
  <script>
    alert(document.body.getAttribute('something')); // non-standard
  </script>
</body>
```

Los atributos HTML tienen las siguientes características:

- Su nombre no distingue entre mayúsculas y minúsculas (`id` es igual a` ID`).
- Sus valores son siempre cadenas.

Aquí hay una demostración extendida de trabajar con atributos:

```html
<body>
  <div id="elem" about="Elephant"></div>

  <script>
    alert( elem.getAttribute('About') ); // (1) 'Elephant', reading

    elem.setAttribute('Test', 123); // (2), writing

    alert( elem.outerHTML ); // (3), see if the attribute is in HTML (yes)

    for (let attr of elem.attributes) { // (4) list all
      alert( `${attr.name} = ${attr.value}` );
    }
  </script>
</body>
```

Tenga en cuenta:

1. `getAttribute ('Acerca de')` - la primera letra está en mayúscula aquí, y en HTML todo está en minúscula. Pero eso no importa: los nombres de los atributos no distinguen entre mayúsculas y minúsculas.
2. Podemos asignar cualquier cosa a un atributo, pero se convierte en una cadena. Así que aquí tenemos "123" `como valor.
3. Todos los atributos, incluidos los que establecemos, son visibles en 'outsideHTML`.
4. La colección `atributos` es iterable y tiene todos los atributos del elemento (estándar y no estándar) como objetos con propiedades` nombre` y `valor`.

## Property-attribute synchronization

Cuando cambia un atributo estándar, la propiedad correspondiente se actualiza automáticamente y viceversa (con algunas excepciones).

En el siguiente ejemplo, `id` se modifica como un atributo, y también podemos ver que la propiedad ha cambiado. Y luego lo mismo al revés:

```html
<input>

<script>
  let input = document.querySelector('input');

  // attribute => property
  input.setAttribute('id', 'id');
  alert(input.id); // id (updated)

  // property => attribute
  input.id = 'newId';
  alert(input.getAttribute('id')); // newId (updated)
</script>
```

Pero hay exclusiones, por ejemplo, `input.value` se sincroniza solo del atributo -> a la propiedad, pero no de regreso:

```html
<input>

<script>
  let input = document.querySelector('input');

  // attribute => property
  input.setAttribute('value', 'text');
  alert(input.value); // text

  // NOT property => attribute
  input.value = 'newValue';
  alert(input.getAttribute('value')); // text (not updated!)
</script>
```

En el ejemplo anterior:
- Cambiar el atributo `value` actualiza la propiedad.
- Pero el cambio de propiedad no afecta al atributo.

Esa "característica" en realidad puede ser útil, porque las acciones del usuario pueden conducir a cambios de "valor", y luego, si queremos recuperar el valor "original" de HTML, está en el atributo.

## DOM properties are typed

Las propiedades DOM no siempre son cadenas. Por ejemplo, la propiedad `input.checked` (para casillas de verificación) es un booleano:

```html
<input id="input" type="checkbox" checked> checkbox

<script>
  alert(input.getAttribute('checked')); // the attribute value is: empty string
  alert(input.checked); // the property value is: true
</script>
```

Hay otros ejemplos El atributo `style` es una cadena, pero la propiedad` style` es un objeto:

```html
<div id="div" style="color:red;font-size:120%">Hello</div>

<script>
  // string
  alert(div.getAttribute('style')); // color:red;font-size:120%

  // object
  alert(div.style); // [object CSSStyleDeclaration]
  alert(div.style.color); // red
</script>
```

Sin embargo, la mayoría de las propiedades son cadenas.

Muy raramente, incluso si un tipo de propiedad DOM es una cadena, puede diferir del atributo. Por ejemplo, la propiedad DOM `href` siempre es una URL *completa*, incluso si el atributo contiene una URL relativa o solo un` # hash`.

Aquí hay un ejemplo:

```html
<a id="a" href="#hello">link</a>
<script>
  // attribute
  alert(a.getAttribute('href')); // #hello

  // property
  alert(a.href ); // full URL in the form http://site.com/page#hello
</script>
```
## Non-standard attributes, dataset

Al escribir HTML, utilizamos muchos atributos estándar. Los atributos no estándar se utilizan para pasar datos personalizados de HTML a JavaScript, o para "marcar" elementos HTML para JavaScript.

Como esto:

```html
<!-- marque el div para mostrar "nombre" aquí -->
<div show-info="name"></div>
<!-- and age here -->
<div show-info="age"></div>

<script>
  // el código encuentra un elemento con la marca y muestra lo que se solicita
  let user = {
    name: "Pete",
    age: 25
  };

  for(let div of document.querySelectorAll('[show-info]')) {
    // inserte la información correspondiente en el campo
    let field = div.getAttribute('show-info');
    div.innerHTML = user[field]; // primero Pete en "nombre", luego 25 en "edad"
  }
</script>
```

También se pueden usar para diseñar un elemento.

Por ejemplo, aquí para el estado de orden se usa el atributo `order-state`:

```html
<style>
  /* los estilos se basan en el atributo personalizado "order-state" */
  .order[order-state="new"] {
    color: green;
  }

  .order[order-state="pending"] {
    color: blue;
  }

  .order[order-state="canceled"] {
    color: red;
  }
</style>

<div class="order" order-state="new">
  A new order.
</div>

<div class="order" order-state="pending">
  A pending order.
</div>

<div class="order" order-state="canceled">
  A canceled order.
</div>
```

Es preferible usar un atributo a tener clases como `.order-state-new` o ` .order-state-pending` porque un atributo es más conveniente de administrar. El estado se puede cambiar tan fácil como:

```js
//un poco más simple que eliminar viejos / agregar una nueva clase
div.setAttribute('order-state', 'canceled');
```

**Todos los atributos que comienzan con "datos-" están reservados para uso de los programadores. Están disponibles en la propiedad `dataset`.**

Por ejemplo, si un `elem` tiene un atributo llamado` "data-about" `, está disponible como `elem.dataset.about`.

Como esto:

```html
<body data-about="Elephants">
<script>
  alert(document.body.dataset.about); // Elephants
</script>
```

Los atributos de varias palabras como `data-order-state` se convierten en camel-cased:` dataset.orderState`.

Aquí hay un ejemplo reescrito de "order state":

```html
<style>
  .order[data-order-state="new"] {
    color: green;
  }

  .order[data-order-state="pending"] {
    color: blue;
  }

  .order[data-order-state="canceled"] {
    color: red;
  }
</style>

<div id="order" class="order" data-order-state="new">
  A new order.
</div>

<script>
  // read
  alert(order.dataset.orderState); // new

  // modify
  order.dataset.orderState = "pending"; // (*)
</script>
```

El uso de los atributos `data- *` es una forma válida y segura de pasar datos personalizados.

Tenga en cuenta que no solo podemos leer, sino también modificar los atributos de datos. Luego, CSS actualiza la vista en consecuencia: en el ejemplo anterior, la última línea `(*)` cambia el color a azul.