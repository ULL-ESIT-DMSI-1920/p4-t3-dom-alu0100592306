## Entorno del navegador, especificaciones

El lenguaje JavaScript fue creado para los navegadores web. Desde entonces, ha evolucionado y se ha convertido en un lenguaje con muchos usos y plataformas.

Un entorno host proporciona objetos específicos de la plataforma y funciones adicionales al núcleo del lenguaje. Los navegadores web tienen un medio para controlar las páginas web. Node.JS proporciona características del lado del servidor, y así sucesivamente.

Aquí tienes una vista general de lo que tenemos cuando JavaScript se ejecuta en un navegador web:

![Optional Text](../master/Selección_114.png)

Hay un objeto "raíz" llamado `window`. Tiene dos roles:

1. Es un objeto global para el código JavaScript.
2. Representa la "ventana del navegador" y proporciona métodos para controlarla.

## Modelo de Objetos del Documento (DOM)

El objeto de `document` da acceso al contenido de la página. Con él podemos cambiar o crear cualquier cosa en la página.

Por ejemplo:

```h
// cambiar el color de fondo a rojo
document.body.style.background = "red";

// deshacer el cambio después de 1 segundo
setTimeout(() => document.body.style.background = "", 1000);
```

Aquí usamos document.body.style, pero hay muchos, muchos más. Las propiedades y métodos se describen en la especificación:

https://dom.spec.whatwg.org.

La especificación DOM explica la estructura de un documento y proporciona objetos para manipularlo. Hay instrumentos que no son del navegador que también lo utilizan, por lo que DOM no solo es para navegadores.

Por ejemplo, las herramientas del lado del servidor que descargan páginas HTML y las procesan utilizan el DOM. Sin embargo, pueden soportar solo una parte de la especificación.

Las reglas CSS y las hojas de estilo no están estructuradas como HTML. Hay una especificación [CSSOM](https://www.w3.org/TR/cssom-1/) separada, que explica cómo se representan como objetos, y cómo leerlos y escribirlos.

## BOM (parte de la especificación HTML)

El Modelo de Objetos del Navegador (BOM) son objetos adicionales proporcionados por el navegador (entorno host) para trabajar con todo excepto el documento.

Por ejemplo:
 
* El objeto navegador, proporciona información sobre el navegador y el sistema operativo. Hay muchas propiedades, pero las dos más conocidas son: navigator.userAgent - sobre el navegador actual, y navigator.platform - sobre la plataforma (puede ayudar a diferenciar entre Windows / Linux / Mac, etc.).
* El objeto ubicación , nos permite leer la URL actual y puede redirigir el navegador a uno nuevo.

Aquí vemos cómo podemos usar el objeto location:

```js
alert(location.href); // muestra la URL actual
if (confirm("Go to Wikipedia?")) {
  location.href = "https://wikipedia.org"; // redirigir el navegador a otra URL 
}
```

Las funciones alert/confirm/prompt también forman parte de BOM: no están directamente relacionadas con el documento, sino que representan métodos de comunicación puros con el usuario.

