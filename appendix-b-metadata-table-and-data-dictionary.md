# APPENDIX B: Metadata Table and Data Dictionary

### AffiliationGeo: Geo information about affiliations

| Column name     | Description | Data type | Length | Is nullable |
| --------------- | ----------- | --------- | ------ | ----------- |
| affiliation\_id | Nan         | bigint    | 0      | YES         |
| q\_in           | Nan         | varchar   | -1     | YES         |
| q\_final        | Nan         | varchar   | -1     | YES         |
| nattempt        | Nan         | smallint  | 0      | YES         |
| boundingbox     | Nan         | varchar   | -1     | yes         |
| lat             | Nan         | float     | 0      | YES         |
| lon             | Nan         | float     | 0      | YES         |
| display\_name   | Nan         | varchar   | -1     | YES         |
| importance      | Nan         | float     | 0      | YES         |



### agency\_run: The table with runs for the different agencies

| Column name         | Description                                                                                                                                                  | Data type | Length | Is nullable |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- | ------ | ----------- |
| id                  | unique identifier to the agency\_run table                                                                                                                   | bigint    | 0      | NO          |
| agency              | name of the agency for which the run was performed                                                                                                           | varchar   | 32     | NO          |
| version             | version of the run for the agency. Allows multiple versions on the same datasets, or possibly new runs for the same agency but with different input datasets | varchar   | 32     | NO          |
| run\_date           | approximate date the run was performed                                                                                                                       | date      | 0      | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                                                                                     | datetime  | 0      | NO          |



### asjc: All Science Journal Classfication code defines the reserach area of a journal and the articles it contains

| Column name         | Description                                                                                                                                                                                                                                                                       | Data type | Length | Is nullable |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                                                                                                                                                                                                                  | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id                                                                                                                                                                                      | bigint    | 0      | NO          |
| code                | The All Science Journal Classification code which defines the research area of a journal and the articles it contains. There may be more than one ASJC code for each journal/publication. The 334 codes are used here providing a relatively precise definition of research area. | bigint    | 0      | NO          |
| label               | TBD                                                                                                                                                                                                                                                                               | nvarchar  | -1     | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                                                                                                                                                                                                          | datetime  | 0      | NO          |



### author: table with author information

| Column name         | Description                                                                                                                                  | Data type | Length | Is nullable |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                                                                             | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id                                                 | bigint    | 0      | NO          |
| external\_id        | id assigned by Elsevier to the author. allow different authors to be identified across publications, even if they have different names there | varchar   | 128    | YES         |
| given\_name         | the unique given name of the author as determined by Elsevier                                                                                | nvarchar  | 150    | YES         |
| family\_name        | the unique family name of the author as determined by Elsevier                                                                               | nvarchar  | 150    | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                                                                     | datetime  | 0      | NO          |



### author\_affiliation: table linking authors to their affiliations in a publication

| Column name                  | Description                                                                                  | Data type | Length | Is nullable |
| ---------------------------- | -------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                           | unique identifier for this entry                                                             | bigint    | 0      | NO          |
| run\_id                      | identifies the agency run for which this entry was determined, foreign key to agency\_run.id | bigint    | 0      | NO          |
| publication\_author\_id      | identifies the publication\_author here linked to the publication affiliation                | bigint    | 0      | YES         |
| publication\_affiliation\_id | identifies the publication\_affiliation entry here linked to a publication author            | bigint    | 0      | YES         |
| last\_updated\_date          | last time the row was updated. generally the time of creation of the row                     | date      | 0      | NO          |



### dataset\_alias: Datasets provided by an agency for a particular run and possible aliases

| Column name         | Description                                                                                    | Data type | Length | Is nullable |
| ------------------- | ---------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                               | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id   | bigint    | 0      | NO          |
| alias\_id           | the alias\_id as provided by Elsevier                                                          | bigint    | 0      | NO          |
| parent\_alias\_id   | identifies the parent dataset entry in this table, as identified by the alias\_id              | bigint    | 0      | YES         |
| alias               | the name of the data set or the alias depending on whether alias\_id==parent\_alias\_id or not | varchar   | 160    | YES         |
| alias\_type         | flaf indicating whether the row stores the dtaset itself, or an alias                          | varchar   | 50     | YES         |
| url                 | URL to information about the dataset                                                           | varchar   | 2048   | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                       | datetime  | 0      | NO          |



### dyad: The core table with dyads representing dataset references

| Column name         | Description                                                                                                                                                                                   | Data type | Length | Is nulllable |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------ | ------------ |
| id                  | unique identifier for this entry                                                                                                                                                              | bigint    | 0      | NO           |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id                                                                                                  | bigint    | 0      | NO           |
| publication\_id     | foreign key the publication table's id column, identifying the publication within which the datast reference represented by this dyad was identified                                          | bigint    | 0      | NO           |
| elsevier\_id        | REMOVE                                                                                                                                                                                        | int       | 0      | NO           |
| dataset\_alias\_id  | foreign key to the dataset\_alias table's id column identifying the match made between this dyad and a dataset alias provided by an agency. If no such match was found this column has a NULL | bigint    | 0      | YES          |
| alias\_id           | the intrinsic id assigned by Elsevier to the dataset alias, corresponding to the alias\_id column in the dataset\_alias table                                                                 | bigint    | 0      | YES          |
| mention\_candidate  | the phrase in the publication that was deemed by the algorithm to reflect a reference to a dataset                                                                                            | varchar   | 1028   | NO           |
| snippet             | snippet of text surrounding the mention\_candidate, meant to provide contextual information to reviewers/validators                                                                           | varchar   | -1     | YES          |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                                                                                                                      | datetime  | 0      | NO           |
| is\_fuzzy           | column has value 1 if the matching between mention candidate and the dataset alias was performed using a fuzzy algorithm, 0 otherwise                                                         | bit       | 0      | YES          |
| fuzzy\_score        | in case the matching between mention candidate and the dataset alias was performed using a fuzzy algorithm, this column stores the score indicating how certain match was deemed to be        | real      | 0      | YES          |



### dyad\_model: model scores for particular entries in the dyad table

| Column name         | Description                                                                                  | Data type | Length | Is nullable |
| ------------------- | -------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                             | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id | bigint    | 0      | NO          |
| dyad\_id            | identifies the dyad                                                                          | bigint    | 0      | NO          |
| model\_id           | identifies the model                                                                         | bigint    | 0      | NO          |
| score               | the score of this model for the dyad                                                         | real      | 0      | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                     | datetime  | 0      | NO          |



### issn: The ISSN/ISBN codes for the journal

| Column name         | Description                                                                                  | Data type | Length | Is nullable |
| ------------------- | -------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                             | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id | bigint    | 0      | NO          |
| journal\_id         | foreign key to the journal table's id column, identifying the journal for this ISSN          | bigint    | 0      | YES         |
| ISSN                | the ISSN/ISBN codes for the referenced journal/source                                        | varchar   | 13     | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                     | datetime  | 0      | NO          |



### journal: Journal that a publication in the publication table appeared in

| Column name         | Description                                                                                                            | Data type | Length | Is nullable |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier and primary key for this table                                                                       | bigint    | 0      | NO          |
| run\_id             | foreign key, identifier of the agency run for which this entry was determined                                          | bigint    | 0      | NO          |
| publisher\_id       | foreign key to the publisher table, identifying the publisher for this journal at the time the agency run was executed | bigint    | 0      | YES         |
| external\_id        | the scopus ID for the journal/source                                                                                   | varchar   | 128    | YES         |
| title               | the name of the journal/source that the publication was published in                                                   | varchar   | 1028   | NO          |
| cite\_score         | citescore is an Elsevier derived metric that measures the relative standing of a journal                               | decimal   | 0      | YES         |
| last\_updated\_date |  last time the row was updated. generally the time of creation of the row                                              | datetime  | 0      | NO          |



### model: the Kaggle models that are run

| Column name         | Description                                                                  | Data type | Length | Is nullable |
| ------------------- | ---------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                             | bigint    | 0      | NO          |
| name                | the name of the model                                                        | varchar   | 32     | NO          |
| github\_commit\_url | the github url where the commit for this model can be found                  | varchar   | 1024   | YES         |
| description         | description of the model                                                     | nvarchar  | -1     | YES         |
| last\_updated\_date | last time the row was updated. generally the time of the creation of the row | datetime  | 0      | NO          |



### publication: publication discovered in a run

| Column name          | Description                                                                                                                                                                                                                                                                                                                                                                                          | Data type | Length | Is nullable |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                   | unique identifier for this entry                                                                                                                                                                                                                                                                                                                                                                     | bigint    | 0      | NO          |
| run\_id              | identifies the agency run for which this entry was determined, foreign key to agency\_run.id                                                                                                                                                                                                                                                                                                         | bigint    | 0      | NO          |
| journal\_id          | foreign key to the journal for this publication                                                                                                                                                                                                                                                                                                                                                      | bigint    | 0      | YES         |
| external\_id         | the scopus ID (for Elsevier publications) of this publication                                                                                                                                                                                                                                                                                                                                        | varchar   | 128    | YES         |
| title                | title of the publication                                                                                                                                                                                                                                                                                                                                                                             | varchar   | 400    | YES         |
| doi                  | DOI of the publication                                                                                                                                                                                                                                                                                                                                                                               | varchar   | 80     | YES         |
| year                 | the year that the publication was published as recorded in scopus                                                                                                                                                                                                                                                                                                                                    | int       | 0      | YES         |
| month                | the month of publication. may not be available. this will be an integer value, i.e., 1 = January, etc.                                                                                                                                                                                                                                                                                               | int       | 0      | YES         |
| pub\_type            | the type of publication. types includes: article, review, book, book chapter, letter.                                                                                                                                                                                                                                                                                                                | varchar   | 30     | YES         |
| citation\_count      | the number of times this publication is cited in scopus                                                                                                                                                                                                                                                                                                                                              | int       | 0      | YES         |
| fw\_citation\_impact | the Field Weighted Citation impact (FWCI) for the publication. This is a measure for how impactful or important a publication is as measured through normalized citations. The number of times cited divided by the expected number of citations of articles in the same year, subject and publication type. World average across papers is 1.0 for this metric. This metric also changes over time. | float     | 0      | YES         |
| last\_updated\_date  | last time the row was updated. generally the time of creation of the row                                                                                                                                                                                                                                                                                                                             | datetime  | 0      | NO          |



### publication\_affiliation: the table with affiliations on a publication

| Column name         | Description                                                                                  | Data type | Length | Is nullable |
| ------------------- | -------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier of the affiliation table                                                   | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id | bigint    | 0      | NO          |
| external\_id        | id assigned by Elsevier to this affiliation                                                  | varchar   | 128    | YES         |
| institution\_name   | the name of the institution to which an author was associated                                | nvarchar  | 750    | YES         |
| address             | the address of the author, most likely that of their institution                             | nvarchar  | 750    | YES         |
| country\_code       | the three let6ter country code associated to the affiliation, most likely of the institution | nvarchar  | 10     | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                     | datetime  | 0      | NO          |
| city                | the city for the address or institute in this affiliation                                    | nvarchar  | 128    | YES         |
| state               | if approproate, the state for the address or institute in this affiliation                   | nvarchar  | 128    | YES         |
| postal\_code        | if appropriate, the postal coe for this affiliation                                          | nvarchar  | 64     | YES         |



### publication\_asjc: Associative table linking a publication to ASJC entries

| Column name         | Description                                                                                  | Data type | Length | Is nullable |
| ------------------- | -------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                             | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id | bigint    | 0      | NO          |
| publication\_id     | foreign key to publication table's id column, identifying the publication in this relation   | bigint    | 0      | NO          |
| asjc\_id            | foreign key to the ASJC                                                                      | bigint    | 0      | NO          |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                     | datetime  | 0      | NO          |



### publication\_author: Associative table linking publication and author tables

| Column name         | Description                                                                                  | Data type | Length | Is nullable |
| ------------------- | -------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                             | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id | bigint    | 0      | NO          |
| publication\_id     | foreign key to the publication for this author                                               | bigint    | 0      | NO          |
| author\_id          | foreign key to the table with scopus author entries                                          | bigint    | 0      | NO          |
| author\_position    | position of author in the list of authors on the publication                                 | int       | 0      | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                     | datetime  | 0      | NO          |



### publication\_topic: identifying the topic assigned to a publication

| Column name         | Description                                                                                                             | Data type | Length | Is nullable |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                                                        | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id                            | bigint    | 0      | NO          |
| publication\_id     | foreign key to the topic table's id column identifying the publication in this relation between publications and topics | bigint    | 0      | NO          |
| topic\_id           | foreign key to the topic table's id column identifying the topic in this relation between publications and topics       | bigint    | 0      | NO          |
| score               | TBD                                                                                                                     | real      | 0      | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                                                | datetime  | 0      | NO          |



### publisher: Publishers of the journals the publications were published in

| Column name         | Description                                                                                  | Data type | Length | Is nullable |
| ------------------- | -------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                             | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id | bigint    | 0      | NO          |
| external\_id        | external identifier of this publisher in Elsevier's scopus repository                        | nvarchar  | 128    | YES         |
| name                | name of the publisher                                                                        | nvarchar  | 120    | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                     | datetime  | 0      | NO          |



### reviewer: Reviewers are assigned to validate dyads in the publication\_dataset\_alias table

| Column name         | Description                                                                                          | Data type | Length | Is nullable |
| ------------------- | ---------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                                     | bigint    | 0      | NO          |
| susd\_user\_id      | foreign key to the susd\_user table's id column, identifying the user corresponding to this reviewer | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id         | bigint    | 0      | NO          |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                             | datetime  | 0      | NO          |



### snippet\_validation: the validation results for dyads provided by reviewers

| Column name                 | Description                                                                                                                                                                                               | Data type | Length | Is nullable |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                          | unique identifier for this entry                                                                                                                                                                          | bigint    | 0      | NO          |
| run\_id                     | identifies the agency run for which this entry was determined, foreign key to agency\_run.id                                                                                                              | bigint    | 0      | NO          |
| reviewer\_id                | foreign key to the reviewer table's id column, identifying the reviewer assigned to validate this snippet                                                                                                 | bigint    | 0      | NO          |
| dyad\_id                    | foreign key to the dyad table's id column, identifying the dyad that is being validated                                                                                                                   | bigint    | 0      | NO          |
| is\_dataset\_reference      | if the value in this column is 1, it indicates the dyad indeed has been identified a reference to a dataset; if 0, it is not a dataset reference; if -1, the reviewer was unsure about it                 | smallint  | 0      | YES         |
| agency\_dataset\_identified | if the value in this column is 1, it indicates the dyad indeed identified the specific dataset provided by the agency; if 0, it is not a ference to that dataset; if -1, the reviewer was unsure about it | smallint  | 0      | YES         |
| notes                       | any notes the reviewer attached to the dyad being reviewed                                                                                                                                                | nvarchar  | -1     | YES         |
| last\_updated\_date         | last time the row was updated. generally the time of creation of the row                                                                                                                                  | datetime  | 0      | NO          |



### susd\_user: A user of the validation tool

| Column name         | Description                                                              | Data type | Length | Is nullable |
| ------------------- | ------------------------------------------------------------------------ | --------- | ------ | ----------- |
| id                  | unique identifier of this table                                          | bigint    | 0      | NO          |
| first\_name         | first name of the individual                                             | varchar   | 100    | YES         |
| last\_name          | surname of the individual                                                | varchar   | 100    | YES         |
| email               | email of the user                                                        | varchar   | 100    | YES         |
| password            | encrypted password of the user                                           | varchar   | 100    | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row | datetime  | 0      | NO          |



### topic: topis defined by Elsevier and assigned to publications, consist of three concatenated keywords

| Column name         | Description                                                                                         | Data type | Length | Is nullable |
| ------------------- | --------------------------------------------------------------------------------------------------- | --------- | ------ | ----------- |
| id                  | unique identifier for this entry                                                                    | bigint    | 0      | NO          |
| run\_id             | identifies the agency run for which this entry was determined, foreign key to agency\_run.id        | bigint    | 0      | NO          |
| keywords            | a topic is defined in Elsevier by three keywords. This columns stores these as a —-separated string | varchar   | 1028   | YES         |
| external\_topic\_id | external identifier of this topic provided by Elsevier                                              | varchar   | 128    | YES         |
| prominence          | TBD                                                                                                 | real      | 0      | YES         |
| last\_updated\_date | last time the row was updated. generally the time of creation of the row                            | datetime  | 0      | NO          |
