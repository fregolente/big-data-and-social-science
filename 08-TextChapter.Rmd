# Application Programming Interface

The Application Programming Interface (API) lets agencies and interested stakeholders be able to programmatically pull the metadata and process/display as they wish. Version 2 of the API is currently available to stakeholders and is updated with agency specific data as it is validated and ready for release.&#x20;

The API is built using the FastAPI, a Python-based backend which provides routes to database objects with a dynamically generated set of documentation and OpenAPI specifications. The API is containerized and served from Kubernetes and performs calls to functions from the PostgreSQL database. These PostgreSQL function calls optimize query time by making reference to pre-computed database entries in order to decouple query runtime from query complexity. Database updates are propagated to the API via a rollover mechanism that ensures the API will always be performant enough to drive User Interface (UI) applications with minimal downtime. For future capabilities, Fast API can also be integrated with TAPIS (TACC APIs) to provide authentication and fine-grained access controls as needed.

### 8.1 API Prototype

The prototype Show Us The Data API was a RESTful service that wrapped filter/join functions from the original database schema. The prototype API demonstrated that results from the database could be consumed by external services and clients. The initial prototype was used as an initial springboard for the production API reflected in section 8.2.

### 8.2 API Version 2

Version 2 enables two modes of access to the data set. The first mode supports access for those agency Tableau users who are unable to consume directly from a RESTful API. They can access the data via Web Data Connector and Postgres. The second mode provides access through a RESTful API that supports a generalized Democratizing Data user interface/web client, and provides agencies with the capability of building their own web clients.

The Version 2 API includes the following elements:

* TACC-hosted PostgreSQL database that retains production ready, validated data within tables. For complex queries, materialized views are used to maintain query performance;
* Web Data Connect that allows Tableau to retrieve data from the production Postgres Tables and materialized views;
* Production, Pre-production and Development Postgres instances, with access for Democratizing Data to develop and push data directly to the Postgres environment with a rollover-based deployment process for new production data and schema changes;
* (In progress) Automated testing to ensure endpoints and producing proper data when new agency information is pushed to the API;
* (In progress) Landing page for agencies that will answer high level questions and provide further information on how to access additional detailed data.

API endpoints are dependent on what the new data set schema is capable of providing, with requirements for additional endpoints flowing to the Democratizing Data schema team in an iter- ative development process. The current endpoints are listed in the OpenAPI specification, many of which currently support the “main questions” requirements. These are documented at [https://democratizing-data.tacc.utexas.edu/docs](https://democratizing-data.tacc.utexas.edu/docs) as well as here [https://prod.democratizing-data.tacc.utexas.edu/redoc](https://prod.democratizing-data.tacc.utexas.edu/redoc) and [https://prod.democratizing-data.tacc.utexas.edu/docs#](https://prod.democratizing-data.tacc.utexas.edu/docs)

