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