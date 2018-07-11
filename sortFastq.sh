cat unsorted.fastq | paste - - - - | sort -k1,1 -t " " | tr "\t" "\n" > sorted.fastq
