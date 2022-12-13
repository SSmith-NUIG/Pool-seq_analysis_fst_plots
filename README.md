# Pool-seq_analysis
Scripts to analyse pool-seq data from raw data to f-statistics


## First step:
Rename the files to have a number in front of the sample name, separated by an underscore e.g:
F113O_1.fq.gz becomes something like 25_F133O_1.fq.gz

## Second step
Run ```VCF_creation.sh``` specify which samples the pipeline will be run on by changing the ```--array``` line in the top of the script

This script will output:
Unmapped fastqs which we will use for microbiome analysis (see microbiome analysis repo for the rest of this pipeline)
Bam files which we will use for population analysis
VCF files which we will use to see which high impact SNPs are present in our data

## Third step

Run ```mpileup_creation.sh```

This script creates a mpileup file from the bam files which were created in the second step


## Fourth step

Run ```sync_file_creation.sh```

This script uses the mpileup file from the third step to create a sync file using popoolation2
This sync file is the input file for PoolFstat

## Fifth step

Run ```sync_to_pooldata.R```
