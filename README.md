# trabalho-bdd-2024-1
Trabalho final da disciplina Bancos de Dados Distribuídos do PGC da UFF,  ministrada pelo Professor Daniel Cardoso Moraes de Oliveira.

O propósito deste trabalho é criar um cluster com Apache hadoop usando Apache Hive em modo pseudo-distribuido para processamento de consultas em paralelo em um banco de dados distribuído ao qual foi aplicado um projeto de fragmentação.

1. Primeiramente você deve ter o Docker instalado no seu sistema. Para obter informações de como proceder nessa caso clique [aqui](https://docs.docker.com/engine/install/ubuntu/)

2. Em seguida descompacte o arquivo /dataset/dataset.zip dentro da pasta /cluster/polroute. Os arquivos csv devem estar no primeiro nível da pasta polroute.

3. Abra um terminal, navegue até a pasta cluster e inicie os containers com o comando:

```shell
sudo docker compose up  
```

4. Entre em um terminal no hive-server:

```shell
sudo docker exec -it hive-server /bin/bash
```

5. Navegue até as pasta polroute e execute o DDL das tabelas não fragmentadas:

```shell
cd ..
cd polroute
hive -f database_ddl_nofrag.hql
```

6. Com as tabelas criadas podemos dar carga nelas a partir dos dados de cada um dos arquivos csv presentes no diretório polroute:

```shell
hadoop fs -put crime.csv hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_nofrag.db/crime
hadoop fs -put time.csv hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_nofrag.db/time
hadoop fs -put district.csv hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_nofrag.db/district
hadoop fs -put neighborhood.csv hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_nofrag.db/neighborhood
hadoop fs -put vertice.csv hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_nofrag.db/vertice
hadoop fs -put segment.csv hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_nofrag.db/segment
```

7. Entre na linha de comando do hive sete o database a ser usado:

```
hive
use trabalho_bdd_nofrag
```

8. Para testar, execute uma consulta:

```sql
select
    crime.segment_id,
    sum(crime.total_feminicide),
    sum(crime.total_homicide),
    sum(crime.total_felony_murder),
    sum(crime.total_bodily_harm),
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto)
from
    vertice, district, segment, crime, time

where 
    crime.segment_id = segment.id
    and segment.start_vertice_id = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = time.id
    and time.year = 2016
    group by crime.segment_id;
```

Se obter algum erro informando sobre um produto cartesiano, execute o comando a seguir e prossiga:

```sql
SET hive.strict.checks.cartesian.product=false;
```

9. Agora vamos executar o script HQL que cria as tabelas fragmentadas e da carga de dados nelas. Saia da linha de comando do hive com CTRL + C (apenas uma vez, senão você vai sair do container).

10. Execute o comando a seguir para executar o DDL das tabelas:

```shell
hive -f database_ddl_frag_partition.hql
```

10. Execute o comando a seguir para dar carga nas tabelas fragmentadas:

```shell
hive -f insert_on_partitioned_tables.hql
```

11. Entre na linha de comando do hive novamente: 

```shell
hive
```

12. Agora execute a mesma query anterior, mas agora usando as tabelas fragmentadas:

```sql
select
    crime_frag_2016.segment_id,
    sum(crime_frag_2016.total_feminicide),
    sum(crime_frag_2016.total_homicide),
    sum(crime_frag_2016.total_felony_murder),
    sum(crime_frag_2016.total_bodily_harm),
    sum(crime_frag_2016.total_theft_cellphone),
    sum(crime_frag_2016.total_armed_robbery_cellphone),
    sum(crime_frag_2016.total_theft_auto),
    sum(crime_frag_2016.total_armed_robbery_auto)
from
    vertice_frag_1, district_frag, segment_frag_1, crime_frag_2016, time_frag

where 
    time_frag.year = 2016
    and time_frag.id = crime_frag_2016.time_id
    and crime_frag_2016.segment_id = segment_frag_1.id
    and (segment_frag_1.start_vertice_id = vertice_frag_1.id OR segment_frag_1.final_vertice_id = vertice_frag_1.id)
    and vertice_frag_1.district_id = district_frag.id
    and district_frag.name = 'IGUATEMI'
    group by crime_frag_2016.segment_id;
```
