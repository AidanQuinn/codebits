# Function to read in a specific column of RNA-seq count data
# and concatonate into a single count matrix.
#
# file_list should be a list of files in the current working directory
# which correspond to count data to be concatonated
#
# author: Aidan Quinn
# date:   2021-09-22

# Main funciton
read_cols_counts <- function(
  file_list, 
  col_n = 2, 
  row_names = TRUE,
  skip_rows = 0
  ){
  
  # Function to get each column
  get_col <- function(file_name){
    return(
      read.table(
        file_name, 
        sep = "\t", 
        skip = skip_rows)[,col_n])
  }
  
  # Get columns and format data frame
  counts <- lapply(file_list, get_col)
  names(counts) <- file_list
  counts <- do.call(cbind.data.frame, counts)
  
  # name rows if available
  if(row_names){
    row_names <- read.table(file_list[[1]], sep = "\t", skip = skip_rows)[,1]
    counts <- cbind.data.frame(row_names, counts)
  }
  
  return(counts)
  
}
