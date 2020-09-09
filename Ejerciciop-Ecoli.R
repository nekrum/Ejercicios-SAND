# Practice about Statistical Analysis of Network Data with R Book section 1

# Libraries importing
library(sand)
library(igraph)

# Loading gene expression data
df.Ecoli <- Ecoli.expr

# Making exploratory analysis
dim(df.Ecoli)
head(df.Ecoli)
heatmap(scale(Ecoli.expr), Rowv = NA, Colv = NA)

# Creating adjacency matrix
g.Ecoli <- graph_from_adjacency_matrix(regDB.adj, "undirected")

# Summary of the graph represented by adjacency matrix
summary(g.Ecoli)

# Ploting the graph
plot(g.Ecoli, vertex.size = 6, vertex.label = NA)
