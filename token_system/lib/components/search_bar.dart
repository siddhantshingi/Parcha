import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function builder;
  final Function filterSearch;
  final List totalItems;

  SearchBar(
      {Key key, @required this.filterSearch, @required this.totalItems, @required this.builder})
      : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchBar> {
  TextEditingController editingController = TextEditingController();
  List filteredList = [];

  @override
  void initState() {
    filteredList.addAll(widget.totalItems);
    super.initState();
  }

  void _filterSearch(String value) {
    setState(() {
      filteredList.clear();
      filteredList.addAll(widget.filterSearch(widget.totalItems, value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            _filterSearch(value);
          },
          controller: editingController,
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            contentPadding: EdgeInsets.all(2.0),
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
      Builder(
        builder: (BuildContext context) {
          print('Building SearchBar builder');
          if (filteredList == null) {
            return widget.builder(widget.totalItems);
          } else {
            return widget.builder(this.filteredList);
          }
        },
      ),
    ]);
  }
}
