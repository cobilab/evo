#!/bin/bash
#
# ./FindException.sh ATCGTGTTGTGTG
#
gto_fasta_split_reads < FIL_SDB.fasta 2> tmp_c_info.txt;
nseqs=`tail -n 1 tmp_c_info.txt | awk '{ print $1;}'`;
kmer=${#1};
#
echo "Running $nseqs sequences for k=$kmer...";
#
sum=0;
rm -f Exceptions-$2.txt;
printf "RAW is NOT in: ";
for(( x=1 ; x<= $nseqs ; ++x));
  do
  #
  DIFF=`grep "$1" FIL_SDB.fasta-R$x-k$kmer.eg | wc -l`;
  #
  if [[ "$DIFF" -ne "1" ]];
    then
    echo "$x" >> Exceptions-$2.txt;
    printf "$x ";
    ((++sum));
    fi
  #
  done
printf "\n";
echo "Found $sum sequences without the $1 raw (out of $nseqs)";
rm -f tmp_c_info.txt;
#
