#!/bin/bash
#
# ==============================================================================
#
function RUN_NCD (){
  #
  grep -v ">" $1 | tr -d -c "ACGT" > $1.seq
  grep -v ">" $2 | tr -d -c "ACGT" > $2.seq
  cat $1 $2 > $1-$2.seq
  #
  PARAM_C=" -tm 13:20:1:0:0.95/5:1:0.95 -tm 3:1:0:0:0.8/0:0:0 ";
  PARAM_CAB=" -tm 13:100:1:0:0.95/5:10:0.95 -tm 3:1:0:0:0.8/0:0:0 ";
  #
  (GeCo3 -v $PARAM_C $1.seq) &> REPORT_$1
  (GeCo3 -v $PARAM_C $2.seq) &> REPORT_$2
  (GeCo3 -v $PARAM_CAB $1-$2.seq) &> REPORT_$1-$2
  #
  Cx=`cat  REPORT_$1 | grep "Total bytes" | awk '{print $3;}'`;
  Cy=`cat  REPORT_$2 | grep "Total bytes" | awk '{print $3;}'`;
  Cxy=`cat REPORT_$1-$2 | grep "Total bytes" | awk '{print $3;}'`;
  #
  if [[ "$Cx" < "$Cy" ]];
    then 
    NCD=`echo "scale=8;($Cxy-$Cx)/$Cy" | bc -l | sed -e 's/^\./0./;s/[0]*$//g'`
    else 
    NCD=`echo "scale=8;($Cxy-$Cy)/$Cx" | bc -l | sed -e 's/^\./0./;s/[0]*$//g'`
  fi
  #
  printf "%s\t" "$NCD";
  #
  }
#
# ==============================================================================
#
grep ">" CORONAS.fa | awk '{ print $1;}' | tr -d ">" > IDS-NCD.LIST.txt
#
mapfile -t IDS < IDS-NCD.LIST.txt
#
for ID in "${IDS[@]}" #
  do
  gto_fasta_extract_read_by_pattern -p "$ID" < $2 > TMP-$ID.fa;
  RUN_NCD "$1" "TMP-$ID.fa" 
  printf "%s\n" "$ID";
done
#
# ==============================================================================
