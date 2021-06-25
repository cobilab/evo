#!/bin/bash
#
# ./CreateFilDB.sh SDB.fasta
#
SDB="$1";
#
# ==============================================================================
#
GSIZE=`gto_fasta_split_reads < $1 2> tmp_s_info; tail -n 1 tmp_s_info \
	| awk '{ print $1;}'`;
#
rm -f FIL_SDB.fasta
#
IDX=0;
#
echo "Running $GSIZE sequences ...";
#
for(( x = 1 ; x <= $GSIZE ; ++x));
  do
  PATTERN=`grep ">" out$x.fasta | awk -F"|" '{ print $21;}' | grep "-" | wc -l`;
  if [[ "$PATTERN" -eq "1" ]];
    then
    XSYM=`grep -v ">" out$x.fasta | tr -d "\n" | gto_info | grep -e "A  :" -e "C  :" -e "G  :" -e "T  :"  | wc -l`;
    NSYM=`grep -v ">" out$x.fasta | tr -d "\n" | gto_info | grep "Alphabet size" | awk '{ print $4;}'`;
    if [[ "$XSYM" -eq "4" ]];
      then
      if [[ "$NSYM" -eq "4" ]];
        then 
        COMPLETE=`grep ">" out$x.fasta | awk -F"|" '{ print $13;}' | grep "complete" | wc -l`;
        if [[ "$COMPLETE" -eq "1" ]];
          then
          ((++IDX));
          echo "$IDX : Adding $x ...";
          cat out$x.fasta >> FIL_SDB.fasta;
          fi
        fi
      fi
    fi
  done
#
# ==============================================================================
