# Dart airports graph example

A simple command-line application to show dart graph implementation example.

## Requirements
This example uses patterns, which require a Dart version of at least 3.0.

## Usage
The app will search for a route between 2 airports.
```bash
dart run bin/dart_graph_example.dart FROM TO [--routes, -r] [--verbose, -v] [--fast, -f]
```

For example:
```bash
dart run bin/dart_graph_example.dart PHX LOS
```

Expected output:
```bash
Calculating the optimal route from "PHX" to "LOS"
Calculated route is "PHX - JFK - LOS"
```

### Optional flags
**--fast (-f)** - will use depth first search instead of default breadth first search. It results in faster calculation, but the resulting route will not be the optimal one.

**--routes (-r)** - will print used graph at the beginning, which contains the routes. 

**--verbose (-v)** - will print more info with dividers at each step of the search.
