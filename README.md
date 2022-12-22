# MIN-STARKNET

Min-StarkNet es un proyecto paralelo influenciado por [Lil-Web3](https://github.com/m1guelpf/lil-web3) de Miguel Piedrafita, destinado a crear implementaciones mínimas e intencionalmente limitadas de diferentes protocolos, estándares y conceptos para ayudar a un principiante de Cairo a aprender y familiarizarse con las sintaxis básicas de Cairo, avanzando rápidamente de principiante a  intermedio😉.

## Empezando
Este proyecto utiliza Protostar como marco de desarrollo. Para comenzar con Protostar, siga las guías contenidas en los [documentos oficiales](https://docs.swmansion.com/protostar/docs/tutorials/installation).

Tenga en cuenta que Protostar actualmente tiene soporte solo para Linux y MacOS, por lo que si está ejecutando un sistema operativo Windows, intente consultar WSL2.

Una vez que haya instalado Protostar, siga adelante para clonar el repositorio ejecutando el siguiente comando en una terminal:

```bash
git clone git@github.com:Darlington02/min-starknet.git
```

**PD: asegúrese de seguir el repositorio, en el orden especificado a continuación para obtener la máxima eficiencia, y siempre lea los comentarios del código para comprender de manera efectiva los códigos subyacentes, Y podría ser útil tener en cuenta también que goerli2 fue la red más utilizada durante el desarrollo**

Finalmente, este repositorio está dirigido a aquellos con conocimientos básicos de cómo funcionan Cairo y StarkNet. Si no comprende la sintaxis básica de El Cairo, tómese un tiempo para leer primero mi serie Journey through Cairo en [medium](https://medium.com/@darlingtonnnam).

## MIN-ENS
Min-ens es una implementación simple de un servicio de espacio de nombres en El Cairo. Contiene una sola función externa `store_name` y una sola función de vista `get_name`. Una variable de almacenamiento `names` que es una asignación de **dirección** a **nombre**, también se usa para almacenar los nombres asignados a cada dirección, y un evento **nombre_almacenado** que se emite cada vez que un nombre ¡está almacenado!

También hay disponible un archivo de prueba básico [aquí](https://github.com/Nadai2010/Nadai-Min-Starknet/blob/master/tests/test_ens.cairo) para ayudarlo a aprender los conceptos básicos de la escritura de pruebas en Cairo con Protostar.
