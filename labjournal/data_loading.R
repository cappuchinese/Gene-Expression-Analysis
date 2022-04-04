# Script for loading the data and writing it to a table


## Function for reading in files to one dataset
read_sample <- function(file.name) {
  ## Extract the sample name for naming the column
  sample.name <- strsplit(file.name, ".", fixed = TRUE)
  sample.subject <- strsplit(sample.name[[1]][1], "_", fixed=TRUE)[[1]][2]
  colname <- paste0(sample.subject, "_", sample.name[[1]][2])
  ## Read the data, setting the 'Gene' as row.names (column 1)
  sample <- read.table(paste0("./Data/", file.name), sep="\t", row.names=NULL, header=TRUE,
                       col.names=c("Gene", colname))
  ## Return a subset containing the 'Gene' and sample name columns
  return(sample[c(1, 2)])
}

## Get the filenames of the data (NOTE: Change the path to the data folder)
file.names <- list.files("./Data")

## Read the FIRST sample
dataset <- read_sample(file.names[1])

## Read the rest of the sample group
for (file.name in file.names[2:48]) {
  sample <- read_sample(file.name)
  dataset <- merge(dataset, sample, by = 1)
}

## Exporting completed dataset to a file
write.table(dataset, file="./gene_count.txt", sep="\t", row.names=FALSE,
            col.names=TRUE, quote=FALSE)

## Now the dataset is ready to use
