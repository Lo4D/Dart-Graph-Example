// The Data
import 'dart:collection';

const airports = [
  'PHX',
  'BKK',
  'OKC',
  'JFK',
  'LAX',
  'MEX',
  'EZE',
  'HEL',
  'LOS',
  'LAP',
  'LIM',
];

const routes = [
  ['PHX', 'LAX'],
  ['PHX', 'JFK'],
  ['JFK', 'OKC'],
  ['JFK', 'HEL'],
  ['JFK', 'LOS'],
  ['MEX', 'LAX'],
  ['MEX', 'BKK'],
  ['MEX', 'LIM'],
  ['MEX', 'EZE'],
  ['LIM', 'BKK'],
];

class AirportsGraph {
  AirportsGraph({this.verbose = false}) {
    _createGraph();
  }

  final bool verbose;
  final _adjacencyList = <String, List<String>>{};

  void _addNode(String airport) {
    _adjacencyList[airport] = [];
  }

  void _addEdge(String origin, String destination) {
    _adjacencyList[origin]?.add(destination);
    _adjacencyList[destination]?.add(origin);
  }

  void _createGraph() {
    airports.forEach(_addNode);
    for (final [origin, destination] in routes) {
      _addEdge(origin, destination);
    }
  }

  bool _checkAirportExists(String airport) {
    if (_adjacencyList.containsKey(airport)) return true;
    print('There is no "$airport" airport in our database');
    return false;
  }

  String? getRoute(String start, String dest) {
    if (!_checkAirportExists(start) || !_checkAirportExists(dest)) return null;

    final route = <String>[];

    print('Calculating the optimal route from "$start" to "$dest"\n');
    var curDest = dest;
    while (true) {
      final airport = _bfs(start, curDest);
      if (airport == start) {
        final optimalRoute = route.reversed.toList();
        optimalRoute.insert(0, start);
        optimalRoute.add(dest);
        final result = optimalRoute.join(' - ');

        return result;
      }
      route.add(airport!);
      curDest = airport;
    }
  }

  String? _bfs(String start, String dest) {
    final visited = <String>{start};
    final queue = ListQueue<String>()..add(start);
    while (queue.isNotEmpty) {
      final airport = queue.removeFirst();
      if (verbose) {
        print('==========================================');
        print('Searching for destinations from "$airport" to "$dest"');
      }

      final destinations = _adjacencyList[airport]!;
      if (destinations.isEmpty) {
        if (verbose) {
          print('"$airport" does not have any destinations, skipping...');
        }
        continue;
      }

      for (var destination in destinations) {
        if (destination == dest) {
          if (verbose) {
            print('You can get to "$destination" from "$airport"');
          }
          return airport;
        }

        if (!visited.contains(destination)) {
          visited.add(destination);
          queue.add(destination);
        }
      }
    }
    return null;
  }

  @override
  String toString() {
    var string = '';
    _adjacencyList.forEach((key, value) {
      string = '$string$key: $value\n';
    });
    return string;
  }
}
