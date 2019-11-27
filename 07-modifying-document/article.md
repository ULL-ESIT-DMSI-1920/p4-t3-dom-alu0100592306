# Modifying the document

La modificación del DOM es la clave para crear páginas "en vivo".

Aquí veremos cómo crear nuevos elementos "sobre la marcha" y modificar el contenido de la página existente.

## Ejemplo: mostrar un mensaje

Demostremos usando un ejemplo. Agregaremos un mensaje en la página que se vea mejor que `alert`.

Así es como se verá:

```html
<style>
.alert {
  padding: 15px;
  border: 1px solid #d6e9c6;
  border-radius: 4px;
  color: #3c763d;
  background-color: #dff0d8;
}
</style>

<div class="alert">
  <strong>Hi there!</strong> You've read an important message.
</div>
```

Ese fue un ejemplo HTML. Ahora creemos el mismo `div` con JavaScript (suponiendo que los estilos estén en el HTML o en un archivo CSS externo).

## Creating an element