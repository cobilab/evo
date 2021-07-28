#!/bin/bash
#
gto_fasta_extract_read_by_pattern -p "NC_045512.2" < CORONAS.fa > SARS-CoV-2.fa
gto_fasta_extract_read_by_pattern -p "MN996532.1"  < CORONAS.fa > RaTG13.fa
gto_fasta_extract_read_by_pattern -p "MW251308.1"  < CORONAS.fa > RacCS203.fa
gto_fasta_extract_read_by_pattern -p "MG772933.1"  < CORONAS.fa > ZC45.fa
gto_fasta_extract_read_by_pattern -p "MG772934.1"  < CORONAS.fa > ZXC21.fa
gto_fasta_extract_read_by_pattern -p "MT040334.1"  < CORONAS.fa > PAN.fa
gto_fasta_extract_read_by_pattern -p "NC_004718.3" < CORONAS.fa > Tor2.fa
gto_fasta_extract_read_by_pattern -p "DQ022305.2"  < CORONAS.fa > HKU3-1.fa
gto_fasta_extract_read_by_pattern -p "NC_006577.2" < CORONAS.fa > HKU.fa
gto_fasta_extract_read_by_pattern -p "NC_005831.2" < CORONAS.fa > NL63.fa
gto_fasta_extract_read_by_pattern -p "NC_002645.1" < CORONAS.fa > 229E.fa
gto_fasta_extract_read_by_pattern -p "NC_006213.1" < CORONAS.fa > OC43.fa
gto_fasta_extract_read_by_pattern -p "NC_019843.3" < CORONAS.fa > MERS.fa
#
