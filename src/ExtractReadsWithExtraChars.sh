#!/bin/bash
#
size=`gto_fasta_split_reads < SDB.fasta 2> tmp_pp; tail -n 1 tmp_pp | awk '{ print $1;}'`;
#
echo "Running $size sequences ...";
#
rm -f FIL_SDB.fasta;
#
for(( x=1 ; x<= $size ; ++x));
  do
  #
  cardinality=`grep -v ">" out$x.fasta | tr -d '\n' | gto_info | grep "Alphabet size" | awk '{ print $4;}'`;
  #
  if [[ "$cardinality" -eq "4" ]];
    then
    cat out$x.fasta >> FIL_SDB.fasta;
    #else
    #;
    #echo "Ignoring file out$x.fasta with cardinality: $cardinality";
    fi
  #
  rm -f out$x.fasta;
  #
  done
#
