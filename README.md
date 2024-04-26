# Dart graph example

A simple command-line application to show non-abstract graph example.

## Requirements
This example uses patterns, which require a Dart version of at least 3.0.

## Usage
The app will search for optimal route between 2 airports.
```bash
dart run bin/dart_graph_example.dart FROM TO [--routes, -r] [--verbose, -v]
```

For example:
```bash
dart run bin/dart_graph_example.dart PHX LOS
```

Expected output:
```bash
Calculating the optimal route from "PHX" to "LOS"

++++++++++++++++++++++++++++++++++++++++++
The optimal route is PHX - JFK - LOS
++++++++++++++++++++++++++++++++++++++++++
```

### Optional flags
**--routes (-r)** - will print used graph at the beginning, which contains the routes. 

**--verbose (-v)** - will print more info at each step of the search.