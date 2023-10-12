# fl_stripe

Demo de Stripe en Flutter

## Lado del cliente

1. Consigue tu clave `publishable key` de Stripe en https://dashboard.stripe.com
2. Copia y pega la clave en el archivo `constants.dart` en la variable `stripePublishableKey`
3. Copia y pega la url resultante del lado servidor en el archivo `constants.dart` en la variable `stripePaymentIntentUrl`
4. Listo ahora revisa el lado del servidor.

## Lado del servidor

### NOTA: fue hecho con javascript y pensado para subirse al servicio de Firebase Functions

1. Consigue tu clave `secret key` de Stripe en https://dashboard.stripe.com
2. Copia y pega la clave en el archivo `index.js` en la variable en la importación de stripe donde dice `'secret key here'`
3. Revisa que tengas instalado Nodejs y npm en tu computadora
4. Instala Firebase CLI con `npm install -g firebase-tools`
5. Revisa que estés logueado con `firebase login`
6. Vincula tu proyecto de Firebase con `firebase use [project_id]`
   1. Si deseas solo probarlo ejecuta `firebase emulators:start`
   2. Si deseas subirlo a producción ejecuta `firebase deploy`
7. Cuando este funcionando te devolverá una url que debes copiar y pegar en el lado cliente
8. Listo ahora revisa el lado del cliente.

## Notas adicionales

- Si usaste claves de prueba solo podrás usar tarjetas de prueba, puedes encontrarlas en https://stripe.com/docs/testing.

- Si usaste claves de producción podrás usar tarjetas reales, pero ten cuidado de no hacerlo en un ambiente de prueba.

- Cada divisa tiene un mínimo de cobro, por ejemplo en México el mínimo es de 10 MXN, si intentas cobrar menos te dará un error.

- Los montos no son representados como double en Flutter, sino como int y se representan en centavos, por ejemplo 1000 centavos es igual a 10 MXN.

- Para mas información de las divisas visita https://stripe.com/docs/currencies#zero-decimal.

- Y no seas huevon cualquier duda puedes verlo en la documentación oficial https://stripe.com/docs o en los mensajes de error que devuelve el código.
