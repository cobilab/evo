#!/bin/bash
#
# use: ./gto2... SDB.fasta
#
size=`gto_fasta_split_reads < $1 2> tmp_pp; tail -n 1 tmp_pp | awk '{ print $1;}'`;
#
echo "Running $size sequences ...";
#
rm -f FIL_$1;
#
for(( x=1 ; x<= $size ; ++x));
  do
  #
  cardinality=`grep -v ">" out$x.fasta | tr -d '\n' | gto_info | grep "Alphabet size" | awk '{ print $4;}'`;
  #
  if [[ "$cardinality" -eq "4" ]];
    then
    cat out$x.fasta >> FIL_$1;
    fi
  #
  rm -f out$x.fasta;
  #
  done
#
