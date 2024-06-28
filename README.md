# trabalho-bdd-2024-1
Trabalho final da disciplina Bancos de Dados Distribuídos do PGC da UFF,  ministrada pelo Professor Daniel Cardoso Moraes de Oliveira.

O propósito deste trabalho é criar um cluster com Apache hadoop usando Apache Hive em modo pseudo-distribuido para processamento de consultas em paralelo em um banco de dados distribuído ao qual foi aplicado um projeto de fragmentação.

1. Primeiramente você deve ter o Docker instalado no seu sistema. Para obter informações de como proceder nessa caso clique [aqui](https://docs.docker.com/engine/install/ubuntu/)

2. Em seguida descompacte o arquivo /dataset/dataset.zip dentro da pasta /cluster/polroute. Os arquivos csv devem estar no primeiro nível da pasta polroute.

3. Abra um terminal, navegue até a pasta cluster e inicie os containers com o comando:

    sudo docker compose up  
