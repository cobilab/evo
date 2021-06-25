#!/bin/bash
#
WINDOW="$1";
LW="1";
ADDX=2;
#
idArray_names=("RaTG13" "RacCS203" "ZC45" "ZXC21" "PAN" "Tor2" "HKU3-1" "HKU" "NL63" "229E" "OC43" "MERS");
#
y=0;
for((x=1 ; x<=12 ; ++x, y+=$ADDX));
  do
  gto_relative_complexity_profile.sh --threads 1 --name REL_SIM --reference ${idArray_names[(($x-1))]}.fa --target SARS-CoV-2.fa --level " -rm 12:20:0:0:0.9/6:10:0.9 " --window $WINDOW
  #
  cat ${idArray_names[(($x-1))]}.fa-SARS-CoV-2.fa-REL_SIM.x | tr '.' ',' | awk -v a=$y '{sum=sprintf("%f",$2)}{printf "%u\t%.6f\n",$1,sum+a}' | tr ',' '.' > ${idArray_names[(($x-1))]}.fa-SARS-CoV-2.fa-REL_SIM.y 
  #
  if [[ "$x" == 12 ]]
    then
    names+=" \"${idArray_names[(($x-1))]}.fa-SARS-CoV-2.fa-REL_SIM.y\" using 1:2 with lines ls $x ";
    else
    names+=" \"${idArray_names[(($x-1))]}.fa-SARS-CoV-2.fa-REL_SIM.y\" using 1:2 with lines ls $x, ";
    fi
  done
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdana,9'
    set output "Profiles.pdf"
    set style line 101 lc rgb '#000000' lt 1 lw 4
    set border 3 front ls 101
    set tics nomirror out scale 0.5
    set format '%g'
    set size ratio 0.35
    set key out horiz center top
    set yrange [0:30.5] 
    set xrange [-50:]
    set xtics auto
    set ytics auto
    unset ytics
    set grid 
    unset ylabel
    set xlabel "Length"
    set border linewidth 1.5 
    set style line 1 lc rgb '#0060ad' lt 1 lw $LW pt 5 ps 0.4 # --- blue
    set style line 2 lc rgb '#708090' lt 1 lw $LW pt 6 ps 0.4 # --- grey
    set style line 3 lc rgb '#FF8C00' lt 1 lw $LW pt 6 ps 0.4 # --- orange
    set style line 4 lc rgb '#CC0066' lt 1 lw $LW pt 6 ps 0.4 # --- pink
    set style line 5 lc rgb '#FF0000' lt 1 lw $LW pt 6 ps 0.4 # --- green
    set style line 6 lc rgb '#a50000' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 7 lc rgb '#200080' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 8 lc rgb '#996515' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 9 lc rgb '#800080' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 10 lc rgb '#013580' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 11 lc rgb '#afb3f7' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 12 lc rgb '#6ac500' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 13 lc rgb '#9b0ffa' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 14 lc rgb '#9b3d7e' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 15 lc rgb '#1e9361' lt 1 lw $LW pt 6 ps 0.4 # --- 
    set style line 16 lc rgb '#e99361' lt 1 lw $LW pt 6 ps 0.4 # --- 
    plot $names
EOF

