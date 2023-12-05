import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/models/tai_lieu_model.dart';

import '../../models/network_model.dart';
import '../../services/elastic_search.dart';


class SearchLuanVan extends SearchDelegate {

  final NetWorkConfigure network;

  SearchLuanVan({required this.network}) : super (
    searchFieldDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16
      ),
      border: InputBorder.none,
    ),
  );

  @override
  String? get searchFieldLabel => "Tìm tài liệu điện tử";

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
      future: esClient.searchLuanVan(query: query),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Center(child: Text("Đã có lỗi xảy ra"),);
        }
        if(snapshot.hasData) {
          var data = jsonDecode(utf8.decode(snapshot.data!.bodyBytes));

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: _buildResults(data["hits"]["hits"], context),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator(),);
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
        title: const Text("Hệ thống quản lý"),
        trailing: const Icon(Icons.access_time_outlined),
        onTap: (){
          query = "hệ thống quản lý";
        },
      ),
      ListTile(
        title: const Text("luận văn khoa học máy tính"),
        onTap: (){
          query = "luận văn khoa học máy tính";
        },
      ),
      ListTile(
        title: const Text("niên luận"),
        onTap: (){
          query = "niên luận";
        },
      ),
      ListTile(
        title: const Text("máy học"),
        onTap: (){
          query = "máy học";
        },
      ),
    ];
  }

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

    final TaiLieuModel taiLieu = TaiLieuModel.fromJson(data);


    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, "/luanVanDetail", arguments: taiLieu);
      },
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                "https://lrcopac.ctu.edu.vn/pages/opac/images/no-thumb/nothumb.jpg",
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
                        taiLieu.file!.filename ?? "ten sach: null",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                    ),
                    const SizedBox(height: 10,),
                    Text("Author: ${taiLieu.meta!.author ?? "no name"}", softWrap: true,),
                    Text("Size: ${taiLieu.file!.filesize ?? "no name"}", softWrap: true,),
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
