import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/elastic_search.dart';
import '../models/network_model.dart';


class SearchPageDelegate extends SearchDelegate {

  final String? label;
  final NetWorkConfigure network;


  SearchPageDelegate({this.label, required this.network}) : super (
      searchFieldDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
              color: Colors.grey,
            fontSize: 16
          ),
          border: InputBorder.none,
      ),
  );

  @override
  String? get searchFieldLabel {
    return label ?? "Tìm kiếm";
  }

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.black);


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = ''
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    ElasticService esClient = ElasticService(baseUrl: "${network.host}:${network.port}", index: network.index);


    return FutureBuilder(
      future: esClient.searchBooks(query),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(),);
        } else {
          var data = jsonDecode(utf8.decode(snapshot.data!.bodyBytes));
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: _buildResults(data["hits"]["hits"]),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView(
        children: _buildSuggestions(),
      ),
    );
  }


  List<ListTile> _buildSuggestions () {
    return [
      ListTile(
        title: Text(network.host),
        trailing: const Icon(Icons.access_time_outlined),
        onTap: (){
          query = "Gợi ý 1";
        },
      ),
      ListTile(
        title: Text(network.port.toString()),
        onTap: (){
          query = "Gợi ý 2";
        },
      ),
      ListTile(
        title: Text(network.index),
      ),
      ListTile(
        title: Text("Gợi ý 4"),
      ),
    ];
  }

  List<ListTile> _buildResults (List<dynamic> listData) {
    return listData.map((element) => ListTile(
      title: Text(element["_source"]["user"] ?? "no user"),
      subtitle: Text("Tuoi: ${element["_source"]["age"] ?? "0"}"),
    )).toList();
  }

}

