import 'package:dart_graph_example/graph.dart';

class UndirectedGraph<T> extends Graph<T> {
  UndirectedGraph(super.data);
  UndirectedGraph.of(super.graph) : super.of();
  UndirectedGraph.generate(super.edges) : super.generate();

  @override
  void addEdge(node, edge) {
    super.addEdge(node, edge);
    super.addEdge(edge, node);
  }

  @override
  void addEdges(T origin, Set<T> edges) {
    super.addEdges(origin, edges);
    for (final edge in edges) {
      super.addEdges(origin, {edge});
    }
  }
}
