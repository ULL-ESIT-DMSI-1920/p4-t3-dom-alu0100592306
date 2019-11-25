## 1. DOM children

Mira esta página:

[dom_children.html](dom_children.html)

```html
<html>
<body>
  <div>Users:</div>
  <ul>
    <li>John</li>
    <li>Pete</li>
  </ul>
</body>
</html>
```

Para cada uno de los siguientes, proporcione al menos una forma de cómo acceder a ellos:

- El `<div>` nodo DOM?

```html
document.body.firstElementChild
<div>​Users:​</div>​
document.body.children[0]
<div>​Users:​</div>​
//Tomamos el segundo porque el primer nodo es un espacio
document.body.childNodes[1]
<div>​Users:​</div>​
```

- El `<ul>` nodo DOM?

```html
document.body.lastElementChild
<ul>​<li>​John​</li>​<li>​Pete​</li>​</ul>​
document.body.children[1]
<ul>​<li>​John​</li>​<li>​Pete​</li>​</ul>​
```

- ¿El segundo `<li>` (con Pete)?

```html
// primero obtenemos el ultimo elemento hijo de de body (ul) y obtenemos el ultimo elemento hijo de ul.
document.body.lastElementChild.lastElementChild
<li>​Pete​</li>​
```

## 2. The sibling question

Si `elem` es un nodo de elemento DOM arbitrario ...

- ¿Es cierto que elem.lastChild.nextSibling siempre es null?

Si. El elemento elem.lastChild es siempre el último, no tiene nextSibling.

```html
document.body.lastChild.nextSibling
null
```

- ¿Es cierto que elem.children[0].previousSibling siempre es null?

No, porque elem.children[0]es el primer hijo entre los elementos . Pero puede haber nodos no elementos antes. Entonces previousSibling puede ser un nodo de texto.

```html
document.body.children[0].previousSibling
#text
```
## 3. Select all diagonal cells

[diagonal.html](diagonal/index.html)

Escriba el código para pintar todas las celdas diagonales de la tabla en rojo.

Necesitarás obtener toda la diagonal `<td>` del `<table>` y pintarlos usando el código:

```html
// td should be the reference to the table cell
td.style.backgroundColor = 'red';
```

Usaremos rows y cells propiedades para acceder a las celdas diagonales de la tabla.

[solución diagonal.html](diagonal_solucion/index.html)