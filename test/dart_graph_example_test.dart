import 'package:dart_graph_example/airports_graph.dart';
import 'package:test/test.dart';

void main() {
  test('getRoute', () {
    final airportsGraph = AirportsGraph();
    expect(airportsGraph.getRoute('PHX', 'LOS'), 'PHX - JFK - LOS');
  });
}
