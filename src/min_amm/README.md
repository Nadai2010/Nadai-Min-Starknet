## Guia MIN-AMM

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

## Compile y Declare AMM

Ahora para compilar nuesrto token `amm.cairo` y el resto de contratos sólo deberemos pasar el siguiente comando y obtendremos también cada uno de sus `Class Hash`.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)

Ahora nos quedaremos con el class hash del `Nft_market` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían  realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos el comando.


```bash
protostar -p testnet declare ./build/amm.json --max-fee auto
```

![Graph](/src/min_amm/im%C3%A1genes/declare.png)

* [Hash Declare AMM](https://testnet.starkscan.co/class/0x029c1607118a327b6e5c22f7309b5fb34a1711101e6f6f28283cfcaa4974e95a)

---

## Deploy de AMM con Protostar

Usaremos esta vez para el `Min-Starknet` protostar, ya que no debemos pasar argumentos así directamente podremos hacer el `deploy` usando el siguiente comando.


```bash
protostar -p testnet deploy 0x029c1607118a327b6e5c22f7309b5fb34a1711101e6f6f28283cfcaa4974e95a --max-fee auto
```

![Graph](/src/min_amm/im%C3%A1genes/deploy.png)


* [Hash Deploy](https://testnet.starkscan.co/tx/0x038eaa1bd8ae6500b70309f07e2442e5f999dd0e4c17da002ed69d6c79774eb5)
* [Contract AMM](https://testnet.starkscan.co/contract/0x05e9df69f5e8ee9aa3870d890e738e33de52bead33d0c96633dc8b52b4ceb8b2)

---

### Función Set Pool Token Balance

El contrato parece manejar dos tipos de tokens diferentes denominados `TOKEN_TYPE_A` y `TOKEN_TYPE_B`, que se mantienen en una `pool` o `reserva` dentro del contrato. La función [set_pool_token_balance](/src/min_amm/amm.cairo#L69) se utiliza para establecer el saldo de un tipo de token en la pool. La función toma dos parámetros de entrada: `token_type`, que especifica el tipo de token a establecer el saldo, y `balance`, que especifica el saldo de token a establecer. La función verifica que el saldo no exceda un límite superior permitido (denominado `BALANCE_UPPER_BOUND`) y, si es así, lanza una excepción con un mensaje de error específico. Si el saldo es válido, la función escribe el saldo de token en la pool en el almacenamiento del contrato.

En nuestro caso hemos pasado la dirección de [ETH en Starknet](https://testnet.starkscan.co/contract/0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7#write-contract)y la dirección del [Contract ERC20 NAI](https://testnet.starkscan.co/contract/0x0005cb4b24c874d2a7378a21286f3e70a9a4447567bf8f9b8de71b8a75f32abb#overview) que hemos deployado antes, asi como la cantidad que hemos querido.

![Graph](/src/min_amm/im%C3%A1genes/seteth.png)

![Graph](/src/min_amm/im%C3%A1genes/setnai.png)

---

### Función Add demo token

La función [add_demo_token](/src/min_amm/amm.cairo#L84) se utiliza para agregar tokens de demostración a la cuenta del llamador. La función toma dos parámetros de entrada: "token_a_amount", que especifica la cantidad de TOKEN_TYPE_A a agregar a la cuenta, y "token_b_amount", que especifica la cantidad de TOKEN_TYPE_B a agregar a la cuenta. La función utiliza la función "modify_account_balance" para modificar el saldo de TOKEN_TYPE_A y TOKEN_TYPE_B de la cuenta del llamador.

![Graph](/src/min_amm/im%C3%A1genes/demo.png)

* [Hash Add Demo](https://testnet.starkscan.co/tx/0x510ed55725235be28ff236797d0f94b015477339247c99075fe1558efc21311)

---

## Función Set Pool Token Balance

La función lee la variable `pool_balance` y devuelve su valor para un determinado `token_type`. La variable pool_balance es presumiblemente un mapeo (arreglo asociativo) que asocia tipos de tokens con sus balances. La función read() es un método de la variable `pool_balance` que recupera el valor asociado con una clave dada (en este caso, el token_type).

![Graph](/src/min_amm/im%C3%A1genes/readbalance.png)

---

### Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `amm.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src/min_amm/im%C3%A1genes/starkscan.png)

---





