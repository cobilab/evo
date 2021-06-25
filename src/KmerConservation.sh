#!/bin/bash
#
# ./KmerConservation.sh FIL_SDB.fasta REF.fa 12
#
SDB="$1";
REF="$2";
KMER_LEN="$3";
#
# ==============================================================================
#
gto_fasta_split_reads < $1 2>> tmp_info;
FILE_NUMBER=`tail -n 1 tmp_info | awk '{ print $1;}'`;
REF_LENGTH=`grep -v ">" $REF | tr -d -c "ACGT" | gto_info | grep "Number of symbols" | awk '{ print $5;}'`;
#echo "Found $FILE_NUMBER reads";
#
rm -f SEQS.seq;
for((x=1 ; x<= $FILE_NUMBER ; ++x));
  do
  grep -v ">" out$x.fasta | tr -d -c "ACGT" >> SEQS.seq
  printf "\n" >> SEQS.seq
  done
#
REF_LENGTH_LK=$((REF_LENGTH-KMER_LEN));
#
for(( x=0 ; x<= $REF_LENGTH_LK ; ++x ));
  do
  #
  POS_K=`echo "$x+$KMER_LEN" | bc -l`;
  KMER=`gto_fasta_extract -i $x -e $POS_K < $REF`;
  #
  printf "%s\t%u\t%u\t" "$KMER" "$x" "$POS_K";
  #
  SUM=`grep "$KMER" SEQS.seq | wc -l`
  #
  UNIQUE=`echo "$FILE_NUMBER-$SUM" | bc -l`;
  #
  printf "%u\t%u\t%u\n" "$UNIQUE" "$SUM" "$FILE_NUMBER";
  #
  done	  
#
# ==============================================================================
