# Chapter 6: Validation Tool

Elsevier produces a JSONL-format of the result of the dyad searches and places it in an AWS S3 bucket to which both IDIES and Elsevier have access, as described by the transfer protocol in [Figure 4.](03-workflow.md#3.1-process) On a periodic basis, a process downloads data from this bucket, mirrors it to a private location on SciServer, performs a basic set of validations (not to be confused with the human validation that occurs later in the process) to verify that the expected data has been delivered in full and is of the expected quality enabling the continuation of the workflow process - specifically the validations. The data are then loaded into an SQL database of the schema described in [Appendix A](appendix-a.md). Both the database and the original files can be accessed via SciServer (given the appropriate permissions) for further analysis or debugging. The database (and file mirror) represent another potential access mode in addition to the TACC API, specifically for those interested in working within the SciServer environment.



### 6.1   Validation Tool Specifics

Each agency has made use of the validation tool to ensure that the ML output is correct. The results:

1. provide insights into how well the models are identifying datasets,
2. find other datasets that are used in conjunction with the agency datasets to study similar topics, and
3. identify how researchers make use of each agency’s data.&#x20;

The choice of who will validate depends on each agency. Many agencies have asked their own subject matter experts to act as validators. One agency brought in a staff person and made validation one of their tasks. Yet another agency provided funding for a graduate student team from a Hispanic Serving Institution (UT San Antonio) to serve as validators. Those students are writing a report on their lessons learned that they expect to publish in a scholarly journal and will be active in engaging a diverse community in workshops.&#x20;

The validation tool is very straightforward, and validators have not hitherto needed training in its use. The tool provides reviewers with snippets from actual publications on which the model has been run and which contain references to the dataset being searched for. The snippets contain a candidate phrase identified by the model, and the goal is for the validators to determine if these snippets are referring to the correct dataset.



<figure><img src=".gitbook/assets/Screenshot 2023-03-15 at 2.43.07 PM.png" alt=""><figcaption><p>Figure 6: Data Transfer Protocol</p></figcaption></figure>



**Registration.** Validators can’t register themselves in the validation tool. An account is created for them by project personnel, and they will receive their credentials by email. Democratizing Data personnel manage the text snippets that users can review and assign new batches of snippets upon request.&#x20;

**Sign-in.** The validation tool landing page has a login form for users to sign in.&#x20;

**Review.** When the users log in, they see a bar with the number of snippets assigned and the number of snippets already reviewed. Project personnel initially assign each reviewer a set of snippets to review and can assign additional ones upon request. The reviewers are asked two questions for each snippet:

**Does the highlighted text in the snippet refer to a dataset?** Confirm whether the machine learning algorithm was correct in considering the phrase as a reference to a dataset in general.

**Does the highlighted text in the snippet refer to the dataset below?** Confirm whether the model correctly matched the dataset candidate to one of those dataset names provided by the agencies.

<figure><img src=".gitbook/assets/Screenshot 2023-03-15 at 2.45.54 PM.png" alt=""><figcaption><p>Figure 7: Screenshot of Validation Tool</p></figcaption></figure>

<figure><img src=".gitbook/assets/Screenshot 2023-03-15 at 2.46.46 PM.png" alt=""><figcaption><p>Figure 8: Screenshot of Reviewed Snippet</p></figcaption></figure>

<figure><img src=".gitbook/assets/Screenshot 2023-03-15 at 2.47.16 PM.png" alt=""><figcaption><p>Figure 9: Screenshot of Items per page</p></figcaption></figure>

For each question, the reviewer clicks on one box, choosing either yes, no, or unsure. As soon as the users answer the two questions, the text snippet grays out, and they can click the “Modify Review” button to review the text snippet again, changing the answers. Reviewers can also hide/unhide snippets that have already been reviewed by checking/unchecking the checkbox at the top of the page.&#x20;

At the very bottom of the page, the users can select the number of snippets per page to display. Only ten snippets per page are displayed by default, and up to 50 snippets per page can be displayed.&#x20;

Users will see a message thanking them when they review all the snippets on the list. Rich context personnel will assign more snippets to review upon request, and users will receive an email notifying them about the new assignment.
