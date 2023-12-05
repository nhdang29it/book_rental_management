import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';
import 'package:quan_ly_thu_vien/pages/searchs/search_page.dart';
import 'package:quan_ly_thu_vien/providers/elastic_search_provider.dart';
import 'package:quan_ly_thu_vien/providers/network_provider.dart';

import '../components/book_grid_tile.dart';

class SeeMoreScreen extends StatelessWidget {
  const SeeMoreScreen({required this.myArg ,super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/seeMore", "bot_nav_idx": 3};
  final Map<String, dynamic> myArg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myArg["label"]),
        actions: [
          Consumer(builder: (context, ref, child){
            final network = ref.watch(networkProvider);
            return IconButton(
              onPressed: (){
                showSearch(context: context, delegate: SearchPageDelegate(
                    label: myArg["label"],
                    network: network,
                    types: myArg["type"] != null ? [myArg["type"]] : []
                ));
              },
              icon: const Icon(Icons.search),
            );
          }),
          // Icon(Icons.library_books_outlined),
          const SizedBox(width: 5,)
        ],
      ),
      body: Consumer(builder: (context, ref, child){
        final esService = ref.watch(elasticSearchProvider);

        return FutureBuilder(
          // future: esService.getBookByType(myArg["type"] ?? "lt"),
          future: esService.getBookByFilter(listFilter: myArg["listFilters"]),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("Đã có lỗi xảy ra"));
            }
            if(snapshot.hasData){
              final listData = snapshot.data['hits']['hits'] as List<dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 250
                  ),
                  itemCount: snapshot.data['hits']['total']['value'],
                  itemBuilder: (BuildContext context, int index) {
                    final json = listData[index]["_source"];
                    json["id"] = listData[index]["_id"];
                    final BookModel book = BookModel.fromJson(json);
                    return BookGridTile(book: book,);
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        );
      },),
    );
  }
}
