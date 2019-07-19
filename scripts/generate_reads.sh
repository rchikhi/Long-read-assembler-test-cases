perl PaSS/pacbio_mkindex.pl  PaSS_ref/ref.fasta  PaSS_ref/

reads=reads.50x
reads=reads.100x
reads=reads.50x.with_10x_region
reads=reads.50x.with_5x_region

PaSS/PaSS -list PaSS_ref/percentage.txt  -index PaSS_ref/index  -m pacbio_sequel -c PaSS/sim.config  -r 20000 -t 4 -o $reads
