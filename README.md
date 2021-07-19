<br>
<p align="center"><img src="imgs/logo.png" alt="evo" height="90" border="0" />
<br>
<b>EVO: pipelines for analysis of evolutionary patterns in SARS-CoV-2 genomes</b>
</p>

### Installation ###

<p align="justify">The following instructions show the procedure to install and run EVO: </p>

```
git clone https://github.com/cobilab/evo.git
cd evo/src/
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
To install EAGLE2:
```
git clone https://github.com/cobilab/eagle.git
cd eagle/src/
cmake .
make
```

### Run EVO ###

Run EVO in Coronaviruses RAWs analysis:
<pre>
mkdir -p raws_analysis
cd raws_analysis/
cp ../../src/EAGLE .
cp ../HS.fa .
cp ../CORONAS.fa .
cp ../ShowCoronasRaws.sh .
./EAGLE -f -p -v -min 12 -max 14 HS.seq CORONAS.fa
</pre>

### Citation ###

 * Article under Review

### Issues ###

For any issue let us know at [issues link](https://github.com/cobilab/evo/issues).

### License ###

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)


For more information:
<pre>http://www.gnu.org/licenses/gpl-3.0.html</pre>


