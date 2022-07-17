# Route planning for the garbage disposal.

## I. Motivation
Waste is generated in every city and has to be removed. Each trip by the waste collection service incurs costs, most of which depend on the travel time. To minimize cost, one has to find the fastest possible route. But how can this be calculated?

## II. Approach

Finding an optimal route for garbage collection:

1. Convert the road network into an undirected coherent graph, where intersections are the nodes and roads are the edges, and dead ends are ignored for now.
2. If the graph has nodes with odd degrees, then consider these nodes and find a connection with the smallest sum of edge weights (using [Dijkstra's algorithm](https://github.com/MinhDucBui/routenplanner/blob/master/Code/dijkstra.m)) to keep our route optimal.
3. Add the connection in the form of edge additions to the graph.
4. For dead ends, we must drive in and out. So for dead ends, double edges are drawn in.
5. We now have an Euler graph and each Euler tour is optimal. We can apply our algorithms of [Hierholzer](https://github.com/MinhDucBui/routenplanner/blob/master/Code/hierholzer.m) and [Fleury](https://github.com/MinhDucBui/routenplanner/blob/master/Code/fleury.m) to find an Euler tour. Now we have found an optimal route and we are done!

Run this [script](https://github.com/MinhDucBui/routenplanner/blob/master/Code/TestBeispiel.m) for an example.


