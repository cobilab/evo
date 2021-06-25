#!/bin/bash
#
rm -f CORONAS.fa
#
idArray=("NC_045512" "MN996532.1" "MW251308.1" "MG772933.1" "MG772934.1 " "MT040334.1" "NC_004718.3" "DQ022305.2" "NC_006577.2" "NC_005831.2" "NC_002645.1" "NC_006213.1" "NC_019843.3"); 
#
# NC_045512.2     # SARS-CoV-2    2020 The “Wuhan-1” SARS-CoV-2 reference genome
# MN996532.1      # RaTG13        2020 Bat coronavirus
# MW251308.1      # RacCS203      2021 Bat coronavirus
# MG772933.1      # ZC45          2020 Bat SARS-like coronavirus
# MG772934.1      # ZXC21         2020 Bat SARS-like coronavirus
# MT040334.1      # PAN           2020 Pangolin coronavirus
# NC_004718.3     # Tor2          2020 SARS-CoV, collected in Toronto c.a. 2003
# DQ022305.2      # HKU3-1        2005 a cold-causing coronavirus
# NC_006577.2     # HKU
# NC_005831.2     # NL63
# NC_002645.1     # 229E
# NC_006213.1     # OC43
# NC_019843.3     # MERS
#
for id in ${idArray[@]}; do
  echo "Downloading $id ...";
  efetch -db nucleotide -format fasta -id "$id" >> CORONAS.fa;
done
#
