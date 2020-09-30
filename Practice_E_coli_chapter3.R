# Practice about Statistical Analysis of Network Data with R Book chapter3
# ------------------------------------PREPARING DATA-------------------------------------
# Libraries importing
library(sand)
library(igraph)

# Loading gene expression data
df.Ecoli <- Ecoli.expr

# Summary about df
str(df.Ecoli)
heatmap(scale(Ecoli.expr), Rowv = NA, Colv = NA)

# Creating adjacency matrix
g.Ecoli <- graph_from_adjacency_matrix(regDB.adj, "undirected")

# -------------------------------------LAYOUTS-------------------------------------------
# Circular layout
igraph_options(vertex.size=5, vertex.label=NA)
par(mfrow=c(1, 1))
plot(g.Ecoli, layout=layout_in_circle)
title("Circular")

# Spring-embedder methods - method of Fruchterman and Reingold
plot(g.Ecoli,layout=layout_with_fr)
title("Spring-embedder method - F&R")

# Energy-placement methods - method of Kamada and Kawai
plot(g.Ecoli, layout=layout_with_kk)
title("Energy-placement method - K&K")

# LGL algorithm
par(mfrow=c(1, 1))
set.seed(42)
plot(g.Ecoli, layout=layout_with_lgl)
title("LGL algorithm")

# Choose an appropriate graph layout algorithm automatically
set.seed(42)  #????
l <- layout_nicely(g.Ecoli)
plot(g.Ecoli, layout = l)

# ----------------------------------DECORING GRAPH LAYOUTS------------------------------
# Plot undecorated first.
par(mfrow=c(1, 2))
plot(g.Ecoli, layout=l)

# Decorated graph
# Adding attributes to vertices - metab path
V(g.Ecoli)$metab_path <- c(rep(x = "glucose path", 50), rep(x = "fructuose path", 50), rep(x = "lactose path", 53))
vertex_attr_names(g.Ecoli)
print(V(g.Ecoli)$metab_path)

# Coloring vertices by te metab path 
V(g.Ecoli)[metab_path == "glucose path"]$color <- "green"
V(g.Ecoli)[metab_path == "fructuose path"]$color <- "orange"
V(g.Ecoli)[metab_path == "lactose path"]$color <- "blue"

# Making vertex sizes proportional to vertex strength
# (i.e., total weight of incident edges).
V(g.Ecoli)$size <- 2.5*sqrt(strength(g.Ecoli))
V(g.Ecoli)$size2 <- V(g.Ecoli)$size * .5

# ERROR
# E(g.Ecoli)$width <- E(g.Ecoli)$weight

# Color edges by within/between faction.
F1 <- V(g.Ecoli)[metab_path == "glucose path"]
F2 <- V(g.Ecoli)[metab_path == "fructuose path"]
F3 <- V(g.Ecoli)[metab_path == "lactose path"]
E(g.Ecoli)[ F1 %--% F1 ]$color <- "lightgreen"
E(g.Ecoli)[ F2 %--% F2 ]$color <- "yellow"
E(g.Ecoli)[ F3 %--% F3 ]$color <- "lightblue"
E(g.Ecoli)[ F1 %--% F2 ]$color <- "black"
E(g.Ecoli)[ F1 %--% F3 ]$color <- "black"
E(g.Ecoli)[ F2 %--% F3 ]$color <- "black"

# Ploting the decorated graph
plot(g.Ecoli, layout = l)
title("E coli expression analysis")

#legend("bottomright", inset=.02, title="Metabolic pathway",
 #      c("glucose path", "fructuose path", "lactose path"),  col=c("green", "orange", "blue"), horiz=TRUE, cex=0.3)

#legend("bottomright", legend=c("glucose path", "fructuose path", "lactose path"),
 #      col=c("green", "orange", "blue"), lty=1:2, cex=0.2,
  #     title="Metabolic pathway")






