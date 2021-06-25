#!/bin/bash
#
SIZE=`grep ">" FIL_SDB.fasta | wc -l | awk '{ print $1;}'`;
#
rm -f .rawsProfileDate.txt;
for (( x=1 ; x <= $SIZE ; ++x ))
  do
  DATE=`grep ">" out$x.fasta | awk -F"|" '{ print $18;}'`;
  printf "%u\t%s\n" "$x" "$DATE" >> .rawsProfileDate.txt;
  done
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "RAWsProfile.pdf"
    set style line 101 lc rgb '#000000' lt 1 lw 4
    set border 3 front ls 101
    set tics nomirror out scale 0.5
    set format '%g'
    set size ratio 0.24
    set key out horiz center top
    set yrange [0:10]
    #set yrange [:]
    set xrange [:]
    set xtics auto
    set ytics auto
    set ytics 1
    unset grid
    set ylabel "RAW"
    set xlabel "Time"
    set border linewidth 1.5
    set style line 1 lc rgb '#990099'  pt 6 ps 0.2  # circle
    set style line 2 lc rgb '#004C99'  pt 6 ps 0.2  # circle
    set style line 3 lc rgb '#CCCC00'  pt 6 ps 0.2  # circle
    set style line 4 lc rgb '#4C0099'  pt 6 ps 0.2  # circle
    set style line 5 lc rgb '#009900'  pt 6 ps 0.2  # circle
    set style line 6 lc rgb '#990000'  pt 6 ps 0.2  # circle
    set style line 7 lc rgb '#009999'  pt 6 ps 0.2  # circle
    set style line 8 lc rgb '#99004C'  pt 6 ps 0.2  # circle
    set style line 9 lc rgb '#CC6600'  pt 6 ps 0.2  # circle
    set style line 10 lc rgb '#322152' pt 6 ps 0.2  # circle
    set xtics border in scale 0,0 nomirror rotate by -55  autojustify
    set xtics  norangelimit  font ",8"
    nth(countCol,labelCol,n) = ((int(column(countCol)) % n == 2500) ? stringcolumn(labelCol) : "") 
    plot ".rawsProfileDate.txt" using xtic(nth(1,2,3000)) with lines, "Exceptions-1.txt" using 2:3 title ' 1' with points ls 1, "Exceptions-2.txt" using 2:3 title '  2' with points ls 2, "Exceptions-3.txt" using 2:3 title '  3' with points ls 3, "Exceptions-4.txt" using 2:3 title '  4' with points ls 4, "Exceptions-5.txt" using 2:3 title '  5' with points ls 5, "Exceptions-6.txt" using 2:3 title '  6' with points ls 6, "Exceptions-7.txt" using 2:3 title '  7' with points ls 7, "Exceptions-8.txt" using 2:3 title '  8' with points ls 8, "Exceptions-9.txt" using 2:3 title '  9' with points ls 9, "Exceptions-10.txt" using 2:3 title '  S' with points ls 10 
EOF
#
