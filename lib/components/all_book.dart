import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';
import 'package:quan_ly_thu_vien/providers/elastic_search_provider.dart';
import '../contrast/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'book.dart';

class AllBook extends StatelessWidget {
  const AllBook({super.key});

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
                    "Sách lập trình".toUpperCase(),
                  style: myTextStyle(context)
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/seeMore", arguments: {
                      "label": "Sách lập trình"
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
                final snapshot = ref.watch(allBookProvider);

                return snapshot.when(
                    data: (snapshot){
                      List<dynamic> listBook = snapshot["hits"]["hits"];
                      List<BookModel> list = listBook.map((e) => BookModel.fromJson(e["_source"])).toList();

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(final book in list) avtBook(context, book: book)
                          ],
                        ),
                      );
                    },
                    error: (_,err){
                      return const Text("Đã có lỗi xảy ra. Hãy kiểm tra lại thông tin cài đặt mạng!!"
                      ,style: TextStyle(color: Colors.red),);
                    },
                    loading: () => const CircularProgressIndicator()
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
