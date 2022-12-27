## Guia MIN-STAKING

Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Una vez instalado y clonado este repositorio no hará falta iniciar el proyecto con `protostar`, nos dirijimos directamente al archivo `protostar.toml` para revisar su información. Como ven estan añadidos todos los contratos y la configuración de `testnet2` para el deploy, así que nos han dejado el trabajo para hacer los MINIMOS esfuerzos `Min-Starknet`, así que intentaré seguir en esa línea para esta guía. 

----

### Ajustes Account

En esta nueva version de protostar `0.9.1` tendremos que crear un perfil que añadirermos en [protostar.toml](/protostar.toml) en el que defineremos el usuario de cuenta que pagará el fee. Usaremos los ajustes `PARA TESTNET` aunque también estan preparados para `TESTNET2`. La cuenta de ArgentX para la guía será `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` (EN SU CASO AÑADIR LA VUESTRA) para el deploy del [staking.cairo](/src/min_staking/staking.cairo). Tendremos que exportar nuestra `PRIVATE KEY` de esa cuenta de ArgentX. En la versión `0.9.0 protostar` teniamos que pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter).

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

## Compile y Declare STAKE

Ahora para compilar nuesrto token `staking.cairo` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)

Ahora nos quedaremos con el class hash del `Staking` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/staking.json --max-fee auto
```

![Graph](/src/min_staking/im%C3%A1genes/declare.png)

* [Hash Declare STAKING](https://testnet.starkscan.co/class/0x04464eba7601763a9edc8d497d9fe48c2aeefd77bba9598fb13d9507ff12407b)

---

## Deploy de STAKING con Protostar

Usaremos esta vez para el `Min-Starknet` protostar. En este constructor en particular, tenemos que pasar dos parámetros: `tokenAddress` y `adminAddress`. Para tokenAddress usaremos [ETH en Starknet](https://testnet.starkscan.co/contract/0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7#write-contract) y de admin la wallet usada para esta guía. Estos se guardan en el almacenamiento del contrato (usando la función write) en las variables `token_address` y `admin_address` respectivamente. Así que pasaremos para el `deploy` el siguiente comando.

```bash
protostar -p testnet deploy 0x04464eba7601763a9edc8d497d9fe48c2aeefd77bba9598fb13d9507ff12407b --max-fee auto -i 2087021424722619777119509474943472645767659996348769578120564519014510906823 1795950254530259382270168937734171348535331377400385313842303804539016002736
```

![Graph](/src/min_staking/im%C3%A1genes/deploy.png)


* [Hash Deploy](https://testnet.starkscan.co/tx/0x00e49bc4bc5907411e94d2a79bb55e9476b7ec1d0c0c756fcc6561207ac6c03d)
* [Contract STAKING](https://testnet.starkscan.co/contract/0x010313bd5969cf62a539f0794e6dbdcce802647a4eb40c5176d713a901d45521)

---

### Función Approve y Stake

Para aprobar el token en este contrato, necesitarás utilizar la función `approve` del contrato ERC-20 que representa el token. En este caso usamos [ETH en Starknet](https://testnet.starkscan.co/contract/0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7#write-contract). La función `approve` permite que el contrato especificado pueda transferir tokens desde tu cuenta. En este caso será el contrato de [STAKING](https://testnet.starkscan.co/contract/0x010313bd5969cf62a539f0794e6dbdcce802647a4eb40c5176d713a901d45521). La cantidad que pasaremos será `100000000000`.

![Graph](/src/min_staking/im%C3%A1genes/approve.png)

* [Hash Approve ETH](https://testnet.starkscan.co/tx/0x7b991a3d01a75a5f2dc4186ac19ae658064fd4ce4d100672b53e9fc319b7e31)

Una vez esté procesada la transacción iremos hacer el  [Stake](https://testnet.starkscan.co/contract/0x010313bd5969cf62a539f0794e6dbdcce802647a4eb40c5176d713a901d45521#write-contract) de `ETH` y tiene dos parámetros de entrada: `stake_amount` y `duration_in_secs`.

La función comienza por asignar algunas variables locales y luego obtiene la dirección del llamante y la dirección del contrato actual utilizando las funciones `get_caller_address` y `get_contract_address`, respectivamente. También obtiene la dirección del token y el valor actual del contador de stakes utilizando las funciones `read` y las variables `token_address` y `stake_counter`, respectivamente.

Luego, la función asigna un nuevo valor al contador de stakes y calcula la hora de finalización del stake sumando la duración del stake al tiempo actual. Para la guía usamos para `stake_amount 100` y `duration_in_secs 60`.

![Graph](/src/min_staking/im%C3%A1genes/stake.png)

* [Hash Stake ETH](https://testnet.starkscan.co/tx/0x5b65c61dfd1b2edf86d64b4818e2f56a55f7d4e88012a2687495d13e0f7273c)

![Graph](/src/min_staking/im%C3%A1genes/infor.png)


---

### Función Claim Reward

La función [claim_reward](/src/min_staking/staking.cairo#L113) es utilizada para reclamar sobre un sistema de recompensas basado en stakes (depósitos). La idea es que los usuarios pueden depositar tokens en el contrato y recibir recompensas por el tiempo durante el cual mantienen sus tokens depositados.

La función [claim_reward](/src/min_staking/staking.cairo#L113) se utiliza para recoger las recompensas acumuladas por un stake específico. El parámetro `stake_id` se utiliza para identificar el stake del que se quieren recoger las recompensas.

En la función, se obtienen los detalles del stake especificado, incluyendo la hora de inicio y la hora de finalización del stake. Luego, se puede calcular el tiempo durante el cual el stake ha estado activo y utilizar esta información para calcular las recompensas acumuladas.

Una vez que se han calculado las recompensas, se pueden transferir los tokens a la cuenta del usuario que ha realizado la llamada a la función utilizando la función `transfer` del contrato ERC-20 del token, en nuetro caso transcurrido los `60 sec`.

![Graph](/src/min_staking/im%C3%A1genes/claim.png)

* [Hash Claim ETH](https://testnet.starkscan.co/tx/0xc5aec6862f702dccc57fc616b1cd387ea9992476dd42aecf10ab59088a8f63)

![Graph](/src/min_staking/im%C3%A1genes/infor1.png)


Como podremos comprobar ha cambiado nuestra lista el `claim_status` a `1`, podremos revisar en la lista de llamadas de nuestro contrato [aquí](https://testnet.starkscan.co/contract/0x010313bd5969cf62a539f0794e6dbdcce802647a4eb40c5176d713a901d45521#account-calls) los `stake` y `claim` que se han realizado.

![Graph](/src/min_staking/im%C3%A1genes/list.png

---

## Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `amm.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src//min_staking/im%C3%A1genes/lib.png)

---
