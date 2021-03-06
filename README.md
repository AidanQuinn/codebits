# codebits
Snippets of code useful in bioinformatics that I wrote or have collected from around the web. Mostly R but some shell scripts are here too.

---
1. DINOF.R (Data Interpolating Empirical Orthogonal Functions)

    This is R code to inpute missing values from a matrix. The code is based on [Beckers and Rixen, 2003](https://journals.ametsoc.org/doi/abs/10.1175/1520-0426%282003%29020%3C1839%3AECADFF%3E2.0.CO%3B2). DINEOF is a procedure fills gaps by iteratively decomposing the data field via Singular Value Decomposition (SVD) until a best solution is found as compared to a subset of reference values (non-gaps). This is done by progressively including more EOFs in the reconstruction of the gappy locations until minimization of error converges. Original post and implimentation by Me Nugget [@Rbloggers](https://menugget.blogspot.com/2012/10/dineof-data-interpolating-empirical.html#more).


2. UCSC_format-bedGraph.sh

    Quick script which takes as input a bedGraph file that may contain extra chromosome information and creates a copy with only the 'standard' UCSC chromosomes. Works for human or mouse (any genome version).


3. replot_gsea.R

     Script by Thomas Kuilman to replot a gene set enrichment analysis (GSEA) plot using the original gsea output. Makes a pretty pdf that can be modified in illustrator/Gimp.

4. counts_to_TPM.R

    Convert raw counts (e.g. from featureCounts) to transcripts per million (TPM)

5. matrix_to_GCT.R
    
    R function which writes (or converts and returns for testing) a gene expression matrix in a GCT format for use in GenePattern or GSEA analysis. Gene expression matrix should have rows and columns labled, though it's not required. 

6. sortFastq.sh

    One liner used to sort fastq files by name.

7. fastq_from_GSM.sh
    
    Download fastq files from GEO using a list of GSM identifiers.
    
8. plot_google_scholar.r
    
    Script used to generate Google Scholar Citations plot (http://aidanquinn.net/publications.html)
    
9. get_GEO_fastq.sh

    Retrieve fastq files in gz format (splitting PE reads into 2 files) from GEO. Usage: get_GEO_fastq.sh [[[-f SRR_file] [-o output_directory]] | [-h]], where SRR_file is a text file with one SRR sample number per line (accession list downloaded from GEO)

10. cat_nextSeq_lanes.sh
    
    Provided a file with sample IDs (one on each line), this script will search the current directory for nextSeq fastq files and concatonate all 4 lanes corresponding to each sample into a single file (per read).

11. fastq_extract_id.sh
    
    Finds and extracts reads with barcode specified on the command line. Can tolerate up to 1 mismatch in the barcode ID sequence.
