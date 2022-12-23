## Guia MIN-NFT MARKETPLACE

Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Una vez instalado y clonado este repositorio no hará falta iniciar el proyecto con `protostar`, nos dirijimos directamente al archivo `protostar.toml` para revisar su información. Como ven estan añadidos todos los contratos y la configuración de `testnet2` para el deploy, así que nos han dejado el trabajo para hacer los MINIMOS esfuerzos `Min-Starknet`, así que intentaré seguir en esa línea para esta guía. 

----

## Ajustes Account

En esta nueva version de protostar `0.9.0` tendremos que crear un perfil que añadirermos en [protostar.toml](/protostar.toml) en el que defineremos el usuario de cuenta que pagará el fee. Usaremos los ajustes `PARA TESTNET` aunque también estan preparados para `TESTNET2`. La cuenta de ArgentX para la guía será `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` (EN SU CASO AÑADIR LA VUESTRA) para el deploy del [Proxy.cairo](/src/Proxy.cairo). Tendremos que exportar nuestra `PRIVATE KEY` de esa cuenta de argent y pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter).

 **Recordar que tenemos `OPCIONES A - B` para TESTNET o TESNET2 y no usar ni compartir ninguna PRIVATE KEY NUNCA, todo ello es provisional hasta la versión de `CAIRO 1.0`. Al reiniciar el pc o terminal tendrá que volver a exportar la clave.** 
 
 #### OPCIÓN A - EXPORT PRIVATE KEY
 
 Con esta opción pasaremos el `hexa` convertido de nuestra private key para exportarla, usando el siguiente comando. (SUSITITUIR 0x1234 por vuestro hexa).

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

## Compile y Declare ERC721

Ahora para compilar nuesrto token `Nft_market.cairo` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)


Ahora nos quedaremos con el class hash del `Nft_market` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/nft_market.json --max-fee auto
```

![Graph](/src/min_erc721/Im%C3%A1genes/declare.png)

* [Hash Declare Nft Market](https://goerli.voyager.online/tx/0x7437144deaf80d76d168430fc72e6a69fa1277e3e4b1f1d7fa24a25864f5e56#overview)

---

## Deploy de Nft Marketplace con UDC

Usaremos esta vez para el `Min-Starknet` protostaar, ya que no debemos pasar argumentos así directamente podremos hacer el `deploy` usando el siguiente comando.


```bash
protostar -p testnet deploy 0x0250ded8ce7f9f9345281754e6aa688282cf185a78ba4d60f2f441d25b054811 --max-fee auto
```

![Graph](/src/min_erc721/Im%C3%A1genes/deploy.png)


* [Hash Deploy](https://goerli.voyager.online/tx/0x06ad6efa03c6627d771d02e22b95e911c7e7666d66c7c766521c125d7b66ac2e)
* [Contract Nft Market](https://goerli.voyager.online/contract/0x03817280345836863d60b62ad14cddb10a3c4f20475328cf1fe4519e1a2a1de0)


Ahora para hacer las pruebas deberemos ir primero a `approve` y el `setApprovalForAll` del [ERC721](https://testnet.starkscan.co/contract/0x03b084d2d248b3e9c248e8851f5f3d6b2964919e4b958b88ee2c524ca5a436c0) que creamos anteriormente, pasándole la dirección del contrato de [Nft Market](https://goerli.voyager.online/contract/0x03817280345836863d60b62ad14cddb10a3c4f20475328cf1fe4519e1a2a1de0) que acabamos de crear, así podremos empezar a listar nuestros NFT para la venta.


* [Hash Approve ERC721](https://testnet.starkscan.co/tx/0x28bb1f8c99c5ac583a6aa862fdb57998fc613640e41564eb6f51e5ba465ffe5#overview)

![Graph](approve)

Ahora ya podemos `list_token` en nuestro [Nft Market](https://goerli.voyager.online/contract/0x03817280345836863d60b62ad14cddb10a3c4f20475328cf1fe4519e1a2a1de0) que le pasaremos el contrato de `ERC721`, `Id` y `Price`.


* [Hash List Token](https://goerli.voyager.online/tx/0x5d3d14f4d1d441b83cf1394f7386ee45a5b5983fff39613c111b0f99fe04380)

![Graph](list)

Podemos revisar como se nos ha deployado con el datos pasados correctamente y como hemos agregado nuestro nuevo NFT `NAI`, pero aún no hemos `Mint` ninguno. Recordar que muchas funciones en los contratos necesitan aprovar primero, en este caso para el `Mint` no hace falta. Una vez verificado la transacción podremos leer el contato y comprobar que se ha creado nuestro `NFT`, asi que vamos a ello. 


![Graph](/src/min_erc721/Im%C3%A1genes/mint.png))

![Graph](/src/min_erc721/Im%C3%A1genes/read.png))


* [Hash Mint NFT ID1](https://testnet.starkscan.co/tx/0x27491087f60f7ce3de18805b5eda54ef8efbb6b4a505e676273711b22faa801)

Como ven, solo ha hecho falta en nuestro contrato deployado llamar a `mint` y pasarle nuestra wallet que queremos recibir. También se puede pasar sin ser convertida a felt por comodidad.

---

### Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `Erc721.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src/min_erc721/Im%C3%A1genes/lib.png)

---

approve

https://testnet.starkscan.co/tx/0x69ffe8753ce658a3b979d6753c7180a6a04a0925c5eb64b3ec3ce7a76c883eb



token list 2

https://goerli.voyager.online/tx/0x3b205dee55e2e10691035306bf6cd8c4be92d02cee13cfedc636335dc3dd6fe



deploy nft market 2

https://testnet.starkscan.co/tx/0x2271aedf8cfecd8ce39b4239474dadb9e1b3935b350d3c2fdb52c87b5e84480


contract nft market

https://goerli.voyager.online/contract/0x05f4e7a56fac26055f87c86421b5ccabb9f846df9111bb19ebca645d6a36dac0#readContract


set aproval

https://goerli.voyager.online/tx/0x40c426e83eb37d4b91dd295f05ca3d067d9876e0e294ba6d99c2dfdc5a343c9


mint1 market2

https://goerli.voyager.online/tx/0x387cba658529ad089a9b39a0d710b4f66f758291a40e0fac22a515c13b2a0b2

list token

https://goerli.voyager.online/tx/0x397bd5eea70f18c7914b5511c15bd79fc67e24b1d29988e92db2bc82c3a3554




1668820343402860704848198113071499437440800451990432553922379348409055459008, 1, 0,  1795950254530259382270168937734171348535331377400385313842303804539016002736, 1