#!/bin/bash
##################################################################################
# fastq_extract_id 
# Script to find and extract reads from fastq files with 
##################################################################################
# Define help function
helpFunction()
{
   echo ""
   echo "Usage: $0 -f fastq_file -i index_seq -n num_miss_match"
   echo -e "\t-f Path to fastq file"
   echo -e "\t-i Sequence of index"
   echo -e "\t-n number of missmatches to tolerate (must be 0 or 1)"
   echo ""
   exit 1 # Exit script after printing help
}
##################################################################################

##################################################################################
# Collect command line parameters and check that they're correct
while getopts "f:i:n:" opt
do
   case "$opt" in
      f ) fastq_file="$OPTARG" ;;
      i ) index_seq="$OPTARG" ;;
      n ) n_missmatch="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case required parameters are empty
if [ -z "$fastq_file" ] || [ -z "$index_seq" ] || [ -z "$n_missmatch" ]
then
   echo ""
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Check that n_missmatch is 0 or 1
n_req='^[0-1]+$'
if ! [[ $n_missmatch =~ $n_req ]] ; then
  echo "error: -n must be 0 or 1. No support for other levels of missmatches." >&2; exit 1
fi
##################################################################################

##################################################################################
# Define the main functions

# Tollerate Missmatch
withMissMatch(){
   #echo "Running withMissMatch"
   # Make pattern vector
   pattern=($index_seq)
   for((i=0; i<${#pattern[0]}; i++)); do
      pattern+=( "^@.*${pattern[0]:0:i}.${pattern[0]:i+1}$" )
   done
   pattern[0]="^@.*${index_seq}"
   regex=$(IFS='|'; echo "${pattern[*]}")
   awk -v regex="$regex" '$0 ~ regex {x=NR+3}(NR<=x){print}' ${fastq_file}
   #echo "$regex"
   
}

##################################################################################

# Only perfect match
noMissMatch(){
   #echo "running noMissMatch"
   regex="^\@.*${index_seq}$"
   #echo $regex
   awk -v regex="$regex" '$0 ~ regex {x=NR+3}(NR<=x){print}' ${fastq_file}
   #grep -A 3 ${regex} ${fastq_file} | grep -v "^\--$"
}

##################################################################################

##################################################################################
# Call script in case all parameters are correct
if [[ $n_missmatch = 1 ]]
then
  withMissMatch
else
  noMissMatch
fi
##################################################################################

