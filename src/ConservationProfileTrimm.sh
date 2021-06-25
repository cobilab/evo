#!/bin/bash
#
FIL_DROP=0;
#
PIECE=$3;
LASTPIECE=`echo "29883-($PIECE*2)" | bc -l`; 
tail -n +$PIECE $1 | head -n +$LASTPIECE > $1_xtrimmed.txt; 
#
cat $1_xtrimmed.txt \
| awk '{ print $2"\t"$4;}' \
| gto_filter -w 4500 -t $2 -d $FIL_DROP > .conservationFiltered4.txt
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ConservationProfile.pdf"
    set style line 101 lc rgb '#000000' lt 1 lw 4
    set border 3 front ls 101
    set tics nomirror out scale 0.5
    set format '%g'
    set size ratio 0.15
    set key out horiz center top
    set yrange [:]
    #set yrange [500:6000]
    set xrange [:]
    set xtics auto
    set ytics auto
    #set logscale y 3
    set grid
    set ylabel "Conservation"
    set xlabel "Length"
    set border linewidth 1.5
    set style line 1 lc rgb '#008000' lt 1 lw 2 pt 6 ps 0.4 # --- grey
    plot ".conservationFiltered4.txt" using 1:2 title 'w=5000' with lines ls 1
EOF
#
