# Dashboard for Network Exploration

In addition to the researcher dashboard and the access to the database using the Jupyter Notebooks in SciServer, the team is also developing other user-friendly tools using Jupyter Notebooks. The most developed is the Dashboard for Network Exploration, which has been designed to visualize and explore network graphs derived from the target datasets, and to visualize tables with their associated metadata.



### 10.1 Accessing the Dashboard

The dashboard can be accessed through 2 different interfaces:

* Standalone website: [https://showusthedata.idies.jhu.edu/dashboard/](https://showusthedata.idies.jhu.edu/dashboard/) (does not require login)
* Within SciServer in a Jupyte Notebook (requires login).



### 10.2 Dashboard Filters

The Notebooks provide filtering capabilities, where filtering on the network nodes will filter out their associated rows in the metadata tables, and vice-versa.

**Author**    The nodes of the network are publication authors.&#x20;

> An edge (link) connecting 2 author nodes is created if those authors appear in the same publication. The size of a network node is proportional to the number of papers published by each author. The width of the edge connecting 2 authors is proportional to the number of papers they have published together.

**Institutions**    The nodes of the network are the institutions of publication authors.

> An edge (link) connecting 2 institution nodes is created if an author from one institution appears in the same publication as an author from the other institution. The size of a network node is proportional to the total number of publications associated to the institution. The width of the edge connecting 2 institutions is proportional to the number of publications their authors have published together.

**Topics**    The nodes of the network are the topics related to publications.&#x20;

> An edge (link) connecting 2 topic nodes is created if the 2 topics appear in the same publication. The size of a topic node is proportional to the total number of times it appears in all publications. The width of the edge connecting 2 topic nodes is proportional to the number of publications the topics have in common.

The following tables and respective columns are shown on the left half of the screen:

* **Publications**: title, journal, publisher, year, month, number of citations and authors. The title column is clickable and opens the journal web page with information about the publication.
* **Authors**: name, number of papers and citations. The name column is clickable and opens the scopus web page with information about the author.
* **Topics**: name, number of papers and citations. Topics are related to the publication, as defined by Elsevier.
* **ASJCs:** name, number of papers and citations. These are ALL Science Journal Classification codes assigned to the publications.
* **Journals**: name, number of papers, and citations.
* **Datasets**: name, number of papers, citations, and authors.
* **Agencies**: name, number of papers, citations, and authors.
* **Institutions**: name, city, country, number of papers, citations, and authors.
* **Countries**: country name, number of papers and citations.
* **Yearly Statistics**: year, number of citations and paper per year.