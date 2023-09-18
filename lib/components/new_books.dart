import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';
import '../contrast/style.dart';
import 'book.dart';
import '../providers/books_provider.dart';

class NewBooks extends ConsumerWidget {
  const NewBooks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<BookModel> books = ref.watch(booksProvider);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  "Sách mới nhất".toUpperCase(),
                  style: myTextStyle(context)
                ),
              ),
              TextButton(
                onPressed: (){},
                child: const Text("Xem thêm"),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // for(var i = 1; i <= 3; i++) avtBook(context),
                for(var book in books) avtBook(context, book: book)
              ],
            ),
          ),
          const SizedBox(height: 5,),
        ],
      ),
    );
  }
}
