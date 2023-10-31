import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';
import '../contrast/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/elastic_search_provider.dart';
import 'book.dart';

class AllBook extends StatelessWidget {
  const AllBook({required this.label, required this.type,super.key});

  final String label, type;

  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: const BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    label.toUpperCase(),
                  style: myTextStyle(context)
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/seeMore", arguments: {
                      "label": label,
                      "type": type,
                      "listFilters": [
                        {
                          "type": type
                        }
                      ]
                    });
                  },
                  child: const Text("Xem thêm"),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Consumer(
              builder: (context, ref, child){
                final esService = ref.watch(elasticSearchProvider);
                return FutureBuilder(
                  future: esService.getBookByType(type),
                  builder: (context ,snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text(
                          "Đã có lỗi xảy ra. Hãy kiểm tra kết nối mạng!",
                        style: TextStyle(
                          color: Colors.red.shade400
                        ),
                      ),);
                    }
                    if(snapshot.hasData){

                      final listBook = snapshot.data['hits']['hits'] as List<dynamic>;
                      List<BookModel> list = listBook.map((e){
                        final Map<String, dynamic> map = e["_source"];
                        map["id"] = e["_id"];

                        return BookModel.fromJson(map);
                      }).toList();


                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(final book in list) avtBook(context, book: book)
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator(),);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 5,),
        ],
      ),
    );
  }
}
