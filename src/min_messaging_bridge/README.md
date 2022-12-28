## Guia MIN-MESSAGING BRIDGE

Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Una vez instalado y clonado este repositorio no hará falta iniciar el proyecto con `protostar`, nos dirijimos directamente al archivo `protostar.toml` para revisar su información. Como ven estan añadidos todos los contratos y la configuración de `testnet2` para el deploy, así que nos han dejado el trabajo para hacer los MINIMOS esfuerzos `Min-Starknet`, así que intentaré seguir en esa línea para esta guía. 

----

### Ajustes Account

En esta nueva version de protostar `0.9.1` tendremos que crear un perfil que añadirermos en [protostar.toml](/protostar.toml) en el que defineremos el usuario de cuenta que pagará el fee. Usaremos los ajustes `PARA TESTNET` aunque también estan preparados para `TESTNET2`. La cuenta de ArgentX para la guía será `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` (EN SU CASO AÑADIR LA VUESTRA) para el deploy del [token_bridge.cairo](/src/min_messaging_bridge/L2/token_bridge.cairo) y el [ERC20.cairo](/src/min_messaging_bridge/L2/token/ERC20.cairo). Tendremos que exportar nuestra `PRIVATE KEY` de esa cuenta de ArgentX. En la versión `0.9.0 protostar` teniamos que pasarlo a `hexa` usando [Stark-utils](https://www.stark-utils.xyz/converter).

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

## Funcionamiento Mensajes entre L2 - L1

Primero hablaremos de los pasos a seguir para poder hacer el desarrollo de los mensajes entre capas de L1 y L2.  Deberemos disponer de 4 contratos que deployaremos. Para implementar una solución de puente ERC20 entre Ethereum (L1) y StarkNet (L2), necesitarás seguir los siguientes pasos:

1. Diseña y desarrolla tus contratos de ERC20 en Ethereum (L1) en nuestra guía lo llameremos [`WNAI L1`](/src/min_messaging_bridge/L1/contracts/token/ERC20.sol) y StarkNet (L2) lo llamaremos [`WNAI L2`](/src/min_messaging_bridge/L2/token/ERC20.cairo). 

2. Diseña y desarrolla tus contratos de puente para Ethereum (L1) en nuestra guía lo llamaremos [`Token Bridge L1`](/src/min_messaging_bridge/L1/contracts/TokenBridge.sol) y StarkNet (L2) lo llamaremos [`Token Bridge L2`](/src/min_messaging_bridge/L2/token_bridge.cairo).

3. Primero despliega el contrato de [ERC20 en StarkNet (L2) `WNAI L2`](/src/min_messaging_bridge/L2/token/ERC20.cairo). Asegúrate de hacer un seguimiento de la dirección de este contrato y de guardarla en un lugar seguro.

4. Despliega el contrato de puente en StarkNet (L2) [`Token Bridge L2`](/src/min_messaging_bridge/L2/token_bridge.cairo) y proporciona la dirección del contrato de ERC20 en StarkNet (L2) `WNAI L2` y la dirección del administrador del contrato de puente como parámetros, en este caso la cuenta de ArgentX que usaremos para el Deploy. Asegúrate de hacer un seguimiento de la dirección de este contrato y de guardarla en un lugar seguro.

5. Despliega el contrato de puente en Ethereum (L1) [`Token Bridge L1`](/src/min_messaging_bridge/L1/contracts/TokenBridge.sol) y proporciona la dirección del contrato de StarkNet Core en Ethereum (L1) `0xde29d060D45901Fb19ED6C6e959EB22d8626708e`, la dirección del contrato de puente en StarkNet (L2) [`Token Bridge L2`](/src/min_messaging_bridge/L2/token_bridge.cairo) que hemos deployado antes y la dirección del administrador del contrato de puente como parámetros. Asegúrate de hacer un seguimiento de la dirección de este contrato y de guardarla en un lugar seguro.

6. Configura los contratos de puente para que se comuniquen entre sí y para que se sincronicen adecuadamente con los contratos de ERC20 correspondientes en cada red. En este paso añadiremos la dirección de token de l1 en el contrato de Token Bridge L1 y también aprobaremos el `WNAI L2` y `WNAI L1` para que se puedan transferir entre los puentes.

7. Despliega el contrato de ERC20 en Ethereum (L1) [`WNAI L1`](/src/min_messaging_bridge/L1/contracts/token/ERC20.sol) y proporciona la dirección del contrato de puente en Ethereum (L1) [`Token Bridge L1`](/src/min_messaging_bridge/L1/contracts/TokenBridge.sol) que hemos deployado antes como parámetro. Asegúrate de hacer un seguimiento de la dirección de este contrato y de guardarla en un lugar seguro. 

---

## Compile y Declare Token_Bridge L2 y ERC20 (WNAI L2)

Primero haremos los deploy del token [`WNAI L2`](/src/min_messaging_bridge/L2/token/ERC20.cairo) y luego [`Token Bridge L2`](/src/min_messaging_bridge/L2/token_bridge.cairo) como habiamos configurado en el orden, para ello primeros haremos la compilación de nuestros contratos y conseguimos los `Class Hash` con el siguiente comando.


```bash
protostar build
```

![Graph](/src/min_ens/imagenes/build.png)


Ahora nos quedaremos con el class hash del `Bridge_ERC20` y del `Bridge` para hacer el `deploy`. En el caso del `declare` la mayoría ya los tenían realizados creados por otros usuarios, igualmente los `declare` para esta guía. También comprobaremos que todo este bien, así que pasaremos los comandos.


```bash
protostar -p testnet declare ./build/bridge_erc20.json --max-fee auto
```

![Graph](/src/min_messaging_bridge/im%C3%A1genes/declarewnai.png)

* [Hash Declare ERC20 WNAI L2](https://testnet.starkscan.co/class/0x04dae654c7b6707667a178729b512d61494fe590ab4accc46923d6409b97e617)

Y ahora el del [Token Bridge L2](/src/min_messaging_bridge/L2/token_bridge.cairo)

```bash
protostar -p testnet declare ./build/bridge.json --max-fee auto
```

![Graph](/src/min_messaging_bridge/im%C3%A1genes/declarebridge.png)

* [Hash Declare Token Bridge L2](https://testnet.starkscan.co/class/0x059b508475ce0c231fdb9c35e1a3bf7da28ef32dec28cf4c76395c23ea369aac)

---

## Deploy WNAI L2 y Token Bridge L2 

Para esta nueva guía podriamos haber usado el antiguo [NAI](https://testnet.starkscan.co/contract/0x0005cb4b24c874d2a7378a21286f3e70a9a4447567bf8f9b8de71b8a75f32abb#overview)
 o cualquier ERC20. Pero queremos hacerla desde 0 usando nuevos nombres pasados a felt con [Stark-utils](https://www.stark-utils.xyz/converter). En este caso tendremos que pasar 6 argumentos al constructor `Nombre, Simbolo, Decimales, Totalsupply en unit 256 (ejemplo 100 = 100, 0 puede usar` [Stark-utils](https://www.stark-utils.xyz/converter), `y el recipient`, en nuestro caso os dejo la conversión usada.

* Nadai Token = 94756135172363843420251502
* WNAI = 1464746313
* Decimales = 18
* Total Supply = 100, 0
* Recipient = 1795950254530259382270168937734171348535331377400385313842303804539016002736

Podriamos usar el contrato Universal para los deploy [UDC](https://testnet.starkscan.co/contract/0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf#write-contract) pero usaremos `Protostar` en este caso pasando el `Class Hash` del `WNAI L2`.


```
protostar -p testnet deploy 0x04dae654c7b6707667a178729b512d61494fe590ab4accc46923d6409b97e617 --max-fee auto -i 94756135172363843420251502 1464746313 18 100 0 1795950254530259382270168937734171348535331377400385313842303804539016002736
```

* [Hash Deploy WNAI L2](https://testnet.starkscan.co/tx/0x05a18bff8ea0a4403b2d9293f8ebf29c558615f21e620bed8f73d05b8fa3013f)
* [Contract Address WNAI L2](https://testnet.starkscan.co/contract/0x03ebed248164a89856cc6dc327ec1646309ec24ad03f1ad530cbbcb251b9cd4c)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/deploywnail2.png)


Y también haremos lo mismo con el `deploy` del `Token Bridge L2`, en el que nos hará falta pasar 2 argumentos. La función tiene dos parámetros de entrada [l2_address](/src/min_messaging_bridge/L2/token_bridge.cairo#L43) y [admin_address](/src/min_messaging_bridge/L2/token_bridge.cairo#L44). La `L2_address` representa la dirección de un contrato ERC-20 en la capa 2, en este caso el [WNAI L2](https://testnet.starkscan.co/contract/0x03ebed248164a89856cc6dc327ec1646309ec24ad03f1ad530cbbcb251b9cd4c) que la pasaremos a `felt` y la `admin_address` representa la dirección del administrador del contrato, en este caso la usada como cuenta en `ArgentX`.

```bash
protostar -p testnet deploy 0x059b508475ce0c231fdb9c35e1a3bf7da28ef32dec28cf4c76395c23ea369aac --max-fee auto -i 1773784304041683024628802811964043081912746145383244941766373307155679399244 1795950254530259382270168937734171348535331377400385313842303804539016002736
```

* [Hash Deploy Token Bridge L2](https://testnet.starkscan.co/tx/0x0161c170863bea6c0fd9c251934d3a23aacd451200fdbe36e5f65767b2f853e5)
* [Contract Address Token Bridge L2](https://testnet.starkscan.co/contract/0x064346248fa5758976f1276d8de84c5b28d13aa28476c268169af03afe4b2668)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/deploybridgel2.png)

---

## Deploy WNAI L1 y Token Bridge L1

Dentro de [Remix](https://remix.ethereum.org/) la usaremos para deployar el [`WNAI L1`](/src/min_messaging_bridge/L1/contracts/token/ERC20.sol) y [`Token Bridge L1`](/src/min_messaging_bridge/L1/contracts/TokenBridge.sol). Necesitaremos 4 contratos en [Remix](https://remix.ethereum.org/) para todos los ajustes ([IStarknetCore](/src/min_messaging_bridge/L1/contracts/IStarknetCore.sol),[Token Bridge L1](/src/min_messaging_bridge/L1/contracts/TokenBridge.sol), [ERC20 WNAI L1](/src/min_messaging_bridge/L1/contracts/token/ERC20.sol) y tambien crear una carpeta con nombre de token y añadir el contrato [IERC20](/src/min_messaging_bridge/L1/contracts/token/IERC20.sol), la raiz debe de quedar así.

![Graph](/src/min_messaging_bridge/im%C3%A1genes/remix.png)


Ahora le deberian dejar poder compilar tanto [Token Bridge L1](/src/min_messaging_bridge/L1/contracts/TokenBridge.sol) como [ERC20 WNAI L1](/src/min_messaging_bridge/L1/contracts/token/ERC20.sol), para ello deberemos revisar la version de pragma solidity utilizada, hacer el compile del [Token Bridge L1](/src/min_messaging_bridge/L1/contracts/TokenBridge.sol) y ahora el deploy, pero antes iremos a la terminal para obtener el `StarknetCore` que tendremos que indicar, luego la dirección de [Contract Address Token Bridge L2](https://testnet.starkscan.co/contract/0x064346248fa5758976f1276d8de84c5b28d13aa28476c268169af03afe4b2668) y la wallet del admin de L1 que usaremos para el Deploy `0x3AC83946966B5E2cf4BB24d807a0Dd8232fea4ea`. Así que pasaremos en la terminal para conseguir el `StarknetCore`.


```bash
python3.9 -m venv ~/cairo_venv
source ~/cairo_venv/bin/activate
```

```
starknet get_contract_addresses --network alpha-goerli
```

![Graph](/src/min_messaging_bridge/im%C3%A1genes/core.png)

Ahora ya tenemos último starknetcore oficial (`0xde29d060D45901Fb19ED6C6e959EB22d8626708e`) que nos hara falta como argumento y procederemos a conectar nuestro Metamask en Goerli y conectarlo a Remix, para ello vamos a `Deploy Run Transactions` en `Environment` y cambiamos a `Injected Provider Metamask` como mostramos en la siguiente imagen.


![Graph](/src/min_messaging_bridge/im%C3%A1genes/deploybridgel1.png)


* [Hash Deploy Token Bridge L1](https://goerli.etherscan.io/tx/0x7eff000307a9bacc0424b289af9cae926c55365227b1da036e2acb65f30adbb4)
* [Contract Token Bridge L1](https://goerli.etherscan.io/address/0x26f7ceb56d7d024d60c2040b3bb961fa266989a5#code)

--- 

### Verify con Remix

Para hacer `read` o `write` desde la tesnet deberemos verificarlo. En plugin de Remix buscaremos `ETHERSCAN - CONTRACT VERIFICATION`, y la instaleremos.

Ahora necesitamos una API Key de [Etherscan](https://etherscan.io/myapikey), entramos nos registramos y añadimos una nueva que copiaremos para añadirla en remix. Dentro de Remix necesitamos añadir varios valores, revise [Hash Deploy Token Bridge L1](https://goerli.etherscan.io/tx/0x7eff000307a9bacc0424b289af9cae926c55365227b1da036e2acb65f30adbb4), o el `Deploy` del Smart que han realizado, para copiar los Argumentos del Constructor desde donde empiezan muchos `0` fíjese en la foto.

![Graph](/src/min_messaging_bridge/im%C3%A1genes/verify.png)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/verify2.png)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/verify3.png)

**Una vez dado a `verify` ya debería poder escribir en él, recordar este paso ya que lo volveremos a realizar para verificar el [Contract Address WNAI L1](https://goerli.etherscan.io/address/0x7b0d0a2c75f8db677269a86ca4ee31420371baf8#code), las fotos aportadas son de los 2 contratos**

---

**Puede revisar guía completa de VERIFICACIÓN en REMIX [aquí](https://github.com/Nadai2010/Nadai-Chainlink-dNFT#deploy-con-remix)** 

---

Ahora ya podremos pasar a deployar nuestro [ERC20 WNAI L1](/src/min_messaging_bridge/L1/contracts/token/ERC20.sol) en Remix, pasaremos como argumentos la dirección del [Contract Token Bridge L1](https://goerli.etherscan.io/address/0x26f7ceb56d7d024d60c2040b3bb961fa266989a5#code) que acabmos de crear.

![Graph](/src/min_messaging_bridge/im%C3%A1genes/deploywnail1.png)

* [Hash Deploy WNAI L1](https://goerli.etherscan.io/tx/0xc0b7c0ae439aa4d9a275df2f06fdac0e5c9c65e3087a6c6e9bae65adcee7c0d6)
* [Contract Address WNAI L1](https://goerli.etherscan.io/address/0x7b0d0a2c75f8db677269a86ca4ee31420371baf8#code)

---

### Ajustes de Contratos

Ahora iremos ajustar en [Contract Address Token Bridge L2](https://testnet.starkscan.co/contract/0x064346248fa5758976f1276d8de84c5b28d13aa28476c268169af03afe4b2668) nuestro [Contract Token Bridge L1](https://goerli.etherscan.io/address/0x26f7ceb56d7d024d60c2040b3bb961fa266989a5#code). Solo deberemos añadir la dirección del contrato.

![Graph](/src/min_messaging_bridge/im%C3%A1genes/setl1.png)

* [Hash set_bridge_l1_address](https://testnet.starkscan.co/tx/0x7b4700856025882e00c94cbebb2427432f2770ada36fb1258c1755bc3a98066)

---

Ahora ye tenemos creados nuestros token en ambas redes y nuestro puentes comunicados, falta añadir al [Contract Token Bridge L1](https://goerli.etherscan.io/address/0x26f7ceb56d7d024d60c2040b3bb961fa266989a5#code) el [Contract Address WNAI L1](https://goerli.etherscan.io/address/0x7b0d0a2c75f8db677269a86ca4ee31420371baf8#code)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/setl1token.png)

* [Hash set_l1_token](https://goerli.etherscan.io/tx/0xdceadf83fc80b3c6d34e4e6482b26586a0c8cac03afc61dec0f708519a12fb73)

---

Luego aprobaremos a [Contract Address WNAI L2](https://testnet.starkscan.co/contract/0x03ebed248164a89856cc6dc327ec1646309ec24ad03f1ad530cbbcb251b9cd4c) que el [Contract Address Token Bridge L2](https://testnet.starkscan.co/contract/0x064346248fa5758976f1276d8de84c5b28d13aa28476c268169af03afe4b2668) pueda gastar los `WNAI L2`, en la guía pusimos `100`.

![Graph](/src/min_messaging_bridge/im%C3%A1genes/aprovewnail2.png)
![Graph](/src/min_messaging_bridge/im%C3%A1genes/allowancewnail2.png)

* [Hash Approve WNAI en L2 al Token Bridge L2](https://testnet.starkscan.co/tx/0x14a1f2ad3d6426207c6fb31e380be9e0900460239eeb96ad4e77a2c68343f46)

---

## Withdraw de L2 a L1

Ahora ya tenemos todos los contratos ajustados y haremos el withdraw hacia L1, desde [Contract Token Bridge L2](https://testnet.starkscan.co/contract/0x064346248fa5758976f1276d8de84c5b28d13aa28476c268169af03afe4b2668#write-contract) con la función `withdraw_to_l1`. Haremos dos puebas con envios de `10` a la dirección de la wallet que estamos usando de ETH en MM.

![Graph](/src/min_messaging_bridge/im%C3%A1genes/with1.png)
![Graph](/src/min_messaging_bridge/im%C3%A1genes/with2.png)

* [Hash withdraw_to_l1](https://testnet.starkscan.co/tx/0x231236a859620973f506ac5decc40327395dd403456cf50a599108a9a82332d)
* [Hash withdraw_to_l1_ segundo](https://testnet.starkscan.co/tx/0x439c24b43e9dfab3a54d677f1692698b5f7e793061108da5e897e534d37b4a9)

Aquí podemos comprobar como nuestro balance ha disminuido a `80` pero debemos de esperar a que se confirmen los mensajes en `L1`, para poder consumirlos desde [Contract Token Bridge L1](https://goerli.etherscan.io/address/0x26f7ceb56d7d024d60c2040b3bb961fa266989a5#writeContract#F1) con `deposit_to_l1` indicando la cantidad de `10` en cada transacción, asì podremos consumir el mensaje y hacer que se `mint` en `L1`.

![Graph](/src/min_messaging_bridge/im%C3%A1genes/balance.png)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/deposit.png)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/balancel1.png)

![Graph](/src/min_messaging_bridge/im%C3%A1genes/mensajes.png)

* [Hash 10 deposit_to_l1](https://goerli.etherscan.io/tx/0x4a8f36c89d3d78856df1d9e8e0f0bae35836fbe67c96e5e16eaefdaf741a0292)
* [Hash 10 deposit_to_l1](https://goerli.etherscan.io/tx/0x085702550f2ef786b53b11d16eb31afde61b296c3ae396555f3c81563fdb44e1)

Ahora podemos revisar en [Contract Address WNAI L1](https://goerli.etherscan.io/address/0x7b0d0a2c75f8db677269a86ca4ee31420371baf8#readContract#F7) el `TotalSupply` como pasó de `0` a `20 WNAI L1`

![Graph](/src/min_messaging_bridge/im%C3%A1genes/wnail1.png)

---

## Verificación Starkscan

Como tarea extra podemos dejar verificado nuestro contrato en `Starkscan`, para ello debemos de tener instalada y guardado el contrato que acabamos de hacer el `Deploy`. Ejecutamos el siguiente comando, escogemos el `token_bridge.cairo` y luego el `ERC20.cairo` y vamos siguiendo los pasos. (EN CASO ERROR EN LA RUTA SOLO HAY QUE AÑADIR LA PALABRA `lib`)

```bash
starkscan
```

![Graph](/src/min_messaging_bridge/im%C3%A1genes/lib.png)

---
