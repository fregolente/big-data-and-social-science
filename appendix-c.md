# APPENDIX C: Technical Workflow Description

### Partners

**EL**    Elsevier

**IDIES**    Institute for Data Intensive Engineering and Science, Johns Hopkins University

**NYU**    New York University

**TACC**    Texas Advanced Computing Center at the University of Texas at Austin



### Roles

**SYSADMIN**   A defined user of the admin dashboard who has been authorized by the Democratizing Data leadership to initialize projects that an agency has requested and to assign users as administrators of those projects

**ADMIN**    A defined user from the agency staff who has been assigned by the agency to manage a project, configure its input parameters, monitor progress, and assign reviewers, etc.

**REVIEWER**    A user assigned by the admin to review/validate the results of the machine learning algorithms



### Glossary / Definitions

**Project**    A dataset search and discovery activity requested and defined by a funding entity (currently federal agency). It is characterized in a statement of work by a set of datasets that are targets of the inquiry, as well as a set of restrictive parameters

**Main Alias**    The main alias is the dataset name that most commonly describes the dataset and/or the dataset which the agency would wish results to be grouped by

**Alias Type**    Many Datasets have short form names or alternative names that are used instead of the Main Alias. These are dataset aliases. A specific form of alias is an acronym or abbreviation. Where such aliases exist they can form part of the search routines

**Research Output**   A document / publication representing the formal results of research. Research outputs include journal articles, conference papers, review papers, book chapters, books, etc.



### Steps

Indicated by a sequence number and by location.

**Step 0: Project initialization \[IDIES]**

A **SYSADMIN** initializes a new project in the admin dashboard.

This requires the following actions:

1. Adding project level metadata such as:
   * Formal department name (e.g., USDA or US Department of Agriculture)
   * Formal agency name (e.g., NASS or National Agricultural Statistical Service)
   * Unique identifier which incluldes a date stamp and version number (e.g., 2022\_12\_25\_v1)
2. Assigning a "defined user" to be an ADMIN for this project and communicating with that ADMIN user to explain entry to the system

Side effects:

* An entry representing the project will be written in the `agency_run` table
* An entry representing the agency **ADMIN** will be added to the `reviewer` table
  * If no user exists yet an entry will also be added to the `susd_user` table
* An entry will be added to the `agency_run_history` table



**Step 1: Project definition \[IDIES]**

Agency ADMIN uploads target dataset-alis file format: either

****[**csv**](#user-content-fn-1)[^1]**:**

> Each row should correspond to a dataset name/alias.
>
> Columns:
>
> * `Main_alias_id`: identifier, created by NYU upon receipt and unique in file
> * `Main_alias`: the string identifying name of dataset identified by the agency as the formal name of the dataset
> * `_alias_name`: identifies the aliases that are commonly associated with `Main_alias`
> * `alias_type`:  one from \[`main_alias`, `acronym`]
> * Dataset DOI: If available

or

**JSON:**

```json
[{"dataset":<dsname>,
  "aliases":[{"alias":<alias>,
              "type":<one of ["alias","acronym"]>}
              ],
...
]
```

**ADMIN** set other search config parameters:

* data range: \[start-date, end-date] where data is ISO-8601 compliant (YYYY-MM-DD) and based on calendar year
* US author flag: boolean

**ADMIN** clicks button to save or submit:&#x20;

* **save**: result stored in database
  * Data model extension needed
  * History of consecutive save-s stored
* **submit**: Elsevier notified
  * TBD how: likely file uploaded to new S3 folder that **Elsevier** is listening to
  * milestone noted in database



**Step 2: Identify relevant topics for search corpus creation \[EL]**

**Elsevier** uses the job identifier created in step 0 to organize its work and undertakes process as follows:

* Take datasets names and aliases from step 1;
* Exact text matching on Science Direct;
* Identify the Research Topics on the matches generated;
* Aggregate the counts of matched research outputs by Topics;
* Apply filter that excludes those topics with less than a count of 5 research outputs.

**Elsevier** transmits a JSON file containing resulting list of Research Topics from Science Direct to **IDIES** with the following aggregate metadata:

* unique run identifier;
* Research Topics;
* count of research outputs against the filtered Research Topics.

NYU and IDIES review and select the research topics with EL.

**IDIES** shows the result in the admin dashboard and stores milestones in database.

**ADMIN** inspects result (Note that in V2 agencies will be able to provide input).



**Step 3: Determination search corpus \[Elsevier]**

**Elsevier** determines the input for the ML Algorithms:

* Search Scopus using Research topics and the search config parameters and identify the research outputs records that are theoretically available for the search corpus.
  * Output 2.1: Number of records theoretically available in the Scopus
* Filter the records to exclude those for which full text does not exist
  * Output 2.2: Number of records for which full text exists
* Exclude records for which full text search is not allowed because of licensing agreements
  * Output 2.3: Number of records for which full text exists and we are licensed that may be searched
* From this filtered set of research outputs, identify the Research Topics and calculate the number of research outputs that are linked to each topic
* Filter topics to include only those with more that 5 research outputs per topic
  * Output 2.4: list of research topics with counts of research outputs greater than 5

**Elsevier** transfers Outputs 2.1 to 2.4 to **IDIES** in a JSON file

**IDIES** displays results on the dashboard and stores milestone in the database

**ADMIN** inspects the result (Version 2 will allow more interaction)



**Step 4: Running ML algorithms \[Elsevier]**

**Elsevier** runs the ML models on the Search Corpus:

* Record the results of the models in a way that enables the different results generated by the different models to be later compared (i.e. which datasets were found by which models).
* Perform fuzzy match using the alias names to determine whether the datasets found by the ML models ae on the agency dataset list and tags with the unique identifier.&#x20;
* Filter the set of matched records to indicate which are associated with target datasets and those where snippet cannot be generated for licensing reasons.

**Elsevier** provides aggregate metadata about the run to **IDIES.**

For target dataset:

* **Dataset name;**
* **Unique ID for dataset;**
* **Flag for whether dataset is in agency search list;**
* **Threshold chosen for inclusion;**
* **Count of number of mentions;**
* **Count of number of unique research outputs in which that dataset has been found;**
* **Count of number of publications for each research topic.**

For unknowns datasets with frequency greater than 5:

* **Predicted name of unknown dataset;**
* **Count of number of mentions;**
* **Count of number of unique research outputs in which that dataset has been found;**
* **Count of number of research outputs for each research topic.**

**IDIES** displays this in admin dashboard and records milestone in databases. **ADMIN** inspects the result and approves continuation. \[precise details TBD].



**Step 5: Generation Publication Record Data for validation \[Elsevier]**

**Elsevier** takes the research outputs that are matched with one or more target datasets and produces the agreed metadata for those research output records (see [Appedix B](appendix-b.md) for metadata that is available for individual research outputs). The data for individual research records is for those that contain the target datasets or their aliases only.&#x20;

Whilst research output metadata is produced only for the research output that contain a target dataset or alias, it is possible that a research output will contain other datasets in addition to the target ones. In those circumstances, the snippet associated with those additional datasets will be provided.



**Step 6: Ingestion in database \[IDIES]**

* **IDIES** retrieves data from S3 storage on SciServer;
* JSON files read and ingested into staging database;
* Data from staging tables transformed into core database;
* Admin dashboard shows statistics such as:
  * total number publications found;
  * number of research outputs for each dataset;
  * number of topics for each dataset show topics sorted in descending frequency;
  * number of authors for each dataset;
  * number of journals for each dataset.



**Step 7: Validation \[IDIES]**

**ADMIN** configures validation:

* defines users (email, password);
* assigns users as **REVIEWER** for this project;
* sets number of snippets in a batch;
* sets fraction of snippets with multiple reviews.

**REVIEWER** validates snippets assigned to them.

**ADMIN** inspects progress of vaidation in admin dashboard.

V2 ADMIN provides map of El research topics to AGENCY topic of interest.



**Step 8: Finalization \[IDIES]**

**ADMIN** decides validation is complete.

Validated data is sent to S3 bucket.

* One CSV file per table.
* Only accepted dyads, no snippet data

**TACC** retrieves it and loads it in database underlying the API.

**Elsevier** extracts information of use for ML tuning.

[^1]: Note that Excel is discouraged because it typically eliminates leading zeroes and can thus negatively affect the functionality of identifiers
