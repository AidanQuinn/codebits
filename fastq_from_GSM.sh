#!/bin/sh
if ! type "efetch" > /dev/null; then
  print "Please install E-utilitie."
fi

GSM_LIST=$1
GSMs=`cat $GSM_LIST|cut -f1`
#echo $SRRs 
! type "foo" > /dev/null 2>&1;
for GSM in $GSMs; do
  echo $GSM retrieves from NCBI GEO.....
  SRR=`esearch -db sra -query $GSM |efetch -format docsum |xtract -pattern DocumentSummary -element Run@acc`
  fastq-dump -A $SRR -O sra_fastq
  echo fastq-dump done.....
done
