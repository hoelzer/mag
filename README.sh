#for ID in $(awk 'BEGIN{FS="/"};{print $5}' mag_adrian.ids | awk 'BEGIN{FS="_"};{print $1}' | sort | uniq); do PREFIX=$(grep $ID input_v3.tsv | awk '{print $1"\t"$2}'); R1=""; R2=""; for FASTQ in $(grep $ID mag_adrian.ids | sed 's@buckets/@gs://matrice/@g'); do if [[ $FASTQ == "*_R1.fastq" ]]; then R1=$FASTQ; else R2=$FASTQ fi; done; printf $PREFIX"\t"$(echo $R2 | sed 's/R2/R1/g')"\t"$R2"\n"; done > input_v3_eu.tsv 

nextflow run mag_forked/main.nf --input mag_forked/input_v3.tsv -profile gcloudMartinPrivate -resume 

wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20201202.tar.gz

rerun w/ kraken

nextflow run mag_forked/main.nf --input mag_forked/input_v3.tsv -profile gcloudMartinPrivate -resume --kraken2_db https://storage.cloud.google.com/databases-matrice/nf-core-mag/k2_standard_20201202.tar.gz