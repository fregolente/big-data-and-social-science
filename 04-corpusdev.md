# Chapter 4: Corpus Development

### 4.1    Source Data

The data that Elsevier searches as part of its contribution to Democratizing Data is drawn from Scopus. Scopus is the largest abstract and citation database of peer-reviewed literature: scientific journals, books and conference proceedings. As at May 2022, Scopus contained 87 million records, from over 7,000 publishers over 100 countries. Around 11,000 new records are indexed every day \[3,5].



Elsevier is itself a significant publisher of research. During 2019, Elsevier accounted for the review, editing and dissemination of 18% of the world’s scientific articles. Scopus draws on this rich publishing heritage but also benefits from relationships with other publishers, most of whom have provided licenses that enable Elsevier to search the full text in order to identify key metadata or data elements. Nevertheless, there are some exceptions. For example, for the Democratizing Data project Elsevier is not licensed to undertake full text searchers from Springer Nature so their records must be excluded from the search routines.



### 4.2   Seed Corpus

The standard corpus creation process used by Elsevier starts with the creation of a seed corpus based upon the target datasets and aliases (or alternative names) for each dataset. In addition, some agencies are able to provide either references to a sample of actual articles in which the datasets have been used or to the names of candidate journals in which articles are likely to be found.&#x20;

Having high quality information from the relevant agency helps to ensure that the search space is more targeted to the likely publications; this helps improve precision and recall, in particular ensuring that false positives are minimized. The target dataset names and aliases are recorded and form part of the job run metadata.

The seed corpus is created using exact string matching of the target datasets and aliases against Elsevier’s Science Direct database. This database contains research outputs published by Elsevier (over 2,500 journal and 40,000 book titles). The Wikipedia entry for Science Direct can be found [here. ](https://en.wikipedia.org/wiki/ScienceDirect)

From the matched publications, Elsevier identifies a set of research Topics. A Topic is **a collection of publications with a common intellectual interest** and can be large or small, new or old, growing or declining. A Topic is defined to be where the direct citation linkages within the Topic are strong and the direct citation linkages outside the Topic are weak. Only the indexed publications are included in Topics. There are 96,000 Topics and these are grouped into 1,500 Topic Clusters. Over time, new Topics will surface, and as Topics are dynamic, they will evolve. For the search corpus creation, the Elsevier team employed the more detailed Topics. A publication can belong to only one Topic and a Topic can belong to one Topic Cluster.&#x20;

More on Topics can be found [here.](https://www.elsevier.com/solutions/scival/features/topic-prominence-in-science)

The Topics, together with any other parameters (e.g., date range) specified by the agency, are then used to identify the corpus of full text articles that form the basis of the Search Corpus. At this point, the publishers of the full text articles are checked and those records are excluded from the corpus where the license agreement does not allow for Elsevier to undertake full text analysis.



### 4.3   Coverage of Full Text Research Outputs

The following table provides a summary of full text records that are available and searchable based on the calendar year of publication during the period 2017 to 2021. Full text records are, of course, also available for earlier periods although as one goes further back in time, the number of full text records decreases. This table is designed to illustrate the possibilities in the search space for what we have found to be typical periods of interest.

| Calendar Year | Scopus Records | Records with Full text | Elsevier’s own Full Text Records | Full Text Records Licensed and available for Search | Licensed as % of Full Text Records |        |
| ------------- | -------------- | ---------------------- | -------------------------------- | --------------------------------------------------- | ---------------------------------- | ------ |
| 2021          | 4,079,818      | 3,826,784              | 701,724                          | 3,428,470                                           | 89.59%                             | 84.03% |
| 2020          | 3,856,004      | 3,583,017              | 645,188                          | 3,233,503                                           | 90.25%                             | 83.86% |
| 2019          | 3,644,970      | 3,392,420              | 597,381                          | 3,091,172                                           | 91.12%                             | 84.81% |
| 2018          | 3,455,000      | 3,152,839              | 576,948                          | 2,881,415                                           | 91.39%                             | 83.40% |
| 2017          | 3,270,051      | 2,843,709              | 553,854                          | 2,594,161                                           | 91.22%                             | 79.33% |

_ted_

As more fully described in the next chapter, the Machine Learning algorithms are applied to the licensed full text records in the corpus to identify those research outputs which contain candidate datasets. The ML algorithms are then further supplemented with fuzzy matching routines. The final step in the Elsevier workflow is to generate the metadata for the research outputs identified as containing the datasets.
