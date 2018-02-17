
#### Lilikoi: an R package of personalized metabolomics pathway analysis
#### Lilikoi is a novel tool for personalized pathway analysis of metabolomics data. 
#### It has four modules:
* feature mapper, dimension transformation, feature selection, and classification and prediction.
<img src="FIG1.JPG">


```R
library(devtools)
```

## Data format: 
### User recommends to save their data in csv format. Columns are metabolites and rows are samples. Case and control label should be saved in the second column such as the below raw data:
#### Note: make sure to disable the check.names option in the read.csv


```R
plasma_data_dir=system.file("extdata", "plasma_breast_cancer.csv", package = "lilikoi")
plasma_data=read.csv(plasma_data_dir,check.names=F,row.names=1)
head(plasma_data)
dim(plasma_data)
table(plasma_data$Label)
```


<table>
<thead><tr><th></th><th scope=col>Label</th><th scope=col>Asparagine</th><th scope=col>Hypotaurine</th><th scope=col>5-Oxoproline</th><th scope=col>Cysteine</th><th scope=col>Aspartate</th><th scope=col>Glycerolphosphate</th><th scope=col>Glycerophosphocholine</th><th scope=col>Glutamate</th><th scope=col>Glutamine</th><th scope=col>⋯</th><th scope=col>D-Glucuronic acid</th><th scope=col>Tetradecanoylcarnitine</th><th scope=col>a-Hydroxyisobutyric acid</th><th scope=col>L-Leucine</th><th scope=col>Carnitine</th><th scope=col>Cyclohexyloxy</th><th scope=col>Dodecanoylcarnitine</th><th scope=col>Creatine</th><th scope=col>Elaidic acid</th><th scope=col>o-Tyrosine</th></tr></thead>
<tbody>
	<tr><th scope=row>PN00506</th><td>Cancer     </td><td>0.09211519 </td><td>0.015607552</td><td>1.4384582  </td><td>0.09545046 </td><td>0.05862126 </td><td>0.013007384</td><td>0.09467126 </td><td>0.08597329 </td><td>0.1998283  </td><td>⋯          </td><td>0.003882790</td><td>0.022665362</td><td>0.3755292  </td><td>2.439328   </td><td>0.007897827</td><td>0.7692582  </td><td>0.04746359 </td><td>0.3033538  </td><td>0.004448686</td><td>0.1825662  </td></tr>
	<tr><th scope=row>PN00032</th><td>Cancer     </td><td>0.09973670 </td><td>0.009799671</td><td>0.6588595  </td><td>0.10677437 </td><td>0.02643142 </td><td>0.012061316</td><td>0.19675399 </td><td>0.03957823 </td><td>0.2166030  </td><td>⋯          </td><td>0.004647794</td><td>0.006417936</td><td>0.7200045  </td><td>2.357825   </td><td>0.013058909</td><td>0.6130774  </td><td>0.01453644 </td><td>0.1906820  </td><td>0.003061111</td><td>0.2036796  </td></tr>
	<tr><th scope=row>PN01613</th><td>Cancer     </td><td>0.08264039 </td><td>0.005909090</td><td>0.9643893  </td><td>0.04526247 </td><td>0.03348040 </td><td>0.026729726</td><td>0.05674980 </td><td>0.06436560 </td><td>0.3026230  </td><td>⋯          </td><td>0.008211485</td><td>0.012544114</td><td>0.7035599  </td><td>2.095919   </td><td>0.026404741</td><td>0.6294949  </td><td>0.03070484 </td><td>0.1063044  </td><td>0.029403400</td><td>0.1423214  </td></tr>
	<tr><th scope=row>PN00516</th><td>Cancer     </td><td>0.13046063 </td><td>0.008726064</td><td>1.1546124  </td><td>0.10821156 </td><td>0.04242535 </td><td>0.010585494</td><td>0.07766378 </td><td>0.05791242 </td><td>0.3670933  </td><td>⋯          </td><td>0.006685058</td><td>0.016009324</td><td>0.4612104  </td><td>4.596898   </td><td>0.035797215</td><td>0.6410135  </td><td>0.03402296 </td><td>0.3302062  </td><td>0.002296782</td><td>0.2816584  </td></tr>
	<tr><th scope=row>PN00528</th><td>Cancer     </td><td>0.10382572 </td><td>0.015073054</td><td>1.5226628  </td><td>0.10142434 </td><td>0.04957616 </td><td>0.008734067</td><td>0.18039997 </td><td>0.12564110 </td><td>0.4705194  </td><td>⋯          </td><td>0.009539999</td><td>0.019837064</td><td>1.1060993  </td><td>2.017713   </td><td>0.038289854</td><td>0.6641017  </td><td>0.03344980 </td><td>0.2497729  </td><td>0.023087571</td><td>0.2076592  </td></tr>
	<tr><th scope=row>PN00746</th><td>Cancer     </td><td>0.04870613 </td><td>0.008073503</td><td>1.0397869  </td><td>0.09784539 </td><td>0.03366923 </td><td>0.012024970</td><td>0.07073499 </td><td>0.18332951 </td><td>0.3250621  </td><td>⋯          </td><td>0.004115928</td><td>0.022204168</td><td>1.0099742  </td><td>3.707926   </td><td>0.061546666</td><td>0.6507238  </td><td>0.04224291 </td><td>0.2448327  </td><td>0.005317198</td><td>0.2182078  </td></tr>
</tbody>
</table>




<ol class=list-inline>
	<li>207</li>
	<li>228</li>
</ol>




    
    Cancer Normal 
       126     81 


## The above data set is the metabolomics cohort which  is composed of 126 breast cancer and 81 control plasma samples from City of Hope Hospital (COH) 
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4818393/

## I- Load the data using Lilikoi Loaddata function


```R
Loaddata(file=system.file("extdata", "plasma_breast_cancer.csv", package = "lilikoi"))
```


<table>
<thead><tr><th></th><th scope=col>Label</th><th scope=col>Asparagine</th><th scope=col>Hypotaurine</th><th scope=col>5-Oxoproline</th><th scope=col>Cysteine</th><th scope=col>Aspartate</th><th scope=col>Glycerolphosphate</th><th scope=col>Glycerophosphocholine</th><th scope=col>Glutamate</th><th scope=col>Glutamine</th><th scope=col>⋯</th><th scope=col>D-Glucuronic acid</th><th scope=col>Tetradecanoylcarnitine</th><th scope=col>a-Hydroxyisobutyric acid</th><th scope=col>L-Leucine</th><th scope=col>Carnitine</th><th scope=col>Cyclohexyloxy</th><th scope=col>Dodecanoylcarnitine</th><th scope=col>Creatine</th><th scope=col>Elaidic acid</th><th scope=col>o-Tyrosine</th></tr></thead>
<tbody>
	<tr><th scope=row>PN00506</th><td>Cancer     </td><td>0.09211519 </td><td>0.015607552</td><td>1.4384582  </td><td>0.09545046 </td><td>0.05862126 </td><td>0.013007384</td><td>0.09467126 </td><td>0.08597329 </td><td>0.1998283  </td><td>⋯          </td><td>0.003882790</td><td>0.022665362</td><td>0.3755292  </td><td>2.439328   </td><td>0.007897827</td><td>0.7692582  </td><td>0.04746359 </td><td>0.3033538  </td><td>0.004448686</td><td>0.1825662  </td></tr>
	<tr><th scope=row>PN00032</th><td>Cancer     </td><td>0.09973670 </td><td>0.009799671</td><td>0.6588595  </td><td>0.10677437 </td><td>0.02643142 </td><td>0.012061316</td><td>0.19675399 </td><td>0.03957823 </td><td>0.2166030  </td><td>⋯          </td><td>0.004647794</td><td>0.006417936</td><td>0.7200045  </td><td>2.357825   </td><td>0.013058909</td><td>0.6130774  </td><td>0.01453644 </td><td>0.1906820  </td><td>0.003061111</td><td>0.2036796  </td></tr>
	<tr><th scope=row>PN01613</th><td>Cancer     </td><td>0.08264039 </td><td>0.005909090</td><td>0.9643893  </td><td>0.04526247 </td><td>0.03348040 </td><td>0.026729726</td><td>0.05674980 </td><td>0.06436560 </td><td>0.3026230  </td><td>⋯          </td><td>0.008211485</td><td>0.012544114</td><td>0.7035599  </td><td>2.095919   </td><td>0.026404741</td><td>0.6294949  </td><td>0.03070484 </td><td>0.1063044  </td><td>0.029403400</td><td>0.1423214  </td></tr>
	<tr><th scope=row>PN00516</th><td>Cancer     </td><td>0.13046063 </td><td>0.008726064</td><td>1.1546124  </td><td>0.10821156 </td><td>0.04242535 </td><td>0.010585494</td><td>0.07766378 </td><td>0.05791242 </td><td>0.3670933  </td><td>⋯          </td><td>0.006685058</td><td>0.016009324</td><td>0.4612104  </td><td>4.596898   </td><td>0.035797215</td><td>0.6410135  </td><td>0.03402296 </td><td>0.3302062  </td><td>0.002296782</td><td>0.2816584  </td></tr>
	<tr><th scope=row>PN00528</th><td>Cancer     </td><td>0.10382572 </td><td>0.015073054</td><td>1.5226628  </td><td>0.10142434 </td><td>0.04957616 </td><td>0.008734067</td><td>0.18039997 </td><td>0.12564110 </td><td>0.4705194  </td><td>⋯          </td><td>0.009539999</td><td>0.019837064</td><td>1.1060993  </td><td>2.017713   </td><td>0.038289854</td><td>0.6641017  </td><td>0.03344980 </td><td>0.2497729  </td><td>0.023087571</td><td>0.2076592  </td></tr>
	<tr><th scope=row>PN00746</th><td>Cancer     </td><td>0.04870613 </td><td>0.008073503</td><td>1.0397869  </td><td>0.09784539 </td><td>0.03366923 </td><td>0.012024970</td><td>0.07073499 </td><td>0.18332951 </td><td>0.3250621  </td><td>⋯          </td><td>0.004115928</td><td>0.022204168</td><td>1.0099742  </td><td>3.707926   </td><td>0.061546666</td><td>0.6507238  </td><td>0.04224291 </td><td>0.2448327  </td><td>0.005317198</td><td>0.2182078  </td></tr>
</tbody>
</table>



## II- Transforms the metabolite names to the HMDB ids uisng Lilikoi MetaTOpathway function
### Lilikoi allows the user to input any kind of metabolite IDs including metabolites names ('name') along with synonyms, KEGG IDs ('kegg'), HMDB IDs ('hmdb') and PubChem IDs ('pubchem'). 
### if the metabolites have a standard names as ID, Lilikoi will match these names among 100 k saved database, if there are not any hits, Lilikoi will perform fuzzy matching to find the closest matching for this metabolite.
### The below flowchart will explain this matching process in more details.
<img src="matching.JPG">


```R
Metabolite_pathway_table=MetaTOpathway('name')
head(Metabolite_pathway_table)
```

    Loading required package: dplyr
    
    Attaching package: ‘dplyr’
    
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    



<table>
<thead><tr><th scope=col>Query</th><th scope=col>Match</th><th scope=col>HMDB</th><th scope=col>PubChem</th><th scope=col>KEGG</th><th scope=col>Comment</th><th scope=col>pathway</th></tr></thead>
<tbody>
	<tr><td>Oxaloacetate                                     </td><td>Oxalacetic acid                                  </td><td>HMDB00223                                        </td><td>970                                              </td><td>C00036                                           </td><td>1                                                </td><td>Alanine Metabolism                               </td></tr>
	<tr><td>Arachidonic acid                                 </td><td>Arachidonic acid                                 </td><td>HMDB01043                                        </td><td>444899                                           </td><td>C00219                                           </td><td>1                                                </td><td>Alpha Linolenic Acid and Linoleic Acid Metabolism</td></tr>
	<tr><td>Tetracosahexaenoic acid                          </td><td>Tetracosahexaenoic acid                          </td><td>HMDB02007                                        </td><td>11792612                                         </td><td>                                                 </td><td>1                                                </td><td>Alpha Linolenic Acid and Linoleic Acid Metabolism</td></tr>
	<tr><td>N-Acetylneuraminic acid                          </td><td>N-Acetylneuraminic acid                          </td><td>HMDB00230                                        </td><td>445063                                           </td><td>C19910                                           </td><td>1                                                </td><td>Amino Sugar Metabolism                           </td></tr>
	<tr><td>Asparagine                                       </td><td>L-Asparagine                                     </td><td>HMDB00168                                        </td><td>6267                                             </td><td>C00152                                           </td><td>1                                                </td><td>Ammonia Recycling                                </td></tr>
	<tr><td>Glutamine                                        </td><td>L-Glutamine                                      </td><td>HMDB00641                                        </td><td>5961                                             </td><td>C00064                                           </td><td>1                                                </td><td>Ammonia Recycling                                </td></tr>
</tbody>
</table>



## III- Transform metabolites into pathway using Pathifier algorithm
https://www.bioconductor.org/packages/release/bioc/html/pathifier.html
#### A specific pathway dysregulation score (PDS) is inferred to measure the abnormity for each sample in each pathway. For each pathway, the samples are mapped in a high dimensional principal component space and a principal curve is constructed along the samples and smoothed. The PDS score measures the distance from the projected dot along the curve to the centroid of normal samples (origin point of the curve).


```R
PDSmatrix= PDSfun(Metabolite_pathway_table)
```

    Loading required package: pathifier


    robust_score_bydist. min_exp= 0 , min_std= 0 
    pathway  1 > sig: 0.01060128 
    pathway  2 > sig: 0.01060128 
    skipping pathway  3  k1= 1 
    pathway  4 > sig: 0.231045 
    pathway  5 > sig: 0.06000226 
    pathway  6 > sig: 0.01959031 
    pathway  7 > sig: 0.04592979 
    pathway  8 > sig: 0.01060128 
    pathway  9 > sig: 0.01959031 
    pathway  10 > sig: 0.01959031 
    pathway  11 > sig: 0.01959031 
    pathway  12 > sig: 0.01959031 
    pathway  13 > sig: 0.01959031 
    pathway  14 > sig: 0.01959031 
    pathway  15 > sig: 0.01959031 
    pathway  16 > sig: 0.231045 
    skipping pathway  17  k1= 2 
    skipping pathway  18  k1= 2 
    pathway  19 > sig: 0.1280958 
    pathway  19  k= 7 ( 7 ) wj= 4 >new sig: 0.1219056 x rejected
    skipping pathway  20  k1= 0 
    skipping pathway  21  k1= 0 
    skipping pathway  22  k1= 0 
    skipping pathway  23  k1= 1 
    skipping pathway  24  k1= 2 
    skipping pathway  25  k1= 0 
    skipping pathway  26  k1= 0 
    pathway  27 > sig: 0.1721073 
    pathway  28 > sig: 0.1721073 
    pathway  29 > sig: 0.1721073 
    skipping pathway  30  k1= 0 
    pathway  31 > sig: 0.01060128 
    pathway  32 > sig: 0.01060128 
    skipping pathway  33  k1= 1 
    skipping pathway  34  k1= 2 
    skipping pathway  35  k1= 1 
    pathway  36 > sig: 0.1721073 
    pathway  37 > sig: 0.1183521 
    pathway  38 > sig: 0.243436 
    skipping pathway  39  k1= 1 
    skipping pathway  40  k1= 0 
    skipping pathway  41  k1= 2 
    skipping pathway  42  k1= 0 
    pathway  43 > sig: 0.1130218 
    skipping pathway  44  k1= 0 
    skipping pathway  45  k1= 0 
    skipping pathway  46  k1= 2 
    skipping pathway  47  k1= 0 
    skipping pathway  48  k1= 0 
    skipping pathway  49  k1= 0 
    pathway  50 > sig: 0.1455693 
    skipping pathway  51  k1= 1 
    pathway  52 > sig: 0.2279451 
    pathway  53 > sig: 0.04121526 
    pathway  54 > sig: 0.1133337 
    skipping pathway  55  k1= 0 
    skipping pathway  56  k1= 0 
    pathway  57 > sig: 0.1898794 
    skipping pathway  58  k1= 2 
    skipping pathway  59  k1= 1 
    skipping pathway  60  k1= 1 
    skipping pathway  61  k1= 1 
    skipping pathway  62  k1= 1 
    skipping pathway  63  k1= 0 
    skipping pathway  64  k1= 0 
    skipping pathway  65  k1= 0 
    skipping pathway  66  k1= 1 
    skipping pathway  67  k1= 0 
    skipping pathway  68  k1= 0 
    pathway  69 > sig: 0.1741431 
    pathway  69  k= 6 ( 6 ) wj= 1 >new sig: 0.1740052 x rejected
    pathway  70 > sig: 0.04544688 
    pathway  71 > sig: 0.1997643 
    pathway  72 > sig: 0.1997643 
    skipping pathway  73  k1= 1 
    pathway  74 > sig: 0.05457046 
    skipping pathway  75  k1= 0 
    skipping pathway  76  k1= 0 
    pathway  77 > sig: 0.1128266 
    pathway  78 > sig: 0.2015439 
    skipping pathway  79  k1= 0 
    skipping pathway  80  k1= 0 
    skipping pathway  81  k1= 2 
    skipping pathway  82  k1= 0 
    skipping pathway  83  k1= 0 
    pathway  84 > sig: 0.1721073 
    skipping pathway  85  k1= 0 
    pathway  86 > sig: 0.1455693 
    skipping pathway  87  k1= 0 
    skipping pathway  88  k1= 1 
    skipping pathway  89  k1= 0 
    skipping pathway  90  k1= 0 
    skipping pathway  91  k1= 1 
    skipping pathway  92  k1= 0 
    pathway  93 > sig: 0.1498467 
    pathway  94 > sig: 0.01959031 
    skipping pathway  95  k1= 1 
    skipping pathway  96  k1= 2 
    pathway  97 > sig: 0.03244248 
    skipping pathway  98  k1= 2 
    skipping pathway  99  k1= 0 
    pathway  100 > sig: 0.06287007 
    pathway  101 > sig: 0.02983646 
    pathway  102 > sig: 0.08380813 
    pathway  102  k= 8 ( 8 ) wj= 3 >new sig: 0.07925463 x rejected
    pathway  103 > sig: 0.002012073 
    skipping pathway  104  k1= 2 
    skipping pathway  105  k1= 1 
    skipping pathway  106  k1= 0 
    skipping pathway  107  k1= 0 
    skipping pathway  108  k1= 1 
    skipping pathway  109  k1= 1 
    skipping pathway  110  k1= 1 
    skipping pathway  111  k1= 0 
    pathway  112 > sig: 0.008230986 
    skipping pathway  113  k1= 1 
    skipping pathway  114  k1= 1 
    skipping pathway  115  k1= 2 
    skipping pathway  116  k1= 1 
    pathway  117 > sig: 0.1132979 
    pathway  118 > sig: 0.2015439 
    skipping pathway  119  k1= 0 
    skipping pathway  120  k1= 0 
    skipping pathway  121  k1= 0 
    skipping pathway  122  k1= 0 
    skipping pathway  123  k1= 0 
    pathway  124 > sig: 0.1997643 
    skipping pathway  125  k1= 1 
    pathway  126 > sig: 0.07978985 
    skipping pathway  127  k1= 0 
    skipping pathway  128  k1= 0 
    skipping pathway  129  k1= 2 
    skipping pathway  130  k1= 1 
    skipping pathway  131  k1= 1 
    pathway  132 > sig: 0.04090575 
    pathway  133 > sig: 0.1498467 
    skipping pathway  134  k1= 0 
    skipping pathway  135  k1= 0 
    pathway  136 > sig: 0.05457046 
    skipping pathway  137  k1= 1 
    skipping pathway  138  k1= 0 
    pathway  139 > sig: 0.06287007 
    skipping pathway  140  k1= 2 
    skipping pathway  141  k1= 0 
    skipping pathway  142  k1= 1 
    skipping pathway  143  k1= 0 
    skipping pathway  144  k1= 0 
    skipping pathway  145  k1= 2 
    skipping pathway  146  k1= 0 
    skipping pathway  147  k1= 1 
    skipping pathway  148  k1= 1 
    skipping pathway  149  k1= 2 
    skipping pathway  150  k1= 1 
    skipping pathway  151  k1= 2 
    skipping pathway  152  k1= 0 
    skipping pathway  153  k1= 0 
    skipping pathway  154  k1= 0 
    skipping pathway  155  k1= 0 
    skipping pathway  156  k1= 0 
    skipping pathway  157  k1= 0 
    skipping pathway  158  k1= 0 
    skipping pathway  159  k1= 0 
    skipping pathway  160  k1= 0 
    skipping pathway  161  k1= 0 
    pathway  162 > sig: 0.06000226 
    pathway  163 > sig: 0.1997643 
    pathway  164 > sig: 0.1455693 
    pathway  165 > sig: 0.1455693 
    skipping pathway  166  k1= 0 
    pathway  167 > sig: 0.1455693 
    skipping pathway  168  k1= 0 
    skipping pathway  169  k1= 0 
    skipping pathway  170  k1= 0 
    skipping pathway  171  k1= 0 
    skipping pathway  172  k1= 1 
    skipping pathway  173  k1= 0 
    skipping pathway  174  k1= 0 
    skipping pathway  175  k1= 0 
    skipping pathway  176  k1= 0 
    pathway  177 > sig: 0.06287007 
    pathway  178 > sig: 0.06287007 
    skipping pathway  179  k1= 0 
    skipping pathway  180  k1= 2 
    pathway  181 > sig: 0.06000226 
    pathway  182 > sig: 0.01060128 
    pathway  183 > sig: 0.01060128 
    pathway  184 > sig: 0.01060128 
    skipping pathway  185  k1= 0 
    pathway  186 > sig: 0.04544688 
    pathway  187 > sig: 0.1042476 
    skipping pathway  188  k1= 0 
    skipping pathway  189  k1= 0 
    skipping pathway  190  k1= 1 
    pathway  191 > sig: 0.04125354 
    pathway  192 > sig: 0.1655392 
    skipping pathway  193  k1= 1 
    skipping pathway  194  k1= 0 
    pathway  195 > sig: 0.006458438 
    skipping pathway  196  k1= 1 
    pathway  197 > sig: 0.01677426 
    pathway  198 > sig: 0.04712622 
    skipping pathway  199  k1= 0 
    pathway  200 > sig: 0.1455693 
    skipping pathway  201  k1= 0 
    skipping pathway  202  k1= 0 
    skipping pathway  203  k1= 2 
    skipping pathway  204  k1= 0 
    skipping pathway  205  k1= 1 
    skipping pathway  206  k1= 0 
    skipping pathway  207  k1= 0 
    skipping pathway  208  k1= 1 
    pathway  209 > sig: 0.03244248 
    pathway  210 > sig: 0.02041865 
    skipping pathway  211  k1= 0 
    skipping pathway  212  k1= 0 
    pathway  213 > sig: 0.02041865 
    pathway  214 > sig: 0.02041865 
    skipping pathway  215  k1= 0 
    skipping pathway  216  k1= 0 
    pathway  217 > sig: 0.1130218 
    skipping pathway  218  k1= 0 
    skipping pathway  219  k1= 0 
    skipping pathway  220  k1= 0 
    pathway  221 > sig: 0.1130218 
    skipping pathway  222  k1= 1 
    skipping pathway  223  k1= 0 
    skipping pathway  224  k1= 0 
    pathway  225 > sig: 0.1455693 
    skipping pathway  226  k1= 0 
    skipping pathway  227  k1= 0 
    skipping pathway  228  k1= 0 
    skipping pathway  229  k1= 0 
    skipping pathway  230  k1= 0 
    skipping pathway  231  k1= 0 
    skipping pathway  232  k1= 0 
    skipping pathway  233  k1= 0 
    skipping pathway  234  k1= 1 
    skipping pathway  235  k1= 1 
    skipping pathway  236  k1= 0 
    skipping pathway  237  k1= 0 
    skipping pathway  238  k1= 0 
    skipping pathway  239  k1= 0 
    pathway  240 > sig: 0.1455693 
    skipping pathway  241  k1= 0 
    skipping pathway  242  k1= 0 
    skipping pathway  243  k1= 0 
    skipping pathway  244  k1= 0 
    skipping pathway  245  k1= 0 
    skipping pathway  246  k1= 1 
    skipping pathway  247  k1= 0 
    skipping pathway  248  k1= 1 
    skipping pathway  249  k1= 1 
    skipping pathway  250  k1= 1 
    skipping pathway  251  k1= 0 
    skipping pathway  252  k1= 0 
    skipping pathway  253  k1= 0 
    skipping pathway  254  k1= 0 
    skipping pathway  255  k1= 0 
    pathway  256 > sig: 0.08931532 
    pathway  257 > sig: 0.06287007 
    pathway  258 > sig: 0.01677426 
    skipping pathway  259  k1= 0 
    pathway  260 > sig: 0.07580942 
    skipping pathway  261  k1= 1 
    pathway  262 > sig: 0.004271635 
    skipping pathway  263  k1= 1 
    skipping pathway  264  k1= 1 
    skipping pathway  265  k1= 1 
    skipping pathway  266  k1= 1 
    skipping pathway  267  k1= 1 
    skipping pathway  268  k1= 2 
    skipping pathway  269  k1= 0 
    skipping pathway  270  k1= 0 
    skipping pathway  271  k1= 0 
    skipping pathway  272  k1= 0 
    skipping pathway  273  k1= 0 
    skipping pathway  274  k1= 0 
    skipping pathway  275  k1= 0 
    skipping pathway  276  k1= 0 
    skipping pathway  277  k1= 0 
    skipping pathway  278  k1= 2 
    skipping pathway  279  k1= 0 
    skipping pathway  280  k1= 0 
    skipping pathway  281  k1= 1 
    skipping pathway  282  k1= 0 
    skipping pathway  283  k1= 0 
    skipping pathway  284  k1= 0 
    skipping pathway  285  k1= 0 
    skipping pathway  286  k1= 0 
    skipping pathway  287  k1= 0 
    skipping pathway  288  k1= 0 
    skipping pathway  289  k1= 0 
    skipping pathway  290  k1= 0 
    pathway  291 > sig: 0.1107059 
    pathway  292 > sig: 0.06747033 
    skipping pathway  293  k1= 2 
    pathway  294 > sig: 0.06747033 
    pathway  295 > sig: 0.06000226 
    skipping pathway  296  k1= 1 
    pathway  297 > sig: 0.04121526 
    pathway  298 > sig: 0.1498467 
    skipping pathway  299  k1= 2 
    pathway  300 > sig: 0.143118 
    pathway  301 > sig: 0.05153077 
    skipping pathway  302  k1= 2 
    skipping pathway  303  k1= 2 
    skipping pathway  304  k1= 2 
    skipping pathway  305  k1= 2 
    skipping pathway  306  k1= 2 
    skipping pathway  307  k1= 0 
    skipping pathway  308  k1= 0 
    skipping pathway  309  k1= 0 
    pathway  310 > sig: 0.08931532 
    skipping pathway  311  k1= 0 
    skipping pathway  312  k1= 0 
    skipping pathway  313  k1= 0 
    pathway  314 > sig: 0.1455693 
    skipping pathway  315  k1= 0 
    skipping pathway  316  k1= 0 
    skipping pathway  317  k1= 0 
    skipping pathway  318  k1= 0 
    pathway  319 > sig: 0.08931532 
    pathway  320 > sig: 0.1107059 
    pathway  321 > sig: 0.1502423 
    skipping pathway  322  k1= 1 
    skipping pathway  323  k1= 1 
    skipping pathway  324  k1= 0 
    pathway  325 > sig: 0.231045 
    skipping pathway  326  k1= 1 
    skipping pathway  327  k1= 1 
    skipping pathway  328  k1= 2 
    pathway  329 > sig: 0.0007515346 
    skipping pathway  330  k1= 2 
    pathway  331 > sig: 0.01677426 
    skipping pathway  332  k1= 2 
    pathway  333 > sig: 0.01677426 
    pathway  334 > sig: 0.05623814 
    pathway  335 > sig: 0.02041865 
    pathway  336 > sig: 0.04125354 
    pathway  337 > sig: 0.195724 
    pathway  338 > sig: 0.1107059 
    pathway  339 > sig: 0.09890103 
    pathway  340 > sig: 0.1107059 
    pathway  341 > sig: 0.1107059 
    pathway  342 > sig: 0.1107059 
    pathway  343 > sig: 0.09890103 
    pathway  344 > sig: 0.09890103 
    pathway  345 > sig: 0.09890103 
    pathway  346 > sig: 0.07580942 
    pathway  347 > sig: 0.07580942 
    pathway  348 > sig: 0.1334903 
    skipping pathway  349  k1= 0 
    skipping pathway  350  k1= 0 
    skipping pathway  351  k1= 0 
    skipping pathway  352  k1= 0 
    pathway  353 > sig: 0.1231738 
    skipping pathway  354  k1= 1 
    pathway  355 > sig: 0.1721073 
    skipping pathway  356  k1= 0 
    pathway  357 > sig: 0.04544688 
    skipping pathway  358  k1= 1 
    pathway  359 > sig: 0.1130218 
    skipping pathway  360  k1= 1 
    skipping pathway  361  k1= 0 
    skipping pathway  362  k1= 0 
    skipping pathway  363  k1= 2 
    skipping pathway  364  k1= 0 
    skipping pathway  365  k1= 0 
    skipping pathway  366  k1= 2 
    pathway  367 > sig: 0.1529271 
    skipping pathway  368  k1= 2 
    pathway  369 > sig: 0.231045 
    skipping pathway  370  k1= 2 
    pathway  371 > sig: 0.04125354 
    skipping pathway  372  k1= 0 
    skipping pathway  373  k1= 2 
    skipping pathway  374  k1= 0 
    skipping pathway  375  k1= 0 
    skipping pathway  376  k1= 1 
    skipping pathway  377  k1= 0 
    skipping pathway  378  k1= 1 
    skipping pathway  379  k1= 0 
    skipping pathway  380  k1= 2 
    skipping pathway  381  k1= 2 
    pathway  382 > sig: 0.02041865 
    pathway  383 > sig: 0.231045 
    skipping pathway  384  k1= 2 
    skipping pathway  385  k1= 2 
    pathway  386 > sig: 0.04125354 
    pathway  387 > sig: 0.04544688 
    pathway  388 > sig: 0.04544688 
    skipping pathway  389  k1= 0 
    skipping pathway  390  k1= 0 
    skipping pathway  391  k1= 0 
    pathway  392 > sig: 0.04544688 
    pathway  393 > sig: 0.04544688 
    skipping pathway  394  k1= 0 
    pathway  395 > sig: 0.2015439 
    skipping pathway  396  k1= 1 
    skipping pathway  397  k1= 2 
    skipping pathway  398  k1= 1 
    skipping pathway  399  k1= 0 
    skipping pathway  400  k1= 0 
    skipping pathway  401  k1= 0 
    skipping pathway  402  k1= 0 
    skipping pathway  403  k1= 1 
    skipping pathway  404  k1= 0 
    skipping pathway  405  k1= 0 
    skipping pathway  406  k1= 1 
    skipping pathway  407  k1= 1 
    skipping pathway  408  k1= 1 
    skipping pathway  409  k1= 0 
    pathway  410 > sig: 0.1492181 
    pathway  411 > sig: 0.1560827 
    skipping pathway  412  k1= 2 
    skipping pathway  413  k1= 0 
    skipping pathway  414  k1= 0 
    skipping pathway  415  k1= 0 
    skipping pathway  416  k1= 0 
    skipping pathway  417  k1= 0 
    skipping pathway  418  k1= 0 
    skipping pathway  419  k1= 0 
    skipping pathway  420  k1= 0 
    skipping pathway  421  k1= 0 
    skipping pathway  422  k1= 0 
    skipping pathway  423  k1= 0 
    skipping pathway  424  k1= 0 
    pathway  425 > sig: 0.01959031 
    pathway  426 > sig: 0.01959031 
    pathway  427 > sig: 0.01959031 
    skipping pathway  428  k1= 0 
    skipping pathway  429  k1= 1 
    pathway  430 > sig: 0.1455693 
    skipping pathway  431  k1= 1 
    skipping pathway  432  k1= 1 
    skipping pathway  433  k1= 1 
    skipping pathway  434  k1= 1 
    pathway  435 > sig: 0.08931532 
    pathway  436 > sig: 0.04544688 
    skipping pathway  437  k1= 0 
    pathway  438 > sig: 0.1183521 
    skipping pathway  439  k1= 1 
    skipping pathway  440  k1= 1 
    skipping pathway  441  k1= 0 
    skipping pathway  442  k1= 0 
    skipping pathway  443  k1= 0 
    skipping pathway  444  k1= 0 
    skipping pathway  445  k1= 0 
    skipping pathway  446  k1= 0 
    pathway  447 > sig: 0.133122 
    skipping pathway  448  k1= 1 
    skipping pathway  449  k1= 0 
    pathway  450 > sig: 0.1721073 
    skipping pathway  451  k1= 0 
    skipping pathway  452  k1= 1 
    skipping pathway  453  k1= 0 
    skipping pathway  454  k1= 0 
    skipping pathway  455  k1= 0 
    skipping pathway  456  k1= 0 
    skipping pathway  457  k1= 0 
    skipping pathway  458  k1= 1 
    skipping pathway  459  k1= 0 
    skipping pathway  460  k1= 0 
    skipping pathway  461  k1= 1 
    skipping pathway  462  k1= 1 
    skipping pathway  463  k1= 0 
    skipping pathway  464  k1= 1 
    skipping pathway  465  k1= 0 
    skipping pathway  466  k1= 2 
    pathway  467 > sig: 0.1455693 
    pathway  468 > sig: 0.1344559 
    pathway  469 > sig: 0.08023572 
    skipping pathway  470  k1= 1 
    skipping pathway  471  k1= 2 
    skipping pathway  472  k1= 0 
    skipping pathway  473  k1= 0 
    skipping pathway  474  k1= 2 
    skipping pathway  475  k1= 2 
    skipping pathway  476  k1= 2 
    skipping pathway  477  k1= 0 
    pathway  478 > sig: 0.01959031 
    skipping pathway  479  k1= 0 
    skipping pathway  480  k1= 1 
    skipping pathway  481  k1= 1 
    skipping pathway  482  k1= 1 
    skipping pathway  483  k1= 0 
    skipping pathway  484  k1= 0 
    skipping pathway  485  k1= 1 
    skipping pathway  486  k1= 0 
    pathway  487 > sig: 0.1721073 
    skipping pathway  488  k1= 1 
    pathway  489 > sig: 0.1939081 
    pathway  489  k= 21 ( 21 ) wj= 1 >new sig: 0.1095682 | accepted!
    pathway  489  k= 20 ( 20 ) wj= 4 >new sig: 0.06377461 | accepted!
    pathway  489  k= 19 ( 19 ) wj= 2 >new sig: 0.04390128 | accepted!
    skipping pathway  490  k1= 0 
    pathway  491 > sig: 0.08931532 
    skipping pathway  492  k1= 0 
    skipping pathway  493  k1= 0 
    pathway  494 > sig: 0.04125354 
    pathway  495 > sig: 0.04125354 
    skipping pathway  496  k1= 0 
    skipping pathway  497  k1= 1 
    pathway  498 > sig: 0.04125354 
    pathway  499 > sig: 0.01959031 
    pathway  500 > sig: 0.01959031 
    skipping pathway  501  k1= 2 
    skipping pathway  502  k1= 1 
    skipping pathway  503  k1= 0 
    skipping pathway  504  k1= 2 
    skipping pathway  505  k1= 0 
    pathway  506 > sig: 0.03728292 
    pathway  507 > sig: 0.1455693 
    skipping pathway  508  k1= 2 
    skipping pathway  509  k1= 1 
    skipping pathway  510  k1= 2 
    pathway  511 > sig: 0.06000226 
    pathway  512 > sig: 0.1721073 
    pathway  513 > sig: 0.0169386 
    pathway  514 > sig: 0.03244248 
    skipping pathway  515  k1= 0 
    skipping pathway  516  k1= 0 
    pathway  517 > sig: 0.1721073 
    pathway  518 > sig: 0.1130218 
    skipping pathway  519  k1= 0 
    skipping pathway  520  k1= 0 
    skipping pathway  521  k1= 0 
    skipping pathway  522  k1= 0 
    skipping pathway  523  k1= 0 
    pathway  524 > sig: 0.09890103 
    skipping pathway  525  k1= 1 
    skipping pathway  526  k1= 0 
    skipping pathway  527  k1= 0 
    pathway  528 > sig: 0.1721073 
    skipping pathway  529  k1= 0 
    skipping pathway  530  k1= 1 
    skipping pathway  531  k1= 0 
    skipping pathway  532  k1= 1 
    skipping pathway  533  k1= 0 
    skipping pathway  534  k1= 0 
    skipping pathway  535  k1= 0 
    skipping pathway  536  k1= 0 
    pathway  537 > sig: 0.1455693 
    pathway  538 > sig: 0.1455693 
    pathway  539 > sig: 0.1529304 
    skipping pathway  540  k1= 0 
    skipping pathway  541  k1= 0 
    skipping pathway  542  k1= 0 
    pathway  543 > sig: 0.1973927 
    skipping pathway  544  k1= 0 
    skipping pathway  545  k1= 0 
    skipping pathway  546  k1= 0 
    skipping pathway  547  k1= 0 
    skipping pathway  548  k1= 0 
    skipping pathway  549  k1= 0 
    skipping pathway  550  k1= 0 
    skipping pathway  551  k1= 0 
    skipping pathway  552  k1= 0 
    skipping pathway  553  k1= 1 
    skipping pathway  554  k1= 0 
    skipping pathway  555  k1= 0 
    skipping pathway  556  k1= 0 
    skipping pathway  557  k1= 0 
    pathway  558 > sig: 0.02041865 
    skipping pathway  559  k1= 2 
    skipping pathway  560  k1= 0 
    skipping pathway  561  k1= 0 
    skipping pathway  562  k1= 0 
    skipping pathway  563  k1= 0 
    skipping pathway  564  k1= 0 
    skipping pathway  565  k1= 0 
    skipping pathway  566  k1= 1 
    pathway  567 > sig: 0.04544688 
    pathway  568 > sig: 0.1997643 
    skipping pathway  569  k1= 0 
    pathway  570 > sig: 0.03013308 
    skipping pathway  571  k1= 1 
    pathway  572 > sig: 0.04377086 
    skipping pathway  573  k1= 1 
    skipping pathway  574  k1= 0 
    skipping pathway  575  k1= 0 
    skipping pathway  576  k1= 0 
    skipping pathway  577  k1= 0 
    pathway  578 > sig: 0.1455693 
    skipping pathway  579  k1= 1 
    skipping pathway  580  k1= 0 
    skipping pathway  581  k1= 2 
    skipping pathway  582  k1= 0 
    skipping pathway  583  k1= 0 
    skipping pathway  584  k1= 0 
    skipping pathway  585  k1= 0 
    skipping pathway  586  k1= 0 
    pathway  587 > sig: 0.1726317 
    skipping pathway  588  k1= 1 
    skipping pathway  589  k1= 0 
    pathway  590 > sig: 0.136308 
    skipping pathway  591  k1= 0 
    pathway  592 > sig: 0.08419837 
    pathway  593 > sig: 0.1315173 
    skipping pathway  594  k1= 0 
    skipping pathway  595  k1= 1 
    skipping pathway  596  k1= 0 
    skipping pathway  597  k1= 0 
    skipping pathway  598  k1= 1 
    skipping pathway  599  k1= 2 
    pathway  600 > sig: 0.05091859 
    pathway  601 > sig: 0.03541784 
    skipping pathway  602  k1= 2 
    skipping pathway  603  k1= 0 
    skipping pathway  604  k1= 0 
    skipping pathway  605  k1= 1 
    skipping pathway  606  k1= 1 
    pathway  607 > sig: 0.1107059 
    pathway  608 > sig: 0.05623814 
    skipping pathway  609  k1= 0 
    skipping pathway  610  k1= 1 
    skipping pathway  611  k1= 0 
    skipping pathway  612  k1= 0 
    skipping pathway  613  k1= 0 
    skipping pathway  614  k1= 1 
    skipping pathway  615  k1= 0 
    skipping pathway  616  k1= 2 
    skipping pathway  617  k1= 1 
    skipping pathway  618  k1= 1 
    skipping pathway  619  k1= 2 
    pathway  620 > sig: 0.002360554 
    skipping pathway  621  k1= 2 
    skipping pathway  622  k1= 0 
    skipping pathway  623  k1= 2 
    skipping pathway  624  k1= 0 
    skipping pathway  625  k1= 0 
    skipping pathway  626  k1= 0 
    skipping pathway  627  k1= 0 
    skipping pathway  628  k1= 0 
    pathway  629 > sig: 0.133122 
    pathway  630 > sig: 0.1183521 
    skipping pathway  631  k1= 0 
    skipping pathway  632  k1= 0 
    skipping pathway  633  k1= 0 
    skipping pathway  634  k1= 1 
    pathway  635 > sig: 0.08824071 
    pathway  636 > sig: 0.04544688 
    pathway  637 > sig: 0.04544688 
    pathway  638 > sig: 0.02589381 
    skipping pathway  639  k1= 0 
    pathway  640 > sig: 0.01959031 
    skipping pathway  641  k1= 0 
    skipping pathway  642  k1= 2 
    pathway  643 > sig: 0.1117159 
    skipping pathway  644  k1= 0 
    skipping pathway  645  k1= 0 
    skipping pathway  646  k1= 2 
    skipping pathway  647  k1= 0 
    pathway  648 > sig: 0.2221522 
    pathway  649 > sig: 0.1721073 
    skipping pathway  650  k1= 2 
    pathway  651 > sig: 0.1046928 
    skipping pathway  652  k1= 1 
    pathway  653 > sig: 0.1183521 
    pathway  654 > sig: 0.133122 
    pathway  655 > sig: 0.133122 
    pathway  656 > sig: 0.06000226 
    pathway  657 > sig: 0.06000226 
    pathway  658 > sig: 0.133122 
    pathway  659 > sig: 0.08012956 
    skipping pathway  660  k1= 0 
    skipping pathway  661  k1= 0 
    skipping pathway  662  k1= 1 
    skipping pathway  663  k1= 0 
    skipping pathway  664  k1= 0 
    skipping pathway  665  k1= 0 
    skipping pathway  666  k1= 0 
    skipping pathway  667  k1= 0 
    skipping pathway  668  k1= 0 
    skipping pathway  669  k1= 0 
    skipping pathway  670  k1= 0 
    skipping pathway  671  k1= 1 
    skipping pathway  672  k1= 0 
    skipping pathway  673  k1= 0 
    skipping pathway  674  k1= 0 
    skipping pathway  675  k1= 0 
    skipping pathway  676  k1= 1 
    skipping pathway  677  k1= 0 
    skipping pathway  678  k1= 0 
    skipping pathway  679  k1= 0 
    skipping pathway  680  k1= 0 
    skipping pathway  681  k1= 0 
    skipping pathway  682  k1= 2 
    skipping pathway  683  k1= 0 
    skipping pathway  684  k1= 0 
    pathway  685 > sig: 0.1502423 
    skipping pathway  686  k1= 2 
    skipping pathway  687  k1= 0 
    skipping pathway  688  k1= 1 
    skipping pathway  689  k1= 0 
    skipping pathway  690  k1= 0 
    skipping pathway  691  k1= 2 
    pathway  692 > sig: 0.1455693 
    pathway  693 > sig: 0.04125354 
    skipping pathway  694  k1= 2 
    skipping pathway  695  k1= 0 
    pathway  696 > sig: 0.04121526 
    skipping pathway  697  k1= 1 
    pathway  698 > sig: 0.02041865 
    skipping pathway  699  k1= 0 
    skipping pathway  700  k1= 1 
    skipping pathway  701  k1= 0 
    skipping pathway  702  k1= 0 
    pathway  703 > sig: 0.05313224 
    skipping pathway  704  k1= 0 
    skipping pathway  705  k1= 1 
    skipping pathway  706  k1= 1 
    pathway  707 > sig: 0.04121526 
    skipping pathway  708  k1= 2 
    pathway  709 > sig: 0.04121526 
    skipping pathway  710  k1= 0 
    skipping pathway  711  k1= 2 
    skipping pathway  712  k1= 0 
    pathway  713 > sig: 0.1455693 
    skipping pathway  714  k1= 2 
    pathway  715 > sig: 0.08931532 
    skipping pathway  716  k1= 0 
    skipping pathway  717  k1= 0 
    skipping pathway  718  k1= 1 
    skipping pathway  719  k1= 0 
    pathway  720 > sig: 0.0979923 
    skipping pathway  721  k1= 2 
    pathway  722 > sig: 0.0283346 
    pathway  723 > sig: 0.01060128 
    skipping pathway  724  k1= 0 
    pathway  725 > sig: 0.1455693 
    pathway  726 > sig: 0.231045 
    skipping pathway  727  k1= 1 
    pathway  728 > sig: 0.09890103 
    skipping pathway  729  k1= 0 
    skipping pathway  730  k1= 0 
    skipping pathway  731  k1= 0 
    pathway  732 > sig: 0.04661419 
    skipping pathway  733  k1= 1 
    skipping pathway  734  k1= 1 
    skipping pathway  735  k1= 1 
    skipping pathway  736  k1= 1 
    skipping pathway  737  k1= 1 
    skipping pathway  738  k1= 0 
    skipping pathway  739  k1= 0 
    skipping pathway  740  k1= 0 
    skipping pathway  741  k1= 0 
    skipping pathway  742  k1= 0 
    skipping pathway  743  k1= 2 
    pathway  744 > sig: 0.04121526 
    pathway  745 > sig: 0.1455693 
    skipping pathway  746  k1= 0 
    skipping pathway  747  k1= 0 
    skipping pathway  748  k1= 0 
    skipping pathway  749  k1= 0 
    skipping pathway  750  k1= 0 
    skipping pathway  751  k1= 0 
    skipping pathway  752  k1= 2 
    pathway  753 > sig: 0.1455693 
    pathway  754 > sig: 0.174165 
    pathway  755 > sig: 0.1721073 
    skipping pathway  756  k1= 0 
    skipping pathway  757  k1= 1 
    skipping pathway  758  k1= 0 
    skipping pathway  759  k1= 1 
    skipping pathway  760  k1= 0 
    skipping pathway  761  k1= 0 
    skipping pathway  762  k1= 0 
    skipping pathway  763  k1= 0 
    skipping pathway  764  k1= 0 
    skipping pathway  765  k1= 0 
    skipping pathway  766  k1= 1 
    skipping pathway  767  k1= 0 
    skipping pathway  768  k1= 0 
    skipping pathway  769  k1= 0 
    skipping pathway  770  k1= 0 
    skipping pathway  771  k1= 0 
    pathway  772 > sig: 0.1502423 
    pathway  773 > sig: 0.09697324 
    skipping pathway  774  k1= 0 
    skipping pathway  775  k1= 1 
    skipping pathway  776  k1= 1 
    skipping pathway  777  k1= 1 
    pathway  778 > sig: 0.1107059 
    pathway  779 > sig: 0.1343056 
    skipping pathway  780  k1= 1 
    skipping pathway  781  k1= 0 
    skipping pathway  782  k1= 1 
    pathway  783 > sig: 0.05457046 
    pathway  784 > sig: 0.09276626 
    skipping pathway  785  k1= 2 
    skipping pathway  786  k1= 2 
    pathway  787 > sig: 0.1130218 
    pathway  788 > sig: 0.1130218 
    skipping pathway  789  k1= 1 
    skipping pathway  790  k1= 0 
    pathway  791 > sig: 0.03244248 
    pathway  792 > sig: 0.1997643 
    pathway  793 > sig: 0.1498467 
    skipping pathway  794  k1= 0 
    skipping pathway  795  k1= 1 
    pathway  796 > sig: 0.08635854 
    pathway  797 > sig: 0.01959031 
    skipping pathway  798  k1= 0 
    skipping pathway  799  k1= 0 
    skipping pathway  800  k1= 1 
    skipping pathway  801  k1= 0 
    skipping pathway  802  k1= 0 
    skipping pathway  803  k1= 0 
    skipping pathway  804  k1= 0 
    skipping pathway  805  k1= 0 
    skipping pathway  806  k1= 0 
    skipping pathway  807  k1= 1 
    skipping pathway  808  k1= 0 
    skipping pathway  809  k1= 0 
    skipping pathway  810  k1= 0 
    skipping pathway  811  k1= 0 
    skipping pathway  812  k1= 0 
    skipping pathway  813  k1= 0 
    skipping pathway  814  k1= 2 
    skipping pathway  815  k1= 2 
    skipping pathway  816  k1= 0 
    pathway  817 > sig: 0.09683696 
    skipping pathway  818  k1= 0 
    skipping pathway  819  k1= 0 
    skipping pathway  820  k1= 0 
    skipping pathway  821  k1= 2 
    pathway  822 > sig: 0.1721073 
    pathway  823 > sig: 0.1721073 
    pathway  824 > sig: 0.1721073 
    skipping pathway  825  k1= 0 
    pathway  826 > sig: 0.06287007 
    skipping pathway  827  k1= 2 
    244 pathways processed with start= by ranks 


### Using PDSfun, we generate a new matrix which has pathways as columns instead of metaboltes. 


```R
head(t(PDSmatrix))
dim(t(PDSmatrix))
```


<table>
<thead><tr><th></th><th scope=col>11-beta-hydroxylase Deficiency (CYP11B1)</th><th scope=col>17-alpha-hydroxylase Deficiency (CYP17)</th><th scope=col>2-Hydroxyglutric Aciduria (D And L Form)</th><th scope=col>2-ketoglutarate Dehydrogenase Complex Deficiency</th><th scope=col>2-Methyl-3-Hydroxybutryl CoA Dehydrogenase Deficiency</th><th scope=col>2-Oxocarboxylic Acid Metabolism</th><th scope=col>21-hydroxylase Deficiency (CYP21)</th><th scope=col>3-Hydroxy-3-Methylglutaryl-CoA Lyase Deficiency</th><th scope=col>3-hydroxyisobutyric Acid Dehydrogenase Deficiency</th><th scope=col>3-hydroxyisobutyric Aciduria</th><th scope=col>⋯</th><th scope=col>UMP Synthase Deiciency (Orotic Aciduria)</th><th scope=col>Urea Cycle</th><th scope=col>Ureidopropionase Deficiency</th><th scope=col>Valine, Leucine And Isoleucine Biosynthesis</th><th scope=col>Valine, Leucine And Isoleucine Degradation</th><th scope=col>Warburg Effect</th><th scope=col>Xanthine Dehydrogenase Deficiency (Xanthinuria)</th><th scope=col>Xanthinuria Type I</th><th scope=col>Xanthinuria Type II</th><th scope=col>Zellweger Syndrome</th></tr></thead>
<tbody>
	<tr><th scope=row>PN00506</th><td>0.18604990</td><td>0.18604990</td><td>0.5307182 </td><td>0.9016448 </td><td>0.4821535 </td><td>0.7479977 </td><td>0.18604990</td><td>0.4821535 </td><td>0.4821535 </td><td>0.4821535 </td><td>⋯         </td><td>0.0894873 </td><td>0.4797445 </td><td>0.5959985 </td><td>0.8175311 </td><td>0.4821535 </td><td>0.1967212 </td><td>0.5734638 </td><td>0.5734638 </td><td>0.5734638 </td><td>0.4484760 </td></tr>
	<tr><th scope=row>PN00032</th><td>0.03147437</td><td>0.03147437</td><td>0.5205342 </td><td>0.7380502 </td><td>0.5036445 </td><td>0.7889482 </td><td>0.03147437</td><td>0.5036445 </td><td>0.5036445 </td><td>0.5036445 </td><td>⋯         </td><td>0.0965794 </td><td>0.4304196 </td><td>0.6192351 </td><td>0.7418192 </td><td>0.5036445 </td><td>0.3166038 </td><td>0.5869790 </td><td>0.5869790 </td><td>0.5869790 </td><td>0.4125932 </td></tr>
	<tr><th scope=row>PN01613</th><td>0.39370329</td><td>0.39370329</td><td>0.5212707 </td><td>0.6839063 </td><td>0.5526229 </td><td>0.6860112 </td><td>0.39370329</td><td>0.5526229 </td><td>0.5526229 </td><td>0.5526229 </td><td>⋯         </td><td>0.1583071 </td><td>0.4320307 </td><td>0.5888967 </td><td>0.3368568 </td><td>0.5526229 </td><td>0.1669025 </td><td>0.5923808 </td><td>0.5923808 </td><td>0.5923808 </td><td>0.3732709 </td></tr>
	<tr><th scope=row>PN00516</th><td>0.03694981</td><td>0.03694981</td><td>0.5407725 </td><td>0.7137784 </td><td>0.7243157 </td><td>0.8786079 </td><td>0.03694981</td><td>0.7243157 </td><td>0.7243157 </td><td>0.7243157 </td><td>⋯         </td><td>0.2128603 </td><td>0.4537374 </td><td>0.6026904 </td><td>0.5273254 </td><td>0.7243157 </td><td>0.2161873 </td><td>0.6425271 </td><td>0.6425271 </td><td>0.6425271 </td><td>0.4453892 </td></tr>
	<tr><th scope=row>PN00528</th><td>0.01004077</td><td>0.01004077</td><td>0.5802856 </td><td>0.9236094 </td><td>0.9189218 </td><td>0.7693278 </td><td>0.01004077</td><td>0.9189218 </td><td>0.9189218 </td><td>0.9189218 </td><td>⋯         </td><td>0.2251109 </td><td>0.4818920 </td><td>0.6448436 </td><td>0.8207792 </td><td>0.9189218 </td><td>0.2507748 </td><td>0.6598735 </td><td>0.6598735 </td><td>0.6598735 </td><td>0.4318620 </td></tr>
	<tr><th scope=row>PN00746</th><td>0.13845402</td><td>0.13845402</td><td>0.5485456 </td><td>0.7203340 </td><td>0.6474588 </td><td>0.7835988 </td><td>0.13845402</td><td>0.6474588 </td><td>0.6474588 </td><td>0.6474588 </td><td>⋯         </td><td>0.1792055 </td><td>0.4460532 </td><td>0.5991568 </td><td>0.4610154 </td><td>0.6474588 </td><td>0.1922873 </td><td>0.6072885 </td><td>0.6072885 </td><td>0.6072885 </td><td>0.5228511 </td></tr>
</tbody>
</table>




<ol class=list-inline>
	<li>207</li>
	<li>244</li>
</ol>



## IV- Select the most signficant pathway related to phenotype.
### We used two methods for pathway selection which are implemented in Weka package:
https://cran.r-project.org/web/packages/RWeka/RWeka.pdf

* information gain ('info') and 
* gain ratio ('gain')

### If you did not get any selected pathwys, you can lower the threshold below 0.5


```R
selected_Pathways_Weka= featuresSelection(PDSmatrix,threshold=0.5,method="info")
selected_Pathways_Weka
```


<ol class=list-inline>
	<li>'Adenine Phosphoribosyltransferase Deficiency (APRT)'</li>
	<li>'Adenosine Deaminase Deficiency'</li>
	<li>'Adenylosuccinate Lyase Deficiency'</li>
	<li>'AICA-Ribosiduria'</li>
	<li>'Alanine, Aspartate And Glutamate Metabolism'</li>
	<li>'Aminoacyl-tRNA Biosynthesis'</li>
	<li>'Ammonia Recycling'</li>
	<li>'Aspartate Metabolism'</li>
	<li>'Azathioprine Action Pathway'</li>
	<li>'Canavan Disease'</li>
	<li>'Gout Or Kelley-Seegmiller Syndrome'</li>
	<li>'Hypoacetylaspartia'</li>
	<li>'Lesch-Nyhan Syndrome (LNS)'</li>
	<li>'Mercaptopurine Action Pathway'</li>
	<li>'Mitochondrial DNA Depletion Syndrome'</li>
	<li>'Molybdenium Cofactor Deficiency'</li>
	<li>'Myoadenylate Deaminase Deficiency'</li>
	<li>'Protein Digestion And Absorption'</li>
	<li>'Purine Nucleoside Phosphorylase Deficiency'</li>
	<li>'Thioguanine Action Pathway'</li>
	<li>'Xanthine Dehydrogenase Deficiency (Xanthinuria)'</li>
	<li>'Xanthinuria Type I'</li>
	<li>'Xanthinuria Type II'</li>
</ol>




![png](output_14_1.png)


## V- Classification and prediction 
### This function will randomly separate the PDS score matrix with only the selected pathways into training and testing sets. It will use seven widely used machine learning algorithms to build the classification model from the training set. It plots the pathway importance from each model and its accuracy (AUC, sensitivity, specificity). 


```R
machine_learning(PDSmatrix,selected_Pathways_Weka);
```


![png](output_16_0.png)



![png](output_16_1.png)



![png](output_16_2.png)



![png](output_16_3.png)



![png](output_16_4.png)



![png](output_16_5.png)



![png](output_16_6.png)



![png](output_16_7.png)



![png](output_16_8.png)



![png](output_16_9.png)

