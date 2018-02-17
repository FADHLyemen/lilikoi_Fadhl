## Lilikoi is a novel tool for personalized pathway analysis of metabolomics data. 

## Prerequisites

To install all the required packages without overwriting your installed packages, you can run the below lines:

```
list.of.packages <- c("ggplot2", "caret","dplyr ","pathifier","RWeka","infotheo","pROC","reshape2")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
```
## Installation
```
devtools::install_github("FADHLyemen/lilikoi_Fadhl")
```

if you have problem with installing Rweka as it requirtes Java, you can reconfiguring R from the command line by runing the below line:

```
R CMD javareconf
```
# Built With
* Fadhl Alakwaa https://github.com/FADHLyemen
* Sijia Huang  https://github.com/scarlettcanny
# Example Code
https://github.com/FADHLyemen/lilikoi_Fadhl/blob/master/lilikoi_notebook_Plasma_BC.ipynb
