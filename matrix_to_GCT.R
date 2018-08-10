# Function to convert gene-expression matrix into GCT format

matrix_to_GCT <- function(M, file_name = "",
                          columns_named = T, rows_named = T, descriptions = NULL){
  # Get vector of gene names
  if(rows_named == T ){
    genes = rownames(M)
  } else {
    cat("Using column 1 as gene names...\n")
    genes = M[,1]
    M = M[,-1]
  }
  # Get vector of column names
  if(columns_named == T ){
    samples = colnames(M)
  } else {
    cat("Using row 1 as sample names...\n")
    samples = M[1,]
    M = M[-1,]
  }
  
  # Get dimensions of matrix
  n = nrow(M)
  i = ncol(M)
  
  # Make vector of descriptions if not provided
  if(is.null(descriptions)){
    cat("Using dummy value for description")
    descriptions <- rep(".", n)
  }
  
  # Make file
  first = c("#1.2", rep("", i+1))
  seccond = c(n, i, rep("", i))
  third = c("NAME", "description", samples)
  
  M = cbind.data.frame(genes, descriptions, M)
  
  gct <- rbind(
    first, seccond, third, as.matrix(M)
  )
  
  # write or return
  if(file_name == ""){
    return(gct)
  } else {
    write.table(
      gct, file = file_name,
      row.names = F, col.names = F,
      quote = F, sep = "\t")
  }
}

