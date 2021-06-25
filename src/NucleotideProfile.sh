#!/bin/bash
#
FIL_DROP=0; # if you change this the date labels won't work!
W1=1;
W2=1000;
headsize=10000;
#
awk '{ print $6;}' < $1 > .Nuc$5Date.txt;
#
cat $1 \
| awk '{ print $1"\t"$'$6';}' \
| gto_filter -w $W1 -t $2 -d $FIL_DROP > .tmpNuc$5Filtered.txt
paste .tmpNuc$5Filtered.txt .Nuc$5Date.txt \
| awk '{print $1"\t"$2"\t"$3}' > .Nuc$5Filtered.txt 
#
cat $1 \
| awk '{ print $1"\t"$'$6';}' \
| gto_filter -w $W2 -t $2 -d $FIL_DROP > .tmpNuc$5Filtered2.txt
paste .tmpNuc$5Filtered2.txt .Nuc$5Date.txt \
| awk '{print $1"\t"$2"\t"$3}' > .Nuc$5Filtered2.txt 
#
AVG=`head -n $headsize .Nuc$5Filtered2.txt \
| LC_NUMERIC="C" awk '{sum += $2} END {print sum / NR}'`;
SIZE=`wc -l .Nuc$5Filtered.txt | awk '{ print $1;}'`;
#
rm -f .Avg$5Profile.txt;
#
for (( x=1 ; x <= $SIZE ; ++x ))
  do 
  printf "%u\t%s\n" "$x" "$AVG" >> .Avg$5Profile.txt;
  done
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Nucleotide$5Profile.pdf"
    set style line 101 lc rgb '#000000' lt 1 lw 4
    set border 3 front ls 101
    set tics nomirror out scale 0.5
    set format '%g'
    set size ratio 0.22
    set key out horiz center top
    set yrange [$3:$4]
    #set yrange [:]
    set xrange [:]
    set xtics auto
    set ytics auto
    set ytics 0.04
    unset grid
    set ylabel "Base $5 (%)"
    set xlabel "Time"
    set border linewidth 1.5
    #set style line 1 lc rgb '#003366' lt 1 lw 1 pt 5 ps 0.4 # --- blue
    set style line 1 lc rgb '#322152' lt 1 lw 1 pt 5 ps 0.4 # --- blue
    #set style line 1 lc rgb '#A0A0A0' lt 1 lw 1 pt 5 ps 0.4 # --- blue
    set style line 3 lc rgb '#009900' lt 1 lw 2.4 pt 6 ps 0.4 # --- green
    set style line 2 lc rgb '#CC0000' lt 1 lw 2 pt 7 ps 0.4 # --- red
    set xtics border in scale 0,0 nomirror rotate by -55  autojustify
    set xtics  norangelimit  font ",8"
    nth(countCol,labelCol,n) = ((int(column(countCol)) % n == 2500) ? stringcolumn(labelCol) : "") 
    plot ".Nuc$5Filtered.txt" using 1:2:xtic(nth(1,3,3000)) title ' w=$W1' with lines ls 1, ".Avg$5Profile.txt" using 1:2 title '  Average of first $headsize bases' with lines ls 3, ".Nuc$5Filtered2.txt" using 1:2 title '  w=$W2' with lines ls 2
EOF
#
