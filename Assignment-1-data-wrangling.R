library(dplyr)
library(tidyr)
refine <- read.csv("refine.csv", header = TRUE, stringsAsFactors = FALSE)
names(refine)
str(refine)
## Change names so they match
refine$company <- gsub("P", "p", refine$company)
refine$company <- gsub("ll", "l", refine$company)
refine$company <- gsub("S", "s", refine$company)
refine$company <- gsub("f", "ph", refine$company)
refine$company <- gsub("hl", "hil", refine$company)
refine$company <- gsub("lp", "lip", refine$company)
refine$company <- tolower(refine$company)
refine$company <- gsub(" ", "", refine$company)
refine$company <- gsub("0", "o", refine$company)
refine$company <- gsub("nh", "n h", refine$company)

## Split product code into two cols
refine <- separate(refine, Product.code...number, into = c("product_code", "product_number"), sep="-")

## Add new variable based on product codes
look_up_table <- c('p' = 'Smartphone', 'v' = 'TV', 'x' = 'Laptop', 'q' = 'Tablet')
refine$product_category <- factor(look_up_table[refine$product_code])

                               
                        