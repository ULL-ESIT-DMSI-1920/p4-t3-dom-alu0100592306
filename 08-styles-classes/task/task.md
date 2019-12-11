# Create a notification

Escriba una función `showNotification (options)` que cree una notificación: `<div class =" notification ">` con el contenido dado. La notificación debería desaparecer automáticamente después de 1,5 segundos.

Las opciones son:

```js
// muestra un elemento con el texto "Hola" cerca de la parte superior derecha de la ventana
showNotification({
  top: 10, // 10px desde la parte superior de la ventana (por defecto 0px)
  right: 10, // 10 píxeles desde el borde derecho de la ventana (por defecto 0 píxeles)
  html: "Hello!", // el HTML de notificación
  className: "welcome" // una clase adicional para el div (opcional)
});
```

Use el posicionamiento CSS para mostrar el elemento en las coordenadas superior / derecha dadas. El documento fuente tiene los estilos necesarios.