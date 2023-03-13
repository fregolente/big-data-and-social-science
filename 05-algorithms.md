# Chapter 5: The ML Algorithms

To support the identification of datasets within a set of full text publications, the community was engaged through a Kaggle competition [https://www.kaggle.com/competitions](https://www.kaggle.com/competitions) in 2021 to develop and identify the best Machine Learning (ML) and Natural Language Processing (NLP) tools. About 1,600 data science teams entered, and seven winners were identified and provided their data, code and methodology as open-source tools for public use \[2,6–8] . Of these seven, Elsevier uses the top three to identify datasets within the full text of the search corpus.



### 5.1   The Kaggle Models

**Model 1 (Deep Learning - Sentence Context)**&#x20;

This model’s approach is to use a deep learning-based approach to learn what kind of sentences have references to a dataset. This model takes the longest to run, but also is the most robust to new datasets. It evaluates all of the text within the document.&#x20;

**Model 2 (Deep Learning - Entity names)**&#x20;

This model’s approach extracts names of entities from the text and uses a deep learningbased approach to classify an entity as being a dataset or not. This model runs faster than model 1, but is slightly less robust to new datasets.&#x20;

**Model 3 (Pattern Marching)**&#x20;

This model takes a rule-based approach to search for patterns in the document that are similar to a list of existing datasets. This is the fastest model to run, but is the least robust.&#x20;

During the Kaggle competition, it was determined that the ML models were able to pick up a wider variety of ways in which authors refer to the same datasets than was possible through simple string searches. This was especially true for the winning model “Context Similarity via Deep Metric Learning” which learnt from the context and did not just rely on the way in which the aliases were written in the training set.&#x20;

In terms of the computer processing, it is simpler and faster to run approaches not relying on Deep Learning methods: Models 2 and 3 performed well if applied to publication domains like the one used on the Kaggle competition. The competition also demonstrated that there was little overlap in the datasets identified by the different models.

| Model Name                                  | Methods Used                                                                                                                                                         |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Context Similarity via Deep Metric Learning | Searching candidates in certain format + Filtering out prediction based on keywords + Searching based on the frequency of dataset appearance + Masked language model |
| Transformer-enhanced Heuristic Search       | Searching candidates in certain format + Searching based on the frequency of dataset appearance + Models learning from candidate strings                             |
| Simple and Strong Baseline                  | Searching candidates in certain format + Filtering out prediction based on keywords + Searching based on the frequency of dataset appearance                         |



### 5.2   The Application of the Models

Building on the outcomes and findings of the Kaggle competition, in undertaking the full text search, Elsevier employs all three of the winning Kaggle models. In addition to the identified dataset, each model generates a score that reflects the certainty of the model about the identified mention. The generation of the score is built into each Kaggle algorithm. Elsevier does not apply any thresholds with regard to the Kaggle scores, but rather ingests the full output of datasets generated from the algorithms.&#x20;

The text identified by the models as being a potential dataset as well as their scores are extracted and stored. In addition, at this point and where licenses allow, a data snippet is generated from the full text showing the text \[235 characters] immediately before the candidate dataset text string and the text \[235 characters] immediately after the candidate dataset text string. This snippet is used in the validation process i.e. used to identify whether a match is a true match or a false positive.&#x20;

There is a range of logical possibilities for each full text publication record searched:

* No dataset found in the publication;&#x20;
* Single dataset found (extracted and single output record produced). This record may or may not be from a target dataset (target dataset in this respect being a dataset provided by the agency or one of its aliases);&#x20;
* Multiple references to a single dataset found (extracted and multiple output records produced). This record may or may not be from a target dataset(s);&#x20;
* Single reference to multiple datasets found (extracted and multiple output records produced). This record may or may not be from a target dataset(s);&#x20;
* Multiple references to multiple datasets found (extracted and multiple records produced). (Again, these may or may not be to target dataset).



### 5.3   Finding Target Datasets

At this point, the Kaggle algorithms have been applied to the full text and have identified generic datasets. The next step is to identify, from within the Kaggle identified subset of records, the target datasets defined by the client. This is achieved by applying a fuzzy text matching using both the target dataset names and the aliases that have been provided or added.&#x20;

The fuzzy matching algorithm is an open-source package called FuzzyWuzzy developed in Python. Details about the package can be found [here](https://www.datacamp.com/tutorial/fuzzy-string-python). The fuzziness allows for syntactic differences between the datasets. While running this process it is possible that additional aliases will be found. If that is the case, they are identified and recorded. As with the Kaggle algorithms, a score is generated for each identified pair (i.e., a candidate detection and a target dataset) which is based on the sequences of common characters in both the detection and the target dataset. A threshold is set of the fuzzy scores and only the ones with a score greater than the threshold are kept as a match. The threshold value is determined based on the distribution of the scores across all pairs and the mean character length of the target datasets and aliases. A separate threshold is therefore generated and employed for each of the target datasets in the batch of datasets within the process run.

The fuzzy text matches results in a set of candidate matches or dyads being identified (i.e., where a publication record is linked to a target dataset). The logical possibilities described for the Kaggle algorithms also apply here. Elsevier can generate an output that shows only the target datasets in each publication record or alternatively an output which shows all possible datasets (i.e., including non-target datasets). The core output of this step is thus a results file that for each match found shows: publication ID; target dataset ID; a Kaggle algorithm ID; a Kaggle algorithm score; the data snippet, the candidate dataset text string as found by the fuzzy text matching; and fuzzy text score.&#x20;

Once the dyads have been identified from the matching process, the required metadata needs to be created. Apart from the data generated through the application of the Kaggle and fuzzy text algorithms, this metadata is generated from the information that is held within Scopus. Scopus includes information that can be used to generate a range of metrics at either the article or journal level, for example the [Citescore](https://www.elsevier.com/connect/editors-update/citescore-a-new-metric-to-help-you-choose-the-right-journal) for a journal, the field weighted citation impact (FWCI) and the number of citations for an article. These metrics are, of course, subject to change over time (e.g., as other research makes reference to an article) and hence the metadata we generate are presented as extant at a specific point in time. Elsevier also provides the relevant research classification information (Research Topics, All Science Journal Classification) for the record. Each metadata field is carefully defined in a data dictionary and in a manner that facilitates subsequent validation checks (e.g., are formats as specified or numbers within the valid range). The metadata information is generated in [JSON](https://en.wikipedia.org/wiki/JSON) format to facilitate subsequent automated machine processing including automated checks on the file formats.



### 5.4   Future Research

The Kaggle competition asked participants to extract dataset mentions from a document. At a high level, the competition asked participants to define a function that did the following:&#x20;

f(document) = “dataset 1| ... | dataset n”&#x20;

Where “document” is a JSON-formatted version of the text of the original document. Each of the top three submissions took a unique approach to the competition and offer valuable insight into how to solve this problem. The top two submissions incorporated deep learning-based methods, but the third-placed submission is a rules-based model. The top models all brought their own preprocessing, classification, and post-processing schemes. After the competition, in applying the submissions to new data, some shortcomings of this approach became apparent:

1. Participants didn’t have to offer a confidence value for the detected values. Instead, each model heuristically removes what they considered to be poor submissions.&#x20;
2. Participants didn’t have to submit where in the document they detected the dataset&#x20;
3. The constraints on model speed were not tight enough

Elsevier has made a secure environment available to estimate the models in the Elsevier International Centre for the Study of Research (ICSR) Laboratory. The environment is being accessed by team members, and, in future, other researchers to reestimate the ML models. In the short-term, the optimization and improvement of the methods developed via the Kaggle competition is being explored. In particular, the team is reconsidering the problem in the following way. Rather than asking for functions that satisfy the relationship:

f(document) = “dataset 1| ... | dataset n”&#x20;

we instead ask for functions that satisfy the following relationship:&#x20;

f(snippet, document) = Pr(snippet contains dataset), dataset token classifications&#x20;

Where “snippet” is a snippet from the text of the publication which has been identified as possibly containing a dataset reference, and “document” is the entire document. In contrast to the current approach, which asks for a single string as output for an entire document, the proposed approach asks models to produce two outputs for a given snippet and a document. The first is a binary classification for the given snippet and the second is a classification for each token within the snippet. An example of this format might look like the following:

Snippet:

<figure><img src=".gitbook/assets/Screenshot 2023-03-13 at 4.04.21 PM.png" alt=""><figcaption></figcaption></figure>

This snippet would also be paired with the entirety of the text it was taken from. The output of the function given the masked snippet and the document could be the following:&#x20;

Pr(snippet contains dataset) = 1&#x20;

for clarity, the tokens that are highlighted below correspond to a 1 and otherwise would be a 0

<figure><img src=".gitbook/assets/Screenshot 2023-03-13 at 4.04.51 PM.png" alt=""><figcaption></figcaption></figure>

This formulation of the problem has a few benefits that address the shortcomings of the current approach:

1. We explicitly ask for binary classification of the entire snippet. By doing this we can leverage the metrics and statistics associated with binary classifiers
2. We ask for the classification of tokens, which helps with the location of valid datasets
3. By including the entire document with the snippet, models that might leverage the entirety of the text (i.e., simple search methods) can be used, but in some way, the model needs to offer a binary classification for both the sentence and the tokens. This presents a fair way to rigorously compare models as the comparison of binary classifiers is well-studied
4. By presenting snippets we can offer the opportunity to generate a balanced dataset rather than what might otherwise be an unbalanced dataset with significantly fewer non-dataset words/tokens than dataset words/tokens
5. This mirrors what we ask the validators to do&#x20;

The potential benefit is that the revised model would permit agencies to get much better results in two ways. First, predictions about dataset use would have a higher likelihood of being correct (increased precision), reducing the cost of validations. Second, agencies would be less likely to incorrectly reject mentions (increased recall), increasing the quality of information about dataset use.
