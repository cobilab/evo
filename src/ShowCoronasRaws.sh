#!/bin/bash
#
# ./ShowCoronasRaws.sh 12 
#
idArray_names=("SARS-CoV-2" "RaTG13" "RacCS203" "ZC45" "ZXC21" "PAN" "Tor2" "HKU3-1" "HKU" "NL63" "229E" "OC43" "MERS");
idArray_ids=("NC_045512" "MN996532.1" "MW251308.1" "MG772933.1" "MG772934.1" "MT040334.1" "NC_004718.3" "DQ022305.2" "NC_006577.2" "NC_005831.2" "NC_002645.1" "NC_006213.1" "NC_019843.3");
#
for((x=1; x<=13 ; ++x)); 
  do 
  echo "# ${idArray_ids[(($x-1))]} ${idArray_names[(($x-1))]}"; 
  cat CORONAS.fa-R$x-k$1.eg ; 
  echo "";
  done
#
