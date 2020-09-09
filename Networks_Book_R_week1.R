install.packages("sand")
# SAND with R, chapter2.tex
# 2.2 Creating Network Graphs

# Undirected and Directed Graphs
# Creating undirected graphs
library(igraph)
g <- graph_from_literal(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 4-6, 4-7, 5-6, 6-7)

g1 <- graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 4-6, 4-7, 5-6, 6-7, 8-7)

# Retrieving vertices
V(g1)

# Retrieving edges
E(g1)

# Printing a summary
print_all(g1)

# PLotting the graph
plot(g1)

# Creating directed graphs
dg <- graph_from_literal(1-+2, 1-+3, 2++3)
dg1 <- graph.formula(1-+2, 1-+3, 2++3)
plot(dg)

# Creating undirected graphs with given names
dg2 <- graph_from_literal(Sam-+Mary, Sam-+Tom, Mary++Tom)
print_all(dg2)

# Rename the vertices
V(dg)$name <- c("Sam", "Mary", "Tom")

# Representations for Graphs
# Adjacency list representation - not working
#graph.adjlist()

# Edge list representation
E(dg2)
get.edgelist(dg2)

# Not working
#graph.edgelist(dg2)

# Adjacency representation
as_adjacency_matrix(g)

# Not working
#graph.adjacency(g)

# Operations on Graphs
#Obtaining a subgraph
h <- induced_subgraph(g, 1:5)
print_all(h)

# Obtaining a subgraph by the minus operator
h <- g - vertices(c(6,7))

# Recovering g from h by the plus operator
h <- h + vertices(c(6,7))
g <- h + edges(c(4,6),c(4,7),c(5,6),c(6,7))
print_all(g)

# Applying union to obtain a graph
h1 <- h
h2 <- graph_from_literal(4-6, 4-7, 5-6, 6-7)
g <- union(h1,h2)
print_all(g)

# Decorating Network-Graphs
#Vertex, Edge, and Graph Attributes
#Listing vertices from dg
V(dg)$name

# Adding attributes to vertices
V(dg)$gender <- c("M","F","M")

# Associating te color red with vertices
V(g)$color <- "red"
plot(g)

# Verifying if a graph is weighted
is_weighted(g)
wg <- g
E(wg)$weight <- runif(ecount(wg))
is_weighted(wg)

# Linking a name to a graph
g$name <- "Toy Graph"

#Using data frames
# Importing information from vertices and edges data frames
library(sand)
g.lazega <- graph_from_data_frame(
  elist.lazega,
  directed="FALSE",
  vertices=v.attr.lazega
)
g.lazega$name <- "Lazega Lawyers"
plot(g.lazega)

# Network information
vcount(g.lazega)
ecount(g.lazega)

# Listing vertex attributes
vertex_attr_names(g.lazega)

# Talking about graphs
# Basic graph concepts
# Verifying if a graph is simple
is_simple(g)

# Converting g to a multi-graph (loops and multi-edges)
mg <- g + edge(2,3)
print_all(mg)
is_simple(mg)

# Converting multi-graph to a weighted graph
E(mg)$weight <- 1
wg2 <- simplify(mg)
is_simple(wg2)
print_all(wg2)
E(wg2)$weight

# Listing neighbors
neighbors(g,5)


# Calculating the degree of vertices (incident edges) on undirected graph
degree(g)

# Calculating the degree of vertices (incident edges) on directed graph
degree(dg, mode="in")
degree(dg, mode="out")

# Check the connectivity in a undirected graph
is_connected(g)

# Listing components
clusters(g)

# Check the connectivity in a directed graph
is_connected(dg,mode="weak")
is_connected(dg,mode="strong")

# Calculating diameter of the graph
diameter(g, weights=NA)

# Special Types of Graphs
g.full <- make_full_graph(7)
g.ring <- make_ring(7)
g.tree <- make_tree(7, children=2, mode="undirected")
g.star <- make_star(7, mode="undirected")
par(mfrow=c(2, 2), mai = c(0.2, 0.2, 0.2, 0.2))
plot(g.full)
plot(g.ring)
plot(g.tree)
plot(g.star)

# Veryfing is a graph is a DAG
is_dag(dg)

# Creating a bipartite graph
g.bip <- graph_from_literal(
  actor1:actor2:actor3,
  movie1:movie2, actor1:actor2 - movie1,
  actor2:actor3 - movie2
)
V(g.bip)$type <- grepl("^movie", V(g.bip)$name)
print_all(g.bip, v=T)

# Creating a projection
proj <- bipartite_projection(g.bip)
print_all(proj[[1]])
print_all(proj[[2]])
