import 'dart:io';

import 'package:dart_graph_example/airports_graph.dart';
import 'package:args/args.dart';

const routes = 'routes';
const verbose = 'verbose';

void main(List<String> arguments) {
  exitCode = 0;

  final parser = ArgParser();
  parser.addFlag(routes, negatable: false, abbr: 'r');
  parser.addFlag(verbose, negatable: false, abbr: 'v');
  final args = parser.parse(arguments);
  final airports = args.rest;

  final airportsGraph = AirportsGraph(verbose: args[verbose]);
  if (args[routes]) {
    print('All available routes (from to):');
    print(airportsGraph);
  }

  if (airports.length < 2) {
    print('You need to specify 2 airports to calculate a route');
  } else {
    final result = airportsGraph.getRoute(airports[0], airports[1]);
    if (result != null) {
      print('++++++++++++++++++++++++++++++++++++++++++');
      print('The optimal route is $result');
      print('++++++++++++++++++++++++++++++++++++++++++');
    }
  }
}
