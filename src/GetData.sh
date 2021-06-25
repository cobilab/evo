#!/bin/bash
#
THREADS="1";
#
mapfile -t FILES < sequences.acc;
#
IDX_THR=1;
IDX_POS=1;
#
# DOWNLOAD DATA
#
for file in "${FILES[@]}" #
  do
  efetch -db nucleotide -format fasta -id "$file" | gzip -c > SEQ_$file.gz &
  if [[ "$IDX_THR" -eq "$THREADS" ]] || [[ "${#FILES[@]}" -eq "$IDX_POS" ]]
    then
    wait;
    IDX_THR=0;
    fi
  ((++IDX_THR));
  ((++IDX_POS));
  done
#
# JOIN DATA
#
rm -f DB.mfa;
for file in "${FILES[@]}" #
  do
  zcat SEQ_$file.gz >> DB.mfa; 
  done
#
