library(poolfstat)

# create a vector of population names, these must be the same order
# as the bam file list which was supplied to the mpileup command

pnames= c("Cerana", "RG52_T1", "RG159_T2", "RG32_T3", "RG278_T4","RG919_T5",
"RG308_T7", "RG245_T8", "RG295_T9", "WT28_U1", "WT30_U2", "WT29_U3",
"WT19_U4", "WT25_U5", "WT27_U6", "WT23_U8", "OSIR1", "CG4", "MSN4", 
"MSE2", "MSN1", "RCA1", "CA5", "MSN2", "RFSO4", "ROSCG2", "F89CE",
"F99G", "F94CE", "F78G", "F27G", "F91CE", "F74D19", "F72G", "F27G19",
"GTNUC", "F13R", "F109R", "F90CE", "F16G", "SO20C", "SO20I", "SO20G", "F98G",
"F85CE", "F93CE", "SO20F", "SO20M", "SO20E", "F95DL20", "F38C", "F104G",
"F100CE", "F101", "F47G", "F97R", "AFH1", "AmC109", "AmC419", "AmC423",
"AmC429", "AmC435", "CL1", "F112G", "F113O", "F114O", "F115G", "F116G", 
"F117G", "F118G", "F119G", "F120G", "F121G", "F122KY", "F124KY", "F125KY",
"F126C", "F127C", "F128C", "F129C", "F130C", "F131W", "F132L", "F133L", 
"F134L", "F135G", "JIBWCB1", "Mull2", "TD2BLK", "TD2BND", "TD31", "X1",
"X212", "X21", "BD1", "BD31", "DR11", "DR16", "DR19", "DR23", "F106R",
"F107R", "F123KY", "F29GBK17", "F29GBN17", "F48G17", "H1", "H2", "JIBWWC1",
"RPOT", "T5", "F9810G", "F9820G", "F9830G", "F9510DL", "F9520DL", "F9530DL",
"F9210CE", "F9220CE", "F9230CE", "F139DL22", "F140DL21", "F143DL22", "F147DL22", 
"F148DL22", "F150DL22", "F152DL21", "F153DL21", "F157DL21", "F160DL22",
"F162DL22", "F165DL22", "F138DL21", "M138DL22", "M149DL21", "M159DL21", 
"M162DL22", "M166DL22", "M167DL22", "M218DL21", "DRX3BLK", "F136DL21", 
"F137DL22", "F146DL22", "F149DL22", "F159LH22", "M139DL21", "M140DL21", 
"M147DL21", "M150DL21", "M216DL21", "M217DL21", "M219DL21", "NUIG22SW", 
"TKY_ANA1", "IOM_MEL1", "MLT_RUT1", "MLT_RUT2", "GRC_ADI", "ARM_REM1", 
"CYP_CYP1", "CYP_CYP2", "AUS_CAR", "GRG_CAU", "UNK_MAC", "SLV_CAR1", 
"SLV_CAR2", "ITA_LIG1", "ITA_LIG2", "DEN_MEL1", "ARM_REM2", "DEN_MEL2", 
"DEN_MEL3", "DEN_MEL4", "SWI_MEL1", "SWI_MEL2", "SWI_MEL3", "SWI_MEL4", 
"BUL_ROD1", "BUL_ROD2", "BUL_ROD3", "MLT_RUT3", "BUL_ROD4", "ROM_CPT1", 
"ROM_CPT2", "ROM_CPT3", "ROM_CPT4", "TKY_ANA2", "TKY_ANA3", "TKY_ANA4", 
"IOM_MEL2", "IOM_MEL3", "IOM_MEL4", "ARM_REM3", "ARM_REM4", "SPN_IBE1", 
"SPN_IBE2", "SPN_IBE3", "RUS_MEL", "GRC_CER", "IRL_MEL", "SPN_IBE4", "SPN_IBE5")

# create our pooldata object. the poolsizes must be in the same order as the bam file list
# which was supplied to the mpileup command

pooldata <- popsync2pooldata(sync.file="/data2/ssmith/matching_snps_pop_cerana.sync",
min.rc = 6,
poolnames = pnames, 
poolsizes = c(2, rep(60,68), 50, 60, 50, 60, 46, 60, 
60, 32, rep(60,31), 62, 22, 60, 20, 40, 60, 20, 
40, 60, 20, 40, 60, 60, 50, 60, 60, 60, 50, 50, 
50, 60, 50, 60, 60, 60, 60, 50, 60, 60, 60, 50, 
60, 60, 60, 60, 40, 30, 60, 40, 40, 30, 40, 40, 
40, 40, 60, 200, 180, 200, 200, 176, 180, 200, 200,
200, 200, 172, 200, 200, 216, 216, 200, 180, 200,
200, 200, 200, 200, 200, 200, 190, 190, 190, 200, 190,
180, 180, 180, 180, 200, 200, 200, 180, 180, 180,
180, 180, 200, 200, 200, 200, 186, 200, 200, 200),
min.cov.per.pool = 4, 
max.cov.per.pool = 500,
min.maf = 0.01, 
noindel = TRUE, 
nthreads = 32, 
nlines.per.readblock = 1000)

# save the pooldata file so that you can load it in the future and skip the previous pooldata creation step
save(pooldata, ascii=TRUE, file="/data3/ssmith/ena/population_genomics/new_analysis/pooldata_matching_snps_cerana")

# output files for baypass, this can also be skipped in the future once they have been created
pooldata2genobaypass(pooldata, writing.dir = "/data3/ssmith/ena/population_genomics/new_analysis/", subsamplesize = -1, prefix = "baypass_pool_oc
tober_matching_snps_cerana")
#load("/data3/ssmith/ena/population_genomics/new_analysis/pooldata_matching_snps")

# this loop creates the pairwise FST matrix. If your cluster has enough RAM you may be able to do this without a loop
for (i in pnames){
  this_pool = as.vector(which(pnames %in% i))
  other_pools = as.vector(which(!(pnames %in% i)))
  list_of_dfs = list()
  for (j in other_pools) {
    
    while (j < (length(pnames))){
      next_pool = j+1
      this_combination = c(this_pool, j, next_pool)
      new_pools=pooldata.subset(pooldata, pool.index=this_combination)

      snp.fsts = compute.pairwiseFST(new_pools,
                                     method = "Anova",
                                   min.cov.per.pool = 10,
                                   max.cov.per.pool = 400,
                                   min.maf=0.1,
                                   output.snp.values = FALSE,
                                   nsnp.per.bjack.block = 100)
      
      snppairwise = snp.fsts@PairwiseFSTmatrix
      break
    }
    snppairwise = as.data.frame(snppairwise)
    list_of_dfs[[j]] <- snppairwise
  }
  list_of_dfs = list_of_dfs[!sapply(list_of_dfs,is.null)]
  merged_df_test = do.call(cbind, list_of_dfs)
  merged_df_test = merged_df_test[, !duplicated(colnames(merged_df_test))]
  merged_df_test = head(merged_df_test,-2)
  merged_df_test = t(merged_df_test)
  file_out_name=paste("/data2/ssmith/snppairwises/snppairwise_",i,"_merged.csv", sep = '')
  write.csv(merged_df_test, file=file_out_name)
}

# this loop is used to create total F3star files and also admixture files 
# which contain only the significant results from the F3star calculation
# Again, if your cluster has enough RAM/you have a low amount of populations, you may be able to skip this step

for (i in pnames){
  known_pure_samples_and_hybrids = as.vector(which(pnames %in% c(i, "Cerana", "F113O", "SLV_CAR", "IRL_MEL", "F112G", "X1", "AmC429", "AmC419", "ITA_LIG1", "TKY_A
NA1", "MLT_RUT1", "F74D19", "RPOT", "F48DL22", "M218DL21", "SWI_MEL1", "F162DL22")))
  pure_samples_plus_i_pools = pooldata.subset(pooldata, pool.index=known_pure_samples_and_hybrids)
  fstats = compute.fstats(pure_samples_plus_i_pools, nsnp.per.bjack.block = 500, computeDstat=TRUE, return.F4.blockjackknife.samples=TRUE)
  
  # create a plot to visualise the F3 stat
  f3_plot_out = paste("/data2/ssmith/f3_plots/",i,"f3_.png", sep="")
  png(f3_plot_out, width = 300, height = 600, units = "px")
  plot_fstats(fstats, stat.name = "F3", cex=0.5,
            pop.f3.target = c(i))
  dev.off()
  
  # output the F3star data
  print("creating f3 star csv")
  fstats.f3star = fstats@f3star.values
  fstats.f3star = as.data.frame(fstats.f3star)
  f3_out_name = paste("/data2/ssmith/fstats/f3/",i,".csv", sep="")
  write.csv(fstats.f3star, f3_out_name)
  
  # output only the significant F3 data
  print("computing admixture and creating admix csv")
  tst.sel = fstats@f3.values$'Z-score'< -3
  admi = fstats@f3.values[tst.sel,]
  admi = as.data.frame(admi)
  admix_out_name = paste("/data2/ssmith/fstats/admix/,i,".csv", sep="")
  write.csv(admi, admix_out_name)
}

#get all possible combinations of 3 of our populations
f4_combinations = combn(pnames, 3)

#loop over this combination matrix
for (i in 1:ncol(f4_combinations)){
  #get the position of our outgroup cerana sample
  cerana = as.vector(which(pnames %in% c("Cerana")))
  #get the three pools we will be using F4 to test gene flow on
  other_3_pools = as.vector(which(pnames %in% c(f4_combinations[,i])))
  #combine both of these vectors into one
  v = c(cerana, other_3_pools)
  #subset the pooldata for f4 testing the four populations in the vector v
  pooldata_for_f4_testing = pooldata.subset(pooldata, pool.index=c(v))
  # compure fstats
  fstats = compute.fstats(pooldata_for_f4_testing, nsnp.per.bjack.block = 1000, computeDstat = TRUE, return.F4.blockjackknife.samples= TRUE)

  #output dstats to a file which is named after the 3 populations we are testing, in the order they are being tested
  fstats.dstat = fstats@Dstat.values
  fstats.dstat = as.data.frame(fstats.dstat)
  d_out_prefix = paste(f4_combinations[,i], collapse = '-')
  d_out_name = paste("/data2/ssmith/fstats/dstats/",d_out_prefix,".csv", sep="")
  write.csv(fstats.dstat, d_out_name)
}
