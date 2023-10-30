import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/pages/search_page.dart';
import 'package:quan_ly_thu_vien/providers/elastic_search_provider.dart';
import 'package:quan_ly_thu_vien/providers/network_provider.dart';
import 'package:quan_ly_thu_vien/services/elastic_search.dart';

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
                showSearch(context: context, delegate: SearchPageDelegate(label: myArg["label"], network: network));
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
          future: esService.getBookByType(myArg["type"] ?? "lt"),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("Da co loi xay ra"));
            }
            if(snapshot.hasData){

              print(snapshot.data['hits']['total']['value']);

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
                    return Container(
                      color: Colors.blueGrey,
                      height: 300,
                      child: Text("$index"),
                    );
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
