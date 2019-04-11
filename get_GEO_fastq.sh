#!/bin/bash

# !! DEPENDS ON: SRR Tools (fastq-dump) !!

#########################################################################################
#    Code to download fastq files for all sampels in a list of SRR accession numbers    #
#########################################################################################

# Define usage message
usage()
{
    echo "usage: get_GEO_fastq.sh [[[-f SRR_file] [-o output_directory]] | [-h]]"
}

# Collect command line parameters
fastq_dir=
srr_filename=
  
while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           shift
                                srr_filename=$1
                                ;;
        -o | --out_dir )        shift
                                fastq_dir=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

# Check that the file is a provided
if [ ! -f ${srr_filename} ]; then
    echo "SRR file not found!"
    exit 1
fi

# Download the fastq files
while read f
do
  echo "Downloading $f..."
  fastq-dump --outdir ${fastq_dir} --split-files --gzip --skip-technical ${f}
  echo "Done"
done < "$srr_filename"
