dataset=initial50x_with_10x_region
dataset=initial50x_with_5x_region

reads=reads.50x.fq
reads=reads.100x.fq
reads=reads.50x.with_10x_region.fq
reads=reads.50x.with_5x_region.fq

~/tools//canu-1.8/Linux-amd64/bin/canu -p canu -d "$dataset"_canu genomeSize=3.565m stopOnLowCoverage=0 useGrid=false minThreads=8 maxThreads=8 maxMemory=10 -pacbio-raw $reads

python2 ~/tools/Flye/bin/flye --pacbio-raw $reads -g 3.565m -o "$dataset"_flye -t 4

~/tools/Unicycler/unicycler-runner.py  -l $reads -o "$dataset"_unicycler -t 4

mkdir "$dataset"_ra
cd "$dataset"_ra
~/tools/ra/build/bin/ra -x pb -t 4 ../$reads > assembly.fasta
cd ..


mkdir "$dataset"_wtdbg2
cd "$dataset"_wtdbg2
wtdbg2 -x rsII -g 3.565m -i ../$reads -t 4 -fo out
wtpoa-cns -t 4 -i out.ctg.lay.gz -fo out.ctg.fa
minimap2 -t 4 -x map-pb -a out.ctg.fa ../$reads | samtools sort > out.ctg.bam
samtools view out.ctg.bam | wtpoa-cns -t 4 -d out.ctg.fa -i - -fo assembly.fasta
cd ..
