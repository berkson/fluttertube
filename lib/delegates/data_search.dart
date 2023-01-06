import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((value) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder<List>(
            future: suggestions(query),
            builder: (context, snapshot) {
              return (snapshot.data == null || snapshot.data!.isEmpty)
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]),
                          leading: const Icon(Icons.play_arrow),
                          onTap: () {
                            close(context, snapshot.data![index]);
                          },
                        );
                      },
                    );
            },
          );
  }

  Future<List> suggestions(String search) async {
    final String url =
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[1].map((value) {
        return value[0];
      }).toList();
    } else {
      throw Exception("Failed to load suggestions.");
    }
  }
}
