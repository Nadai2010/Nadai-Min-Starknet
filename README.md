# MIN-STARKNET

Min-StarkNet es un proyecto paralelo influenciado por [Lil-Web3](https://github.com/m1guelpf/lil-web3) de Miguel Piedrafita, destinado a crear implementaciones mínimas e intencionalmente limitadas de diferentes protocolos, estándares y conceptos para ayudar a un principiante de Cairo a aprender y familiarizarse con las sintaxis básicas de Cairo, avanzando rápidamente de principiante a  intermedio😉.

## Empezando
Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Tenga en cuenta que Protostar actualmente tiene soporte solo para Linux y MacOS, por lo que si está ejecutando un sistema operativo Windows, intente consultar WSL2.

Una vez que haya instalado Protostar, siga adelante para clonar el repositorio ejecutando el siguiente comando en una terminal:

* Original Darlington02

```bash
git clone git@github.com:Darlington02/min-starknet.git
```

* Nadai con Guía

```bash
gh repo clone Nadai2010/Nadai-Min-Starknet
```

**PD: asegúrese de seguir el repositorio, en el orden especificado a continuación para obtener la máxima eficiencia, y siempre lea los comentarios del código para comprender de manera efectiva los códigos subyacentes, Y podría ser útil tener en cuenta también que goerli2 fue la red más utilizada durante el desarrollo**

Finalmente, este repositorio está dirigido a aquellos con conocimientos básicos de cómo funcionan Cairo y StarkNet. Si no comprende la sintaxis básica de El Cairo, tómese un tiempo para leer primero mi serie Journey through Cairo en [medium](https://medium.com/@darlingtonnnam).

---
## MIN-ENS
Min-ens es una implementación simple de un servicio de espacio de nombres en El Cairo. Contiene una sola función externa `store_name` y una sola función de vista `get_name`. Una variable de almacenamiento `names` que es una asignación de **dirección** a **nombre**, también se usa para almacenar los nombres asignados a cada dirección, y un evento **nombre_almacenado** que se emite cada vez que un nombre ¡está almacenado!

También hay disponible un archivo de prueba básico [aquí](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/tests/test_ens.cairo) para ayudarlo a aprender los conceptos básicos de la escritura de pruebas en Cairo con Protostar.

* [NADAI GUIA ENS](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_ens/README.md)

---

## MIN-ERC20
Una de las cosas básicas que aprendemos a hacer al comenzar con el desarrollo de contratos inteligentes es aprender a construir e implementar el popular contrato de token ERC2O. En este repositorio, implementamos el estándar ERC20 usando [la biblioteca de Openzeppelin](https://github.com/OpenZeppelin/cairo-contracts/blob/main/src/openzeppelin/token/erc20/library.cairo).

El objetivo de este proyecto es construir e implementar un contrato de token ERC20 simple.

Para mejorar en la redacción de pruebas, puede intentar comprender y replicar la prueba de contrato ERC20 cairo [aquí](https://github.com/Darlington02/min-starknet/blob/master/tests/test_erc20.cairo).

* [NADAI GUIA ERC20](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_erc20/README.md)

---

## MIN-ERC721
Min-erc721 implementa el estándar de token ERC721 (tokens no fungibles) en El Cairo utilizando [la biblioteca de Openzeppelin](https://github.com/OpenZeppelin/cairo-contracts/blob/main/src/openzeppelin/token/erc721/library.cairo).

El objetivo es construir e implementar un contrato ERC721 simple en Starknet.

También hay un archivo de prueba disponible [aquí](https://github.com/Darlington02/min-starknet/blob/master/tests/test_erc721.cairo)

* [NADAI GUIA ERC721](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_erc721/README.md)

---

## MIN-NFT-MARKETPLACE
Min-nft-marketplace es una implementación mínima de un NFT Marketplace para comprar y vender tokens NFT.

Implementa dos funciones externas, `list_token(token_contract_address, token_id, price)` para enumerar tokens en el mercado y `buy_token(listing_id)` para comprar tokens en el mercado.

Los eventos `listing_created` y `listing_sold` también se emiten cada vez que se enumera o vende un token.

**Nota: Recuerde llamar a setApprovalForAll(marketplace_contract_address, true) en el contrato para el NFT que está enumerando antes de llamar a la función `list_token`**

Próximamente archivo de prueba..

* [NADAI GUIA NFT MARKET](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_nft_marketplace/README.md)

---

## MIN-AMM
Min-amm es una implementación mínima de un creador de mercado automatizado en El Cairo. Los códigos fuente se obtuvieron y se modificaron mínimamente de los [Cairo docs](https://www.cairo-lang.org/docs/hello_starknet/amm.html), por lo que puede consultarlos en caso de que se confunda.

También se creó un archivo de prueba [aquí](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/tests/test_amm.cairo).

* [NADAI GUIA AMM](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_amm/README.md)

## MIN-ICO
Min-ico es una implementación mínima de una preventa o ICO en El Cairo. Una oferta inicial de monedas **ICO** es el equivalente a una IPO, una forma popular de recaudar fondos para productos y servicios generalmente relacionados con criptomonedas.

El proceso de pensamiento para esta aplicación es que un usuario interesado en participar en la ICO debe registrarse primero con `0.001 ETH` llamando a la función `register` , luego, una vez que expire la duración de la ICO especificada usando `ICO_DURATION`, ahora puede llamar a la función externa `claim` para reclamar su parte de tokens ICO.

PD: Todos los usuarios que participan en la ICO pagan la misma cantidad por el registro y reclaman la misma cantidad de tokens.

**Nota: Recuerde llamar a aprobar(<dirección del contrato>, reg_amount) en el contrato ETH de StarkNet antes de llamar a la función `registrar`**

* [NADAI GUIA ICO](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_ico/README.md)

---

## MIN-STAKING
Min-stake es una implementación mínima de un contrato de staking en El Cairo.

El staking es un proceso popular de bloquear una cierta cantidad de sus tenencias criptográficas para obtener recompensas o ganar intereses.

El proceso de pensamiento para esta aplicación requiere que un usuario primero deposite una cierta cantidad del token ERC20 para apostar llamando a la función `stake (stake_amount, duration_in_secs)`, y finalmente reclame los tokens + el interés acumulado una vez que la duración haya terminado por llamando a la función `claim_rewards(stake_id)`.

**Nota: Recuerde llamar a aprobar(stake_contract_address, stake_amount) en el contrato StarkNet ETH antes de llamar a la función `stake`**

* [NADAI GUIA STAKE](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_staking/README.md)

---

## MIN-ERC20-PUENTE DE MENSAJERÍA
La capacidad de crear puentes de mensajería personalizados en StarkNet para transferencias de datos y activos es una de las características principales que hace que StarkNet se destaque de otros paquetes acumulativos existentes.

En este proyecto, vamos a crear un puente de mensajería ERC20 personalizado simple que puede ayudar a un usuario a transferir un token ERC20 entre StarkNet y Ethereum.

El proceso de pensamiento para esta aplicación es que tenemos un token ERC20 implementado en StarkNet, que pretendemos conectar con Ethereum, para permitir que los usuarios envíen sus tokens entre capas. Primero tenemos que implementar un clon de nuestro token ERC20 en Ethereum, con un suministro inicial cero (esto se hace para garantizar que el suministro total en las diferentes capas, cuando se suma, permanezca constante). Luego implementamos nuestro token bridge en ambas capas, configurando el token ERC20 que queremos unir en particular.

Cada vez que ocurre un puente desde L2 -> L1, los tokens puenteados se bloquean en el contrato puente L2, y la misma cantidad de tokens puenteados se acuñan en L1 para el usuario, y cada vez que ocurre un puente desde L1 -> L2, el los tokens puenteados se queman y la misma cantidad de tokens puenteados se libera o transfiere del contrato puente L2 al usuario, por lo que siempre se mantiene constante el suministro total.

* [NADAI GUIA ERC20 BRIDGE](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/src/min_messaging_bridge/README.md)

---