# Pool-seq_analysis (FST plots)
Scripts to analyse pool-seq data from raw data to f-statistics


## First step:
Rename the files to have a number in front of the sample name, separated by an underscore e.g:  
F113O_1.fq.gz becomes something like 25_F133O_1.fq.gz  
This is done for batch submission of jobs on the SLURM cluster using the ```--array```  paramater in the submission script  

## Second step
Run ```VCF_creation.sh``` specify which samples the pipeline will be run on by changing the ```--array``` line in the top of the script

This script will output:  
Unmapped fastqs which we will use for microbiome analysis (see microbiome analysis repo for the rest of this pipeline)  
Bam files which we will use for population analysis  
VCF files which we will use to see which high impact SNPs are present in our data  

## Third step

Run ```mpileup_creation.sh```  
  
This script creates a mpileup file from the bam files which were created in the second step.   
Note: Please enure your outgroup sample is the first bam file in the list of files. This is important when computing F4 statistics.  
It also takes a file which has the genomic locations we want to investigate.   
This file is called ```matching_snp_locations.txt```


## Fourth step

Run ```sync_file_creation.sh```  
  
This script uses the mpileup file from the third step to create a sync file using popoolation2  
This sync file is the input file for PoolFstat  

## Fifth step

Run ```sync_to_pooldata.R```  

This script takes the sync file as input and outputs the following:  
A pooldata object  
Input files for BayPass  
FST for every pairwise combination of populations  
F3 statistics for every combination of 3 populations  
F4 statistics for every combination of 3 populations + Cerana as outgroup  

## Sixth step  
Run ```combine_pairwise_FSTs.py```  
This python script combines all of the pairwise FSTs we create for each sample into one final matrix
(you may need to fill in the bottom right of the dataframe manually)
  
## Seventh step
Run ```FST visualisation.R```  
This scrpipt will output various trees using the pairwise FST matrix from the fifth step  
