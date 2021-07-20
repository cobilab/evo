<br>
<div align="center">
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)
[![Speed](https://img.shields.io/static/v1.svg?label=Fast&message=High%20speed%20performance&color=green)](#)
[![Reproducibility](https://img.shields.io/static/v1.svg?label=Reproducibility&message=Full%20reproducibility&color=gold)](#)
[![Release](https://img.shields.io/static/v1.svg?label=Release&message=v2.2&color=orange)](https://github.com/cobilab/evo/releases/tag/v1)
</div>
<br>
<p align="center">
<img src="imgs/logo.png" alt="evo" height="90" border="0" />
<br><br>
<b>Pipelines for the analysis of evolutionary patterns in SARS-CoV-2 genomes</b>
</p>

### 1. Installation ###

<p align="justify">The following instructions show the procedure to install and run EVO: </p>

```
git clone https://github.com/cobilab/evo.git
cd evo/eagle/
cmake . 
make
cd ../src/
chmod +x *.sh
```
External and complementary dependencies to download, align and visualize the data require conda installation.

Steps to install conda:
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
Additional instructions can be found here:
```
https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
```
To install the dependencies using conda:
```
conda install -c cobilab gto --yes
conda install -c cobilab geco3 --yes
```

### 2. Preparing the input data ###

```
lzma -d SDB.fasta.lzma 
lzma -d FIL_SDB.fasta.lzma 
./GetCoronas.sh
./GetHumanData.sh
```

### 3. Running EVO analysis ###

#### 3.1 Coronaviruses RAWs analysis: ####
```
mkdir -p raws_analysis
cd raws_analysis/
cp ../../eagle/EAGLE .
cp ../HS.fa .
cp ../CORONAS.fa .
cp ../ShowCoronasRaws.sh .
chmod +x *.sh
./EAGLE -f -p -v -min 12 -max 14 HS.seq CORONAS.fa
chmod +x *.sh
./kplot.sh
./ShowCoronasRaws.sh 12
```

#### 3.2 Coronaviruses NCD analysis: ####

```
cd ../ # Please, run this if you were at raws_analysis/
mkdir -p ncd_analysis
cd ncd_analysis/
cp ../CORONAS.fa .
cp ../REF.fa .
cp ../NCD.sh .
chmod +x *.sh
./NCD.sh REF.fa CORONAS.fa
```

#### 3.3 Coronaviruses Relative Complexity profile analysis: ####

```
cd ../ # Please, run this if you were at raws_analysis, ncd_analysis, or any other
mkdir -p rcp_analysis
cd rcp_analysis/
cp ../CORONAS.fa .
cp ../RCPCoronas.sh .
chmod +x RCPCoronas.sh
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
./RCPCoronas.sh 25    # 25 stands for the window size for the low-pass filter
```

#### 3.4 SARS-CoV-2 RAW analysis ####

```
cd ../ # Please, run this if you were at raws_analysis, ncd_analysis, or any other
mkdir -p s2_raws_analysis
cd s2_raws_analysis/
cp ../HS.fa .
cp ../../eagle/EAGLE .
cp ../FIL_SDB.fasta .
cp ../FindRAWException.sh .
chmod +x *.sh
cp ../SDB.fasta .
cp ../ExtractReadsWithExtraChars.sh .
./ExtractReadsWithExtraChars.sh # requires GTO installation: conda install -c cobilab gto -y
./EAGLE -min 11 -max 14 --force --ignore-raw-profiles --plots --verbose --ignore-gc-profiles HS.fa FIL_SDB.fasta
./FindRAWException.sh TGCGCGTCATAT 1 # Persistent
./FindRAWException.sh GCGCGTCATATT 2 # Persistent
./FindRAWException.sh CACAATCGACGG 3 
./FindRAWException.sh TTGCGCGTACGC 4 # Persistent
./FindRAWException.sh CGATATCGGTAA 5 # Persistent
./FindRAWException.sh AATGTCGCGCAT 6
./FindRAWException.sh GTCGCGCATTGG 7
./FindRAWException.sh GTACGATCGAGT 8
./FindRAWException.sh CGATCGAGTGTA 9
./FindRAWException.sh CGGCGGGCACGTA 10 # Persistent
```

#### 3.5 SARS-CoV-2 kmer conservation analysis: ####

```
cd ../ # Please, run this if you were at raws_analysis, ncd_analysis, or any other
mkdir -p conservation_analysis
cd conservation_analysis/
cp ../REF.fa .
cp ../FIL_SDB.fasta .
cp ../KmerConservation.sh .
cp ../ConservationProfile.sh .
cp ../ConservationProfileTrimm.sh .
cp ../.raws.txt .
chmod +x *.sh
./KmerConservation.sh FIL_SDB.fasta REF.fa 20 > Report_conservation_k20.txt
./ConservationProfile.sh Report_conservation_k20.txt 2
./ConservationProfileTrimm.sh Report_conservation_k20.txt 2 100
./KmerConservation.sh FIL_SDB.fasta REF.fa 12 > Conservation_k12.txt
awk '{ sum += $4; n++ } END { if (n > 0) print sum/n/117012*100; }' Conservation_k12.txt
```

#### 3.6 SARS-CoV-2 Average NCD to other coronaviruses in time: ####

```
cd ../ # Please, run this if you were at raws_analysis, ncd_analysis, or any other
mkdir -p dyn_analysis
cd dyn_analysis/
cp ../CORONAS.fa .
cp ../FIL_SDB.fasta .
cp ../NCD_SDB.sh .
cp ../NCDProfile.sh .
chmod +x *.sh
./NCD_SDB.sh FIL_SDB.fasta CORONAS.fa
./NCDProfile.sh Report_NCD_MN996532.1.txt 2 0.156 0.174
./NCDProfile.sh Report_NCD_MW251308.1.txt 2 0.266 0.284
```

#### 3.7 SARS-CoV-2 Nucleotide Distribution in time: ####

```
cd ../ # Please, run this if you were at raws_analysis, ncd_analysis, or any other
mkdir -p nuc_analysis
cd nuc_analysis/
cp ../FIL_SDB.fasta .
cp ../Nucleotide_SDB.sh .
cp ../NucleotideProfile.sh .
chmod +x *.sh
./Nucleotide_SDB.sh FIL_SDB.fasta
./NucleotideProfile.sh Report_Perc_Nucleotide.txt 2 29.8 30 A 2
./NucleotideProfile.sh Report_Perc_Nucleotide.txt 2 18.26 18.46 C 3
./NucleotideProfile.sh Report_Perc_Nucleotide.txt 2 19.5 19.7 G 4
./NucleotideProfile.sh Report_Perc_Nucleotide.txt 2 32.05 32.25 T 5
```

### 4. Citation ###

 * Article under Review.

### 5. Issues ###

For any issue let us know at [issues link](https://github.com/cobilab/evo/issues).

### 6. License ###

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)


For more information:
<pre>http://www.gnu.org/licenses/gpl-3.0.html</pre>


