import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_graph_example/undirected_graph.dart';

const routes = 'routes';
const verbose = 'verbose';
const fast = 'fast';

const routesSet = {
  ['PHX', 'LAX'],
  ['PHX', 'JFK'],
  ['JFK', 'OKC'],
  ['JFK', 'HEL'],
  ['JFK', 'LOS'],
  ['JFK', 'LIM'],
  ['MEX', 'LAX'],
  ['MEX', 'BKK'],
  ['MEX', 'LIM'],
  ['MEX', 'EZE'],
  ['LIM', 'BKK'],
  ['LIM', 'JFK'],
  ['LAX', 'LIM'],
  ['HEL', 'OKC'],
};

void main(List<String> arguments) {
  exitCode = 0;

  final parser = ArgParser();
  parser.addFlag(routes, negatable: false, abbr: 'r');
  parser.addFlag(verbose, negatable: false, abbr: 'v');
  parser.addFlag(fast, negatable: false, abbr: 'f');

  final args = parser.parse(arguments);
  final airports = UndirectedGraph<String>.generate(routesSet);

  if (args[routes]) {
    print('All available routes (from to):');
    print(airports);
  }

  if (args.rest.length != 2) {
    print('You need to specify 2 airports to calculate a route');
    return;
  }

  final [origin, dest] = args.rest;

  bool airportExists(String airport) {
    if (airports.contains(airport)) return true;
    print(
        "$airport does not exist in our route database. Please try another airport.");
    print("You can get available routes by passing [-r] option.");
    return false;
  }

  if (!airportExists(origin) || !airportExists(dest)) return;

  final search = switch (args[fast]) {
    true => airports.dfs,
    _ => airports.bfs,
  };

  final intro = switch (args[fast]) {
    true => 'Quickly calculating the route from "$origin" to "$dest"',
    _ => 'Calculating the optimal route from "$origin" to "$dest"'
  };

  print(intro);

  final result = getRoute(origin, dest, search, args[verbose]);
  if (result != null) {
    print('Calculated route is "$result"');
  }
}

String? getRoute(
  String origin,
  String dest,
  String? Function(String origin, String dest) search,
  bool isVerbose,
) {
  final route = <String>[];
  var curDest = dest;
  while (true) {
    if (isVerbose) {
      print('==========================================');
      print('Searching for destinations to "$curDest"');
    }
    final airport = search(origin, curDest)!;

    route.add(airport);
    if (isVerbose) {
      print('You can get to "$curDest" from "$airport"');
    }
    if (airport == origin) {
      if (isVerbose) print('==========================================');
      final optimalRoute = route.reversed.toList();
      optimalRoute.add(dest);
      return optimalRoute.join(' - ');
    }
    curDest = airport;
  }
}
