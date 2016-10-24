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

## Add geocoded variable for addresses
refine$full_address <- paste(refine$address, refine$city, refine$country, sep=",")

## Create dummy vars for company and product

create_dummy <- function(vec, value){
  return(as.integer(vec == value))
}

company_names <- as.character(unique(refine$company))

for(company in company_names){
  new_var_name <- paste0('company_',company)
  refine[[new_var_name]] <- create_dummy(refine$company, company)
}

product_names <- as.character(unique(refine$product_category))

for(product in product_names){
  new_var_name <- paste0('product_',product)
  refine[[new_var_name]] <- create_dummy(refine$product_category, product)
}

## Submit to github

write.csv(refine, "refine_clean.csv")

                               
                        