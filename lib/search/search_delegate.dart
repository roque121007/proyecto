import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [Text("Build action")];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Text("build leading");
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("builc result");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("Build suggestion");
  }
}
