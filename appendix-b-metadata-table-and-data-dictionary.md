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

