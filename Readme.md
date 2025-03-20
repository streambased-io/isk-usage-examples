# Simple example of client setup for using Streambased cloud deployed Iceberg Catalog service (ISK)

## Background 
ISK is an Iceberg compatible metadata catalog purpose built for seamlessly representing data residing in Apache Kafka compatible platforms through Iceberg interface.
Documentation - [ISK on Streambased](https://beta.streambased.cloud/) //TODO: update link to correct one for ISK docs 

Accessing data through Iceberg requires two parts:
- Iceberg catalog - for metadata lookup - served by ISK service
- Compatible storage for actual metadata and data file retrieval - served by SSK service (S3 compatible interface)

## Content of this example
The example - docker-compose and configuration files are prepared for starting a single (local) instance of Spark and Trino compute engines.

Standard List/Read/Select operations are supported in Spark (SQL and DataFrames) and Trino - note that it is a read-only logical representation of Kafka data so no modifying operations are supported.

### Prerequisites
- Account on [Streambased cloud](https://beta.streambased.cloud/) created and configured with a Kafka cluster. API Key and Secret should be noted down.
- Docker & Docker Compose available on the client machine

### Common setup
Irrespective of whether Spark or Trino (or both) is used - following are common preparation steps:
- Populate streambased.env according to your account / ISK / SSK region to use
  - ACCESS_KEY=         # Set to your account's Streambased API Key
  - SECRET_KEY=         # Set to your account's Streambased Secret Key
  - ISK_ENDPOINT=       # Set to Streambased ISK (Iceberg Catalog) regional endpoint to use e.g. https://us-west2-isk-beta.streambased.cloud
  - SSK_ENDPOINT=       # Set to Streambased SSK (Storage Catalog) regional endpoint to use e.g. https://us-west2-ssk-beta.streambased.cloud

### Using Spark
- Start Spark container `docker compose up -d spark-iceberg`
#### Spark SQL
- Open Spark SQL CLI `docker compose exec -it spark-iceberg spark-sql`
- Set default namespace to `isk` - `USE isk;`
- List tables (topics) - `SHOW tables;`
- Select first 10 results from table(topic) - `SELECT * FROM tablename LIMIT 10;` - replace tablename with a topic that exists - e.g. `transactions` in demo cluster.

#### PySpark Notebooks
Spark container starts up Jupyter server with UI on http://localhost:8888/tree/notebooks
- Open [Jupyter Web UI](http://localhost:8888/tree/notebooks?)
- You can create a new notebook - which will be stored in mapped folder on your machine - `docker_demo/spark/notebooks` 
- Simple notebook is already included for example of interaction with ISK.

In addition working with Java and Spark Dataframes is supported both in Jupyter and Spark-shell (`docker exec -it spark-iceberg spark-shell`)

### Using Trino
- Start Trino container `docker compose up -d trino`
- Start Trino CLI `docker compose exec -it trino trino --server=localhost:9080`
- set Catalog and Namespace to use - `USE streambased.isk;`
- Show tables (topics) - `SHOW tables;`
- Select first 10 results from a table (topic) - `SELECT * FROM tablename LIMIT 10;` - replace tablename with a topic that exists - e.g. `transactions` in demo cluster. 

