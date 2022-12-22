## Guia MIN-ENS

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

## Compile y Declare ENS

Ahora para compilar `Ens` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)


Ahora nos quedaremos con el class hash del `ens` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/ens.json --max-fee auto
```

![Graph](/src/min_ens/imagenes/declare.png)

* [Hash Declare Ens](https://testnet.starkscan.co/tx/0x0056245f8579b9e04bb99a9f128cd00106600d0856c46d055126abbe3361a934)

---

## Deploy de ENS con UDC

Usaremos por comodidad para el `Min-Starknet` el contrato Universal para los deploy [UDC](https://testnet.starkscan.co/contract/0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf#write-contract). En este caso pasaremos sólo con añadir en `calldata_len = 1` sera suficiente, podemos dejar en `calldata = 0`. 

![Graph](/src/min_ens/imagenes/deploy.png)


* [Hash Deploy](https://testnet.starkscan.co/tx/0x049d497c5ce444a5b7ba6258b93b45abcf15eac8f3456983b5921d4e45cd1d84)
* [Contract ens](https://testnet.starkscan.co/contract/0x03a43a99eefbda0daa08d5f94091ff8a5fe95a0eece42a2199daae2474238c9f#overview)

---

## Creando ENS

De la cuenta de ArgentX y el nombre de `NadaiEns` pasado a felt con [Stark-utils](https://www.stark-utils.xyz/converter) y usaremos nuestro contrato recién deployado [ens](https://testnet.starkscan.co/contract/0x03a43a99eefbda0daa08d5f94091ff8a5fe95a0eece42a2199daae2474238c9f#write-contract) y pasaremos a escribir `store_name` que hemos obtenido en `felt` antes, así probaremos si se guarda con nuestra cuenta el dominio.

![Graph](/src/min_ens/imagenes/store.png)

* [Hash store_name](https://testnet.starkscan.co/tx/0x3d66fd70325d79927182fa35ebdfdef109881165a3d3886c5637a300d412763)

Y podemos verificar pasando en `get_name` la cuenta con la que hemos creado `NadaiEns` y verificar que todo ha sido guardado y realizado con exito.

![Graph](/src/min_ens/imagenes/ens.png)

---

### Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `ens.cairo` y vamos siguiendo los pasos.

```bash
starkscan
```

![Graph](/src/min_ens/imagenes/starkscan.png)

