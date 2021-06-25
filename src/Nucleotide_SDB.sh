#!/bin/bash
#
# ./Nucleotide_SDB.sh FIL_SDB.fasta 
#
SDB="$1";
#
# ==============================================================================
#
function NUCLEOTIDE (){
  #
  grep -v ">" $1 | tr -d -c "ACGT" | gto_info > Report_tmp;
  #
  PER_A=`grep "A  :" Report_tmp | awk '{ print $4;}'`;
  PER_C=`grep "C  :" Report_tmp | awk '{ print $4;}'`;
  PER_G=`grep "G  :" Report_tmp | awk '{ print $4;}'`;
  PER_T=`grep "T  :" Report_tmp | awk '{ print $4;}'`;
  #
  printf "%s\t%s\t%s\t%s\t" "$PER_A" "$PER_C" "$PER_G" "$PER_T";
  printf "%s\t%s\t%s\t%s\t" "$PER_A" "$PER_C" "$PER_G" "$PER_T" >> Report_Perc_Nucleotide.txt;
  #
  }
#
# ==============================================================================
#
GSIZE=`gto_fasta_split_reads < $1 2> tmp_info; tail -n 1 tmp_info | awk '{ print $1;}'`;
#
idx=0;
rm -f Report_Perc_Nucleotide.txt
for(( x = 1 ; x <= $GSIZE ; ++x));
  do
  ((++idx));
  printf "%u\t" "$idx";
  printf "%u\t" "$idx" >> Report_Perc_Nucleotide.txt
  #
  NUCLEOTIDE "out$x.fasta"
  #
  DATE=`head -n 1 out$x.fasta | awk -F '|' '{ print $21;}'`;
  printf "%s\t%s\n" "$ID" "$DATE";
  printf "%s\t%s\n" "$ID" "$DATE" >> Report_Perc_Nucleotide.txt;
  done
#
# ==============================================================================
