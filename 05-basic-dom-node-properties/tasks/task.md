importance: 5

---

# What's in the nodeType?

¿Qué muestra el script?

```html
<html>

<body>
  <script>
    alert(document.body.lastChild.nodeType);
  </script>
</body>

</html>
```

En el momento de la ejecución del `<script>`, el último nodo DOM es exactamente` <script> `, porque el navegador aún no ha procesado el resto de la página.

Entonces el resultado es `1` (nodo de elemento).

# Tag in comment

¿Qué muestra este código?

```html
<script>
  let body = document.body;

  body.innerHTML = "<!--" + body.tagName + "-->";

  alert( body.firstChild.data ); // what's here?
</script>
```
La respuesta es: `BODY`

El contenido de `<body>` se reemplaza con el comentario. El comentario es `<! - BODY ->`, porque `body.tagName ==" BODY "`. `tagName` siempre está en mayúscula en HTML.

El comentario es ahora el único nodo hijo, por lo que lo obtenemos en `body.firstChild`.

La propiedad `data` del comentario es su contenido (dentro de` <! --...--> `):` "BODY" `.

# Where's the "document" in the hierarchy?

¿A qué clase pertenece `document`?

```js
alert(document); // [object HTMLDocument]
```

¿Cuál es su lugar en la jerarquía DOM?

Recorremos la cadena del prototipo a través de `__proto__`.

Los métodos de una clase están en el `prototype` del constructor. Por ejemplo, `HTMLDocument.prototype` tiene métodos para documentos.

Para obtener el nombre de la clase como una cadena, podemos usar `constructor.name`. Hagámoslo para toda la cadena de prototipos `document`, hasta la clase` Node`:

```js run
alert(HTMLDocument.prototype.constructor.name); // HTMLDocument
alert(HTMLDocument.prototype.__proto__.constructor.name); // Document
alert(HTMLDocument.prototype.__proto__.__proto__.constructor.name); // Node
```

Esa es la jerarquía.