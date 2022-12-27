## Guia MIN-NFT MARKETPLACE

Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Una vez instalado y clonado este repositorio no hará falta iniciar el proyecto con `protostar`, nos dirijimos directamente al archivo `protostar.toml` para revisar su información. Como ven estan añadidos todos los contratos y la configuración de `testnet2` para el deploy, así que nos han dejado el trabajo para hacer los MINIMOS esfuerzos `Min-Starknet`, así que intentaré seguir en esa línea para esta guía. 

----

### Ajustes Account

En esta nueva version de protostar `0.9.1` tendremos que crear un perfil que añadirermos en [protostar.toml](/protostar.toml) en el que defineremos el usuario de cuenta que pagará el fee. Usaremos los ajustes `PARA TESTNET` aunque también estan preparados para `TESTNET2`. La cuenta de ArgentX para la guía será `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` (EN SU CASO AÑADIR LA VUESTRA) para el deploy del [NFT Market.cairo](/src/min_nft_marketplace/nft_market.cairo). Tendremos que exportar nuestra `PRIVATE KEY` de esa cuenta de ArgentX. En la versión `0.9.0 protostar` teniamos que pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter).

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

## Compile y Declare NFT Market

Ahora para compilar nuesrto token `Nft_market.cairo` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)


Ahora nos quedaremos con el class hash del `Nft_market` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/nft_market.json --max-fee auto
```

* [Hash Declare Nft Market](https://goerli.voyager.online/tx/0x7437144deaf80d76d168430fc72e6a69fa1277e3e4b1f1d7fa24a25864f5e56#overview)

---

## Deploy de Nft Marketplace con Protostar

Usaremos esta vez para el `Min-Starknet` protostar, ya que no debemos pasar argumentos así directamente podremos hacer el `deploy` usando el siguiente comando.


```bash
protostar -p testnet deploy 0x0250ded8ce7f9f9345281754e6aa688282cf185a78ba4d60f2f441d25b054811 --max-fee auto
```

![Graph](/src/min_nft_marketplace/im%C3%A1genes/deploy.png)


* [Hash Deploy](https://testnet.starkscan.co/tx/0x04ed7094a58f0e59feaaa1c0183aeb11b14414576a65bb21191ccdc6a70a0cd9)
* [Contract Nft Market](https://testnet.starkscan.co/contract/0x000ae210c507e00ea33a734c138f3368a53ccb837b517b737b072ced145cd72c)


Ahora para hacer las pruebas deberemos ir primero el `setApprovalForAll` del [ERC721](https://testnet.starkscan.co/contract/0x017ae461c10ce6be043b8895c5a445960a832dff8f891a8c4284105be723255a) que creamos anteriormente, pasándole la dirección del contrato de [Nft Market](https://testnet.starkscan.co/contract/0x000ae210c507e00ea33a734c138f3368a53ccb837b517b737b072ced145cd72c) que acabamos de crear, y el valor `1` como true, así podremos empezar a listar nuestros NFT para la venta.


* [Hash setApprovalForAll](https://testnet.starkscan.co/tx/0x375c1f0a659052d45e31429a91e50634438631d6e676fdb6fb600fcb683e7c5)

![Graph](/src/min_nft_marketplace/im%C3%A1genes/forall.png)


Ahora ya podemos `list_token` en nuestro [Nft Market](https://testnet.starkscan.co/contract/0x000ae210c507e00ea33a734c138f3368a53ccb837b517b737b072ced145cd72c) que le pasaremos el contrato de `ERC721`, `Id` y `Price`.

![Graph](/src/min_nft_marketplace/im%C3%A1genes/list.png)

* [Hash List Token](https://testnet.starkscan.co/tx/0x75f2f4b515795e950778371fe231da3e921c4e8acda684ffee49fff85f381b)

![Graph](/src/min_nft_marketplace/im%C3%A1genes/listing.png)

Podemos revisar como se nos ha deployado con el datos pasados correctamente y como hemos agregado nuestro nuevo NFT `NAFT`, pero aún no hemos comprado ninguno. Recordar que muchas funciones en los contratos necesitan aprovar primero.

---
### Approve en ETH y Compra del NFT

 El comprador debe haber aprobado previamente el gasto del precio de la lista en [ETH en Starknet](https://testnet.starkscan.co/contract/0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7#write-contract) para poder completar la venta. Esto se hace utilizando el método `allowance` del contrato ERC20 `IERC20`. Este método devuelve la cantidad de ETH que el comprador ha aprobado para que se gaste en nombre del comprador por un contrato específico. Asi que deberemos de ir al contrato de [ETH en Starknet](https://testnet.starkscan.co/contract/0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7#write-contract) que estaba definido como constante en [nft_market.cairo](/src/min_nft_marketplace/nft_market.cairo#L28) y `aprobar` que el contrato [Nft Market](https://testnet.starkscan.co/contract/0x000ae210c507e00ea33a734c138f3368a53ccb837b517b737b072ced145cd72c) pueda gastar la cantidad necesaria en este caso `100000` para poder hacer la compra, para la guía probaremos con otra wallet como comprador.

![Graph](/src/min_nft_marketplace/im%C3%A1genes/approve.png)

* [Hash del Approve](https://testnet.starkscan.co/tx/0x3929dd8f3ad259d79255d866c8abcc23578bd848677f50cd2a6b08c2a4a336f)

Ahora ya podremos ir directamente al contrato del [Nft Market](https://testnet.starkscan.co/contract/0x000ae210c507e00ea33a734c138f3368a53ccb837b517b737b072ced145cd72c) en la opción de `Buy_token`. En la que se encargará directamente de enviar el saldo al vendedor y el NAFT al comprador, quedando en los eventos actualizado la `listing_sold`.

![Graph](/src/min_nft_marketplace/im%C3%A1genes/buy.png)

* [Hash Buy Token](https://testnet.starkscan.co/tx/0x2d22b2c5c92d6bd051ceb56242ebcc892901dd9f5c0d3af1561377f468b8ea1)

---

## Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `nft_market.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src/min_nft_marketplace/im%C3%A1genes/lib.png)

---
