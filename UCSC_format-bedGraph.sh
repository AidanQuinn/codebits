#!/bin/bash


# Quick script which takes as input a bedGraph file that may
# contain extra chromosome information and creates a copy with
# only the 'standard' UCSC chromosomes. Works for human or 
# mouse (any genome version).


printf "chr1\nchr2\nchr3\nchr4\nchr5\nchr6\nchr7\nchr8\nchr9\nchr10\nchr11\nchr12\nchr13\nchr14\nchr15\nchr16\nchr17\nchr18\nchr19\nchr20\nchr21\nchr22\nchrM\nchrX\nchrY" > ./UCSC_chromes.txt

in_bedGraph=$1
out_bedGraph=$2

grep -v '^chr' $in_bedGraph > $out_bedGraph
grep -f ./UCSC_chromes.txt $in_bedGraph >> $out_bedGraph

