import 'package:dart_graph_example/undirected_graph.dart';
import 'package:test/test.dart';

import '../bin/dart_graph_example.dart';

void main() {
  final airports = UndirectedGraph.generate(routesSet);
  test(
    'Optimal route bfs',
    () {
      expect(getRoute('PHX', 'LIM', airports.bfs, false), 'PHX - LAX - LIM');
    },
  );
  test(
    'Fast calculation route dfs',
    () {
      expect(getRoute('PHX', 'LIM', airports.dfs, false),
          'PHX - LAX - MEX - BKK - LIM');
    },
  );
}
