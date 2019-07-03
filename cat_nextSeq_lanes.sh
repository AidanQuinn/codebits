 #!/bin/bash

 # Collect command line argument
 SAMPLES_FILE=$1

 # Check that user provided samples file
 if [ -z $SAMPLES_FILE ]; then
     echo "Error: Please provide a valid samples file"
     exit 1
 fi

 # Read sample file path from command line
 if [ ! -f $SAMPLES_FILE ]; then
    echo "Error: $SAMPLES_FILE does not exist."
    exit 1
 fi

 # Read samples file and concatonate lanes
 while IFS= read -r SAMPLE || [[ -n "$SAMPLE" ]]; do
     cat */*${SAMPLE}*_R1_001.fastq.gz > ${SAMPLE}_R1.fastq.gz
     cat */*${SAMPLE}*_R2_001.fastq.gz > ${SAMPLE}_R2.fastq.gz
 done < $SAMPLES_FILE
