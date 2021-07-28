#!/bin/bash
#
# ./NCD_SDB.sh FIL_SDB.fasta CORONAS.fa
SDB="$1";
CORONAS="$2";
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
    NCD=`echo "scale=12;($Cxy-$Cx)/$Cy" | bc -l | sed -e 's/^\./0./;s/[0]*$//g'`
    else 
    NCD=`echo "scale=12;($Cxy-$Cy)/$Cx" | bc -l | sed -e 's/^\./0./;s/[0]*$//g'`
  fi
  #
  printf "%s\t" "$NCD";
  printf "%s\t" "$NCD" >> Report_NCD_$3.txt;
  #
  }
#
# ==============================================================================
#
grep ">" $CORONAS | awk '{ print $1;}' | tr -d ">" \
  | grep -v "NC_045512.2" > IDS-CORONAS.LIST.txt
grep ">" $SDB     | awk '{ print $1;}' | tr -d ">" > IDS-NCD-ALL.LIST.txt
#
mapfile -t COR < IDS-CORONAS.LIST.txt
mapfile -t IDS < IDS-NCD-ALL.LIST.txt
#
for CO in "${COR[@]}" #
  do
  idx=0;
  #  
  gto_fasta_extract_read_by_pattern -p "$CO" < $CORONAS > COR-$CO.fa;
  #
  rm -f Report_NCD_$CO.txt;
  #
  for ID in "${IDS[@]}" #
    do
    #
    ((++idx));
    printf "%u\t" "$idx";
    printf "%u\t" "$idx" >> Report_NCD_$CO.txt;
    #
    gto_fasta_extract_read_by_pattern -p "$ID" < $SDB > SDB-$ID.fa;
    #
    RUN_NCD "COR-$CO.fa" "SDB-$ID.fa" "$CO" 
    #
    DATE=`head -n 1 SDB-$ID.fa | awk -F '|' '{ print $21;}'`;
    printf "%s\t%s\n" "$ID" "$DATE";
    printf "%s\t%s\n" "$ID" "$DATE" >> Report_NCD_$CO.txt;
    done
  #
  done
#
# ==============================================================================
