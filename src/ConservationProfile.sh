#!/bin/bash
#
FIL_DROP=0;
W1=100;
W2=800;
W3=4000;
#W1=80;
#W2=400;
#W3=2000;
#
cat $1 \
| awk '{ print $2"\t"$4;}' \
| gto_filter -w $W1 -t $2 -d $FIL_DROP > .conservationFiltered.txt
#
cat $1 \
| awk '{ print $2"\t"$4;}' \
| gto_filter -w $W2 -t $2 -d $FIL_DROP > .conservationFiltered2.txt
#
cat $1 \
| awk '{ print $2"\t"$4;}' \
| gto_filter -w $W3 -t $2 -d $FIL_DROP > .conservationFiltered3.txt
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ConservationProfiles.pdf"
    set style line 101 lc rgb '#000000' lt 1 lw 4
    set border 3 front ls 101
    set tics nomirror out scale 0.5
    set format '%g'
    set size ratio 0.15
    set key out horiz center top
    #set yrange [:]
    set yrange [128:32768]
    #set yrange [500:8000]
    set xrange [:]
    set xtics auto
    set ytics auto
    set logscale y 2
    set grid
    set ylabel "Conservation"
    set xlabel "Length"
    set border linewidth 1.5
    set style line 1 lc rgb '#322152' lt 1 lw 0.8 pt 5 ps 0.4 # --- blue
    set style line 2 lc rgb '#008000' lt 1 lw 2 pt 6 ps 0.4 # --- grey
    set style line 3 lc rgb '#B22222' lt 1 lw 2 pt 7 ps 0.4 # --- grey
    #set style points 4 lc rgb '#B22222' lt 1 lp 2 pt 7 ps 0.4 # --- grey
    #set style line 4 lc rgb '#B22222' lt 1 lw 2 pt 7 pi -1 ps 1.5
    set style line 4 lc rgb 'blueviolet' pt 7 ps 0.3   # triangle
    plot ".conservationFiltered.txt" using 1:2 title '  w=$W1' with lines ls 1, ".conservationFiltered2.txt" using 1:2 title '  w=$W2' with lines ls 2, ".conservationFiltered3.txt" using 1:2 title '  w=$W3' with lines ls 3, ".raws.txt" using 3:2 title '  raws' with points ls 4
EOF
#
