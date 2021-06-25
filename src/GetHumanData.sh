#!/bin/bash
#
rm -f GRCh38.p13.genome.fa.gz gencode.v38.transcripts.fa.gz;
#
# Genome
wget http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/latest_release/GRCh38.p13.genome.fa.gz
gunzip GRCh38.p13.genome.fa.gz
#
# Transcripts
wget http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/latest_release/gencode.v38.transcripts.fa.gz
gunzip gencode.v38.transcripts.fa.gz
#
cat GRCh38.p13.genome.fa gencode.v38.transcripts.fa > HS.fa
#
