## Guia MIN-ICO

Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Una vez instalado y clonado este repositorio no hará falta iniciar el proyecto con `protostar`, nos dirijimos directamente al archivo `protostar.toml` para revisar su información. Como ven estan añadidos todos los contratos y la configuración de `testnet2` para el deploy, así que nos han dejado el trabajo para hacer los MINIMOS esfuerzos `Min-Starknet`, así que intentaré seguir en esa línea para esta guía. 

----

### Ajustes Account

En esta nueva version de protostar `0.9.1` tendremos que crear un perfil que añadirermos en [protostar.toml](/protostar.toml) en el que defineremos el usuario de cuenta que pagará el fee. Usaremos los ajustes `PARA TESTNET` aunque también estan preparados para `TESTNET2`. La cuenta de ArgentX para la guía será `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` (EN SU CASO AÑADIR LA VUESTRA) para el deploy del [Proxy.cairo](/src/Proxy.cairo). Tendremos que exportar nuestra `PRIVATE KEY` de esa cuenta de ArgentX. En la versión `0.9.0 protostar` teniamos que pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter).

 **Recordar que tenemos `OPCIONES A - B` para TESTNET o TESNET2 y no usar ni compartir ninguna PRIVATE KEY NUNCA, todo ello es provisional hasta la versión de `CAIRO 1.0`. Al reiniciar el pc o terminal tendrá que volver a exportar la clave.** 
 
 #### OPCIÓN A - EXPORT PRIVATE KEY
 
 En la versión `0.9.0 protostar` teniamos que pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter). En la `0.9.1` pasaremos nuestra private key  directamente para exportarla, usando el siguiente comando. (SUSITITUIR 0x1234 por vuestro hexa).

```bash
export PROTOSTAR_ACCOUNT_PRIVATE_KEY=0x1234
```

#### OPCIÓN B - .ENV PRIVATE KEY

Otra opción es este método, añadimos en un archivo `.env` nuestra private key. También tendremos que ajustar el [protostar.toml](/protostar.toml) para indicar la ruta de nuestra Private Key, aunque prefiero esta opción. Nunca mostrar tu clave privada. Nunca subir a Git tu archivo `.env`.

![Graph](/src/min_ens/imagenes/ruta.png)


### BONUS: Deploy en Testnet2

Si queremos realizar el deploy de nuestro contrato en la testnet 2, debemos seguir los mismos pasos que en la testnet. La única diferencia es que necesitaremos utilizar una wallet que esté en la testnet 2 y agregar un perfil específico al archivo de configuración de Protostar. Además, cuando ejecutemos los comandos de Protostar, debemos utilizar el parámetro `-p testnet2` en lugar de `-p testnet` para que la configuración se aplique a la testnet 2. Con estos pasos, podremos realizar el deploy de nuestro contrato en la testnet 2 de manera efectiva.

![Graph](/src/min_ens/imagenes/testnet2.png)

---

## Compile y Declare ICO

Ahora para compilar nuesrto token `ico.cairo` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.

```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)


Ahora nos quedaremos con el class hash del `Ico` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/ico.json --max-fee auto
```

![Graph](/src/min_ico/im%C3%A1genes/declare.png)

* [Hash Declare ICO]( https://testnet.starkscan.co/class/0x0097186804ddd5fd8475c5ca8cfc0785a2edf1cde27596e8f67277cf3d0a2750)

---

## Deploy de ICO con Protostar

Usaremos esta vez para el `Min-Starknet` protostar. En este caso en el [ico.cairo](/src/min_ico/ico.cairo#L62) el constructor toma dos argumentos: una dirección de tokenAddress de tipo felt y una dirección de adminAddress de tipo felt.

Dentro del constructor, las variables `admin_address` y `token_address` se escriben con los valores de los argumentos que usaremos nuestra wallet de ArgentX y nuestro [Contract ERC20 NAI](https://testnet.starkscan.co/contract/0x0005cb4b24c874d2a7378a21286f3e70a9a4447567bf8f9b8de71b8a75f32abb#overview) usando anteriormente en la guía [aquí](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_erc20/README.md)

```bash
protostar -p testnet deploy 0x0097186804ddd5fd8475c5ca8cfc0785a2edf1cde27596e8f67277cf3d0a2750 --max-fee auto -i 1795950254530259382270168937734171348535331377400385313842303804539016002736 10237315701995897433515559283228717467815530440128879644699240141503539899
```

![Graph](/src/min_ico/im%C3%A1genes/deploy.png)


* [Hash Deploy](https://testnet.starkscan.co/tx/0x0251b25094c6ccbaad4e6336ea761c628d7f12e9c0464b63bd223fccab0ce893)
* [Contract ICO](https://testnet.starkscan.co/contract/0x00479d02968a080dc08cb35d5fead32a0dc38792f8b1db14ddea4e87633dbf72)

## Approve en ETH y Register ICO

 Este código contiene una función [`register` en ico.cairo](/src/min_ico/ico.cairo#L81) que se encarga de registrar a una dirección en un ICO (Oferta Inicial de Monedas). La función verifica primero que el ICO no haya terminado, luego verifica que el usuario aún no esté registrado y luego verifica que el usuario haya aprobado previamente la dirección del contrato ICO para gastar la cantidad de registro de su saldo de ETH. Luego, la función transfiere la cantidad de registro desde la dirección del usuario al contrato ICO y agrega la dirección del usuario a la lista de direcciones registradas.

Primero el usuario debe aprobar la dirección del contrato [ICO](https://testnet.starkscan.co/contract/0x00479d02968a080dc08cb35d5fead32a0dc38792f8b1db14ddea4e87633dbf72) para gastar la cantidad de registro de su saldo de ETH, en este caso `0.001 ETH` que convertidos son `1000000000000000`. El usuario podrá hacerlo desde [ETH en Starknet](https://testnet.starkscan.co/contract/0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7#write-contract). Esto se hace utilizando el método `allowance` del contrato ERC20 `IERC20`. Este método devuelve la cantidad de ETH que el usuario ha aprobado para que se gaste en nombre del comprador por un contrato específico. 

Así que para `aprobar` deberemos de ir al contrato de [ETH en Starknet](https://testnet.starkscan.co/contract/0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7#write-contract) que estaba definido como constante en [ico.cairo](/src/min_ico/ico.cairo#L12) y `aprobar` que el contrato [ICO](https://testnet.starkscan.co/contract/0x00479d02968a080dc08cb35d5fead32a0dc38792f8b1db14ddea4e87633dbf72) pueda gastar la cantidad necesaria en este caso `1000000000000000` para poder hacer el registro.

![Graph](/src/min_ico/im%C3%A1genes/aprobar.png)

* [Hash del Approve](https://testnet.starkscan.co/tx/0x63485bfb2dfe547d57c461d929bc1b19fb469e7e993f1a51302794c44d59d96)

Ahora ya podremos ir directamente al contrato del [ICO](https://testnet.starkscan.co/contract/0x00479d02968a080dc08cb35d5fead32a0dc38792f8b1db14ddea4e87633dbf72) en la opción de `Register` y escribir sin que nos de error. Luego podremos verificar que nos hemos registrado.

![Graph](/src/min_ico/im%C3%A1genes/register.png)

![Graph](/src/min_ico/im%C3%A1genes/readregister.png)

* [Hash Register](https://testnet.starkscan.co/tx/0x1e4043b5a7e1bbcef7817225c3c895a23c2683240e55dcc0bad280f6a8bff69)

---

## Función Claim

La función [claim](/src/min_ico/ico.cairo#L121) parece estar diseñada para permitir a un usuario reclamar tokens después de que haya terminado una oferta inicial de monedas **ICO, por sus siglas en inglés**. La función toma un argumento de entrada, address, que es una dirección de un usuario que quiere reclamar tokens.

Primero, la función verifica si la dirección proporcionada está registrada llamando al método read en la variable global `registered_address`. Luego, la función verifica que el ICO ha terminado comparando la hora actual del bloque con la hora de inicio del ICO. Si la duración del ICO no ha transcurrido aún, la función lanzará un mensaje de error indicando que el ICO aún está en curso y que no se pueden reclamar tokens todavía. Si el ICO ha terminado y la dirección proporcionada está registrada, se pueden reclamar los tokens.

La [ico duration](/src/min_ico/ico.cairo#L15) que hemos definido como constante de tiempo en este caso ha sido de 24 horas para poder hacer el `claim`.

## Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `ico.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src/min_ico/im%C3%A1genes/lib.png)

---