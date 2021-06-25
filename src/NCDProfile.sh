#!/bin/bash
#
FIL_DROP=0;
W1=1;
W2=1000;
W3=100;
headsize=10000;
#
cat $1 \
| awk '{ print $1"\t"$2;}' \
| gto_filter -w $W1 -t $2 -d $FIL_DROP > .NCDFiltered.txt
#
cat $1 \
| awk '{ print $1"\t"$2;}' \
| gto_filter -w $W2 -t $2 -d $FIL_DROP > .NCDFiltered2.txt
#
cat $1 \
| awk '{ print $1"\t"$2;}' \
| gto_filter -w $W3 -t $2 -d $FIL_DROP > .NCDFiltered3.txt
#
awk '{ print $1"\t"$4;}' < $1 > .NucDate.txt;
AVG=`head -n $headsize .NCDFiltered.txt \
| LC_NUMERIC="C" awk '{sum += $2} END {print sum / NR}'`;
SIZE=`wc -l .NCDFiltered.txt | awk '{ print $1;}'`;
#
rm -f .AvgNCDProfile.txt;
for (( x=1 ; x <= $SIZE ; ++x ))
  do
  printf "%u\t%s\n" "$x" "$AVG" >> .AvgNCDProfile.txt;
  done
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCDProfile$1.pdf"
    set style line 101 lc rgb '#000000' lt 1 lw 4
    set border 3 front ls 101
    set tics nomirror out scale 0.5
    set format '%g'
    set size ratio 0.22
    set key out horiz center top
    set yrange [$3:$4]
    set xrange [:]
    set xtics auto
    set ytics 0.004
    unset grid
    set ylabel "NCD"
    set xlabel "Time"
    set border linewidth 1.5
    set style line 1 lc rgb '#322152' lt 1 lw 1 pt 5 ps 0.4 # --- blue
    set style line 3 lc rgb '#009900' lt 1 lw 2.4 pt 6 ps 0.4 # --- green
    set style line 2 lc rgb '#CC0000' lt 1 lw 2 pt 7 ps 0.4 # --- red
    set xtics border in scale 0,0 nomirror rotate by -55  autojustify
    set xtics  norangelimit  font ",8"
    nth(countCol,labelCol,n) = ((int(column(countCol)) % n == 2500) ? stringcolumn(labelCol) : "")
    plot ".NucDate.txt" using xtic(nth(1,2,3000)) title ' w=$W1' with lines ls 1, ".NCDFiltered.txt" using 1:2 title '  w=$W1' with lines ls 1, ".AvgNCDProfile.txt" using 1:2 title '  Average of first $headsize bases' with lines ls 3, ".NCDFiltered2.txt" using 1:2 title '  w=$W2' with lines ls 2 #, ".NCDFiltered3.txt" using 1:2 title '  w=$W3' with lines ls 3,
EOF
#
