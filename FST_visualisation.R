# read in the pairwise fst
full_snppairwise = read.csv("full_snppairwise.csv", row.names=1)

# scale the matrix
snp_full_scaled = scale(full_snppairwise)

# replace empty values with 0
snp_full_scaled[is.na(snp_full_scaled)] <- 0

# get a correlation matrix using pearsons distance
snp_cor_pearson = get_dist(snp_full_scaled, method = "pearson")

# get a distance matrix from the correlation matrix using the ward.D2 method
snp_fit_pearson = hclust(snp_cor_pearson, method="ward.D2")

# turn this distance matrix into a phylogentic matrix with edges and branch lengths etc.
snp_tree_pearson = as.phylo(snp_fit_pearson)

# add some length to the trees edges to make visualisation easier
snp_tree_pearson$edge.length = snp_tree_pearson$edge.length + 4

# cut our tree into x number of populations
clus4_pearson = cutree(snp_fit_pearson, 4)

# create a colour map
my_colors = c("chartreuse4", "chocolate2", "red", "brown", "brown", "darkorchid3", "chocolate1",
              "coral3", "cyan3", "darkgoldenrod3", "burlywood2", "aquamarine2")

# create an image of the tree
png("tree_pearsons_wardD2.png", width = 1500, height = 2000, units = "px")
plot(snp_tree_pearson, type = "tidy", tip.color = my_colors[clus4_pearson],
     label.offset = .05, cex = 0.75, main="Phylogram based on pairwiseFST")
dev.off()


# run a pca on the correlation matrix
pca_df = prcomp(snp_cor_pearson)
dtp = data.frame("name"=row.names(snp_full_scaled), pca_df$x[,c(1,2)])
samples_names = rownames(full_snppairwise)

# plot the pca
a = ggplot(dtp, aes(x=PC1, y=PC2, label=row.names(dtp))) + geom_text(cex=4.2) + theme_minimal()
