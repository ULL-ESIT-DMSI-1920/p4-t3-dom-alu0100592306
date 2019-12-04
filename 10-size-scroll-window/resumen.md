# Window sizes and scrolling

¿Cómo encontramos el ancho y el alto de la ventana del navegador? ¿Cómo obtenemos el ancho y la altura completos del documento, incluida la parte desplazada? ¿Cómo desplazamos la página usando JavaScript?

Para la mayoría de estas solicitudes, podemos usar el elemento de documento raíz `document.documentElement`, que corresponde a la etiqueta` <html> `. Pero hay métodos y peculiaridades adicionales lo suficientemente importantes como para considerar.

## Width/height of the window

Para obtener el ancho y la altura de la ventana, podemos usar `clientWidth / clientHeight` de `document.documentElement`:

![](Selección_142.png)

In most cases we need the *available* window width: to draw or position something. That is: inside scrollbars if there are any. So we should use `documentElement.clientHeight/Width`.

## Width/height of the document

Teóricamente, como el elemento del documento raíz es `documentElement.clientWidth / Height`, e incluye todo el contenido, podríamos medir el tamaño completo del documento como` documentElement.scrollWidth / scrollHeight`.

Para obtener de manera confiable la altura completa del documento, debemos tomar el máximo de estas propiedades:

```js
let scrollHeight = Math.max(
  document.body.scrollHeight, document.documentElement.scrollHeight,
  document.body.offsetHeight, document.documentElement.offsetHeight,
  document.body.clientHeight, document.documentElement.clientHeight
);

alert('Full document height, with scrolled out part: ' + scrollHeight);
```
Estas inconsistencias provienen de la antigüedad, no una lógica "inteligente".

## Get the current scroll

Los elementos DOM tienen su estado de desplazamiento actual en `elem.scrollLeft / scrollTop`.

Para el desplazamiento de documentos, `document.documentElement.scrollLeft / Top` funciona en la mayoría de los navegadores.

Afortunadamente, no tenemos que recordar estas peculiaridades en absoluto, porque el desplazamiento está disponible en las propiedades especiales `window.pageXOffset / pageYOffset`:

```js
alert('Current scroll from the top: ' + window.pageYOffset);
alert('Current scroll from the left: ' + window.pageXOffset);
```

Estas propiedades son de solo lectura.

## Scrolling: scrollTo, scrollBy, scrollIntoView [#window-scroll]

Los elementos regulares se pueden desplazar cambiando `scrollTop / scrollLeft`.

Podemos hacer lo mismo para la página usando `document.documentElement.scrollTop / Left`.

Alternativamente, existe una solución universal más simple: métodos especiales window.scrollBy (x, y) y window.scrollTo (pageX, pageY).

- El método `scrollBy (x, y)` desplaza la página *en relación con su posición actual*. Por ejemplo, `scrollBy (0,10)` desplaza la página `10px` hacia abajo.
    
- El método `scrollTo (pageX, pageY)` desplaza la página *a coordenadas absolutas*, de modo que la esquina superior izquierda de la parte visible tiene coordenadas `(pageX, pageY)` en relación con la esquina superior izquierda del documento. Es como configurar `scrollLeft / scrollTop`.

Estos métodos funcionan para todos los navegadores de la misma manera.

## scrollIntoView

Otro método más: elem.scrollIntoView (arriba).

La llamada a `elem.scrollIntoView (arriba)` desplaza la página para hacer visible `elem`. Tiene un argumento:

- si `top = true` (ese es el valor predeterminado), la página se desplazará para que aparezca` elem` en la parte superior de la ventana. El borde superior del elemento está alineado con la parte superior de la ventana.
- si `top = false`, la página se desplaza para hacer que` elem` aparezca en la parte inferior. El borde inferior del elemento está alineado con el fondo de la ventana.

## Forbid the scrolling

A veces necesitamos hacer que el documento sea "inescrutable". Por ejemplo, cuando necesitamos cubrirlo con un mensaje grande que requiere atención inmediata, y queremos que el visitante interactúe con ese mensaje, no con el documento.

Para hacer que el documento sea inescrutable, es suficiente establecer `document.body.style.overflow =" hidden "`. La página se congelará en su desplazamiento actual.