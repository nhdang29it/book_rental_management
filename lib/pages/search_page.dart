import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';
import '../services/elastic_search.dart';
import '../models/network_model.dart';


class SearchPageDelegate extends SearchDelegate {

  final String? label;
  final NetWorkConfigure network;
  final List<String> types;


  SearchPageDelegate({this.label, required this.network, required this.types}) : super (
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

    ElasticService esClient = ElasticService(baseUrl: "${network.host}:${network.port}", index: network.index, type: "_search");


    return FutureBuilder(
      future: esClient.searchBooks(query: query, listTypeBook: types),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(),);
        } else {
          var data = jsonDecode(utf8.decode(snapshot.data!.bodyBytes));
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: _buildResults(data["hits"]["hits"], context),
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
        title: const Text("python"),
        trailing: const Icon(Icons.access_time_outlined),
        onTap: (){
          query = "python";
        },
      ),
      ListTile(
        title: const Text("html"),
        onTap: (){
          query = "html";
        },
      ),
      ListTile(
        title: const Text("Lập trình"),
        onTap: (){
          query = "lập trình";
        },
      ),
      ListTile(
        title: Text("code"),
        onTap: (){
          query = "code";
        },
      ),
    ];
  }

  List<Widget> _buildResults (List<dynamic> listData, BuildContext context) {

    if(listData.isEmpty){
      return [
        const ListTile(
          title: Text("Không có dữ liệu"),
        )
      ];
    }


    return listData.map((element){

      final data = element["_source"];
      data["id"] = element["_id"];

      final BookModel book = BookModel.fromJson(data);


      return InkWell(
        onTap: (){
          Navigator.pushNamed(context, "/bookDetail", arguments: book);
        },
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  book.url ?? "https://nhatminhad.net/files/assets/idesign-nhung-thiet-ke-bia-sach-dep-nhat-danh-cho-nam-2018-09.jpg",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  height: 110,
                  width: 70,
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          book.title ?? "ten sach: null",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                      ),
                      const SizedBox(height: 10,),
                      Text("Author: ${book.author ?? "no name"}", softWrap: true,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

}

