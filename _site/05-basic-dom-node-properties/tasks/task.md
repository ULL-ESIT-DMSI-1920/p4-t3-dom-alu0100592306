importance: 5

---

# What's in the nodeType?

What does the script show?

```html
<html>

<body>
  <script>
    alert(document.body.lastChild.nodeType);
  </script>
</body>

</html>
```

Hay una trampa aquí.

En el momento de la ejecución de `<script>`, el último nodo DOM es exactamente` <script> `, porque el navegador aún no procesó el resto de la página.

Entonces el resultado es `1` (nodo de elemento).

```html run height=60
<html>

<body>
  <script>
    alert(document.body.lastChild.nodeType);
  </script>
</body>

</html>
```

# Count descendants

Hay un árbol estructurado como `ul / li` anidado.

Escriba el código que para cada `<li>` muestra:

1. ¿Cuál es el texto dentro de él (sin el subárbol)
2. El número de `<li>` anidados: todos los descendientes, incluidos los profundamente anidados.

[demo src="solution"]

# Tag in comment

¿Qué muestra este código?

```html
<script>
  let body = document.body;

  body.innerHTML = "<!--" + body.tagName + "-->";

  alert( body.firstChild.data ); // what's here?
</script>
```
# Where's the "document" in the hierarchy?

¿A qué clase pertenece el `documento`?

¿Cuál es su lugar en la jerarquía DOM?

¿Hereda de `Node` o` Element`, o tal vez `HTMLElement`?
