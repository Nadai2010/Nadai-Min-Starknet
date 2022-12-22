## Guia MIN-ERC721

Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Una vez instalado y clonado este repositorio no hará falta iniciar el proyecto con `protostar`, nos dirijimos directamente al archivo `protostar.toml` para revisar su información. Como ven estan añadidos todos los contratos y la configuración de `testnet2` para el deploy, así que nos han dejado el trabajo para hacer los MINIMOS esfuerzos `Min-Starknet`, así que intentaré seguir en esa línea para esta guía. 

----

### Ajustes Account

En esta nueva version de protostar `0.9.0` tendremos que crear un perfil que añadirermos en [protostar.tom](/protostar.toml) en el que defineremos el usuario de cuenta que pagará el fee. Usaremos los ajustes `PARA TESTNET` aunque también estan preparados para `TESTNET2`. La cuenta de ArgentX para la guía será `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` (EN SU CASO AÑADIR LA VUESTRA) para el deploy del [Ens.cairo](/src/min_ens/ens.cairo). Tendremos que exportar nuestra `PRIVATE KEY` de esa cuenta de argent y pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter).

 **Recordar que esto solo será una de las `OPCIONES` para TESTNET o TESNET2 y no usar ni compartir ninguna PRIVATE KEY NUNCA, todo ello es provisional hasta la versión de `CAIRO 1.0`. Al reiniciar el pc o terminal tendrá que volver a exportar la clave.** 
 
 Luego pasaremos el `hexa` convertido de nuestra private key para exportarla usando el siguiente comando. (SUSITITUIR 0x1234 por vuestro hexa).

```bash
export PROTOSTAR_ACCOUNT_PRIVATE_KEY=0x1234
```

---

## Compile y Declare ERC721

Ahora para compilar nuesrto token `ERC721.cairo` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)


Ahora nos quedaremos con el class hash del `Erc721` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/erc721.json --max-fee auto
```

![Graph](/src/min_erc721/imágenes/declare.png)

* [Hash Declare Erc721](https://testnet.starkscan.co/tx/0x01cf0197fd8669d8dc16ba6a1c5169929a1bf78931b07f40b8927369f7e7c1a5)

---

## Deploy de ERC721 con UDC

Usaremos por comodidad para el `Min-Starknet` el contrato Universal para los deploy [UDC](https://testnet.starkscan.co/contract/0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf#write-contract). En este caso pasaremos 3 argumentos, añadir en `calldata_len = 3` [Name, Symbol, Owner]. Pueden usar la herramienta para convertir a `felt` [stark-util](https://www.stark-utils.xyz/converter). En mi caso os dejo la conversión completa de mis argumentos para el `deploy`.

```
336641417577, 5128521, 1795950254530259382270168937734171348535331377400385313842303804539016002736
```

![Graph](/src/min_erc721/im%C3%A1genes/deploy.png)


* [Hash Deploy](https://testnet.starkscan.co/tx/0x42f20c06498763b10877ef6935b20f16cb202e810b2fc8c3aaf4d4504059fa4)
* [Contract ERC721](https://testnet.starkscan.co/contract/0x03b084d2d248b3e9c248e8851f5f3d6b2964919e4b958b88ee2c524ca5a436c0)

Podemos revisar como se nos ha deployado con el datos pasados correctamente y como hemos agregado nuestro nuevo NFT `NAI`, pero aún no hemos `Mint` ninguno. Recordar que muchas funciones en los contratos necesitan aprovar primero, en este caso para el `Mint` no hace falta. Una vez verificado la transacción podremos leer el contato y comprobar que se ha creado nuestro `NFT`, asi que vamos a ello. 


![Graph](/src/min_erc721/im%C3%A1genes/mint.png)

![Graph](/src/min_erc20/im%C3%A1genes/read.png)


* [Hash Mint NFT ID1](https://testnet.starkscan.co/tx/0x27491087f60f7ce3de18805b5eda54ef8efbb6b4a505e676273711b22faa801)

Como ven, solo ha hecho falta en nuestro contrato deployado llamar a `mint` y pasarle nuestra wallet que queremos recibir. También se puede pasar sin ser convertida a felt por comodidad.

---

### Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `Erc721.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src/min_erc721/im%C3%A1genes/lib.png)

---





----



* [Hash Declare]()

336641417577, 5128521, 1795950254530259382270168937734171348535331377400385313842303804539016002736

* [Hash Deploy ERC721](https://testnet.starkscan.co/tx/0x42f20c06498763b10877ef6935b20f16cb202e810b2fc8c3aaf4d4504059fa4)
* [Contract ERC721](https://testnet.starkscan.co/contract/0x03b084d2d248b3e9c248e8851f5f3d6b2964919e4b958b88ee2c524ca5a436c0)

Hash min (https://testnet.starkscan.co/tx/0x27491087f60f7ce3de18805b5eda54ef8efbb6b4a505e676273711b22faa801)



Aqui tendremos un ERC721 sencillo que podremos mintear, 


