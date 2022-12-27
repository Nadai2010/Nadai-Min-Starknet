## Guia MIN-ERC20

Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Una vez instalado y clonado este repositorio no hará falta iniciar el proyecto con `protostar`, nos dirijimos directamente al archivo `protostar.toml` para revisar su información. Como ven estan añadidos todos los contratos y la configuración de `testnet2` para el deploy, así que nos han dejado el trabajo para hacer los MINIMOS esfuerzos `Min-Starknet`, así que intentaré seguir en esa línea para esta guía. 

----

### Ajustes Account

En esta nueva version de protostar `0.9.1` tendremos que crear un perfil que añadirermos en [protostar.toml](/protostar.toml) en el que defineremos el usuario de cuenta que pagará el fee. Usaremos los ajustes `PARA TESTNET` aunque también estan preparados para `TESTNET2`. La cuenta de ArgentX para la guía será `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` (EN SU CASO AÑADIR LA VUESTRA) para el deploy del [Erc20](/src/min_erc20/ERC20.cairo). Tendremos que exportar nuestra `PRIVATE KEY` de esa cuenta de ArgentX. En la versión `0.9.0 protostar` teniamos que pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter).

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

## Compile y Declare ERC20

Ahora para compilar nuesrto token `ERC20.cairo` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)


Ahora nos quedaremos con el class hash del `Erc20` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/erc20.json --max-fee auto
```

![Graph](/src/min_erc20/imágenes/declare.png)

* [Hash Declare Erc20](https://testnet.starkscan.co/tx/0x07a729d9573237ff72683150a47c7ef65e9236c63ddfc994ae3d57ddb4ea861b)

---

## Deploy de ERC20 con UDC

Usaremos por comodidad para el `Min-Starknet` el contrato Universal para los deploy [UDC](https://testnet.starkscan.co/contract/0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf#write-contract). En este caso pasaremos 6 argumentos añadir en `calldata_len = 6` [Name, Symbol, Decimals, **initialSupply**, Recipient]. El `initialSupply` deberá pasarse en uint256 por lo que podemos usar la herramienta [stark-util](https://www.stark-utils.xyz/converter) o directamente en este ejemplo para `100 = 100, 0`, por ello se pasan 6 argumentos. En mi caso os dejo la conversión completa de mis argumentos para el `deploy`.

```
336641417577, 5128521, 18, 1000000, 0, 1795950254530259382270168937734171348535331377400385313842303804539016002736
```

![Graph](/src/min_erc20/im%C3%A1genes/deploy.png)


* [Hash Deploy](https://testnet.starkscan.co/tx/0x389297da6cbc2b033e6e2acbfd45ac374abaef78dc0d0aeaf057c7ea1c28557)
* [Contract ERC20](https://testnet.starkscan.co/contract/0x0005cb4b24c874d2a7378a21286f3e70a9a4447567bf8f9b8de71b8a75f32abb#overview)

Podemos revisar como se nos ha deployado con el datos pasados correctamente y como hemos agregado nuestro nuevo token `NAI` a nuestra wallet.

![Graph](/src/min_erc20/im%C3%A1genes/name.png)

![Graph](/src/min_erc20/im%C3%A1genes/add.png)

---

aprove nai

https://testnet.starkscan.co/tx/0x4e9e6b98ca557d10e708ce096bb4cb57316a576d18b50c5dbe1d4bbaf5ce3a





## Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `Erc20.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src/min_erc20/im%C3%A1genes/lib.png)

---