import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({required this.book,super.key});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sách"),
      ),
      body: ListView(
        children: [

          Row(
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
                width: 100,
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Ten: ${book.title}"),
                  Text("Ten: ${book.type}"),
                  Text("Ten: ${book.author}"),
                ],
              )
            ],
          ),
          const Divider(),
          const Text("MÔ TẢ", style: TextStyle(fontWeight: FontWeight.bold),),
          Text(book.description ?? "khong co mo ta"),

        ],
      ),
    );
  }
}
