# Practice about Statistical Analysis of Network Data with R Book section 1

# Libraries importing
library(sand)
library(igraph)

# Loading gene expression data
df.Ecoli <- Ecoli.expr

# Making exploratory analysis
# Data structure of df
dim(df.Ecoli)
str(df.Ecoli)
typeof(df.Ecoli)
head(df.Ecoli)

# Summary about df
summary(df.Ecoli)
heatmap(scale(Ecoli.expr), Rowv = NA, Colv = NA)

# Creating adjacency matrix
g.Ecoli <- graph_from_adjacency_matrix(regDB.adj, "undirected")

# Summary of the graph represented by adjacency matrix
summary(g.Ecoli)
print_all(g.Ecoli)

# Retrieving vertices and edges
vcount(g.Ecoli)
V(g.Ecoli)
ecount(g.Ecoli)
E(g.Ecoli)

# Ploting the graph
plot(g.Ecoli, vertex.size = 6, vertex.label = NA)

# Assing a name to graph
g.Ecoli$name <- "E coli expression data analysis"

# Creating a subgraph
sub_g.Ec <- induced_subgraph(g.Ecoli, 50:80)

# Printing and ploting subgraph
print_all(sub_g.Ec)
plot(sub_g.Ec)

# Assing a name to subgraph
sub_g.Ec$name <- "E coli expression data analysis subset"

# Adding attributes to vertices - metab path
V(sub_g.Ec)$metab_path <- c(rep(x = "glucose path", 10), rep(x = "fructuose path", 10), rep(x = "lactose path", 10))
print(V(sub_g.Ec)$metab_path)
plot(sub_g.Ec, vertex.label = metab_path)

# Listing vertex attributes
vertex_attr_names(g.Ecoli)
vertex_attr_names(sub_g.Ec)

# Verifying if a graph is weighted
is_weighted(g) #Why is FALSE????

# Verifying if a graph is simple
is_simple(g)

# Listing neighbors
neighbors(g.Ecoli, "araC_b0064_at")

# Calculating the degree of vertices (incident edges) on undirected graph
degree(g.Ecoli)

# Check the connectivity in a undirected graph
is_connected(g.Ecoli)

# Listing components
clusters(g.Ecoli)
clusters(sub_g.Ec)

# Calculating diameter of the graph
diameter(g.Ecoli, weights=NA)
diameter(sub_g.Ec, weights=NA)
