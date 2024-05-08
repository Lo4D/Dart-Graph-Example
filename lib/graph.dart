import 'dart:collection';

class Graph<T> extends Iterable<T> {
  Graph(Map<T, Set<T>> data) : _data = data;

  Graph.of(Graph<T> graph) : this(graph.data);

  Graph.generate(Set<List<T>> edges) : _data = {} {
    for (final [node, edge] in edges) {
      addEdge(node, edge);
    }
  }

  final Map<T, Set<T>> _data;
  Map<T, Set<T>> get data => _data;

  void addEdge(T node, T edge) {
    _data[node] ??= <T>{};
    _data[node]?.add(edge);
  }

  void addEdges(T origin, Set<T> edges) {
    if (_data.containsKey(origin)) {
      _data[origin]!.addAll(edges);
    } else {
      _data[origin] = Set.of(edges);
    }
    for (final edge in edges) {
      _data[edge] ??= <T>{};
    }
  }

  T? dfs(T start, T end, {Set<T>? visitedArg}) {
    final visited = visitedArg ?? {};
    visited.add(start);

    final edges = _data[start]!;

    for (final edge in edges) {
      if (edge == end) return start;
      if (!visited.contains(edge)) {
        final result = dfs(edge, end, visitedArg: visited);
        if (result != null) return result;
      }
    }

    return null;
  }

  T? bfs(T start, T end) {
    final visited = <T>{start};
    final queue = ListQueue<T>()..add(start);
    while (queue.isNotEmpty) {
      final node = queue.removeFirst();
      final edges = _data[node]!;

      for (var edge in edges) {
        if (edge == end) return node;

        if (!visited.contains(edge)) {
          visited.add(edge);
          queue.add(edge);
        }
      }
    }
    return null;
  }

  @override
  String toString() {
    var string = '';
    _data.forEach((key, value) {
      string = '$string$key: $value\n';
    });
    return string;
  }

  @override
  Iterator<T> get iterator => _data.keys.iterator;
}
