import 'package:flutter/material.dart';
import '../models/book_model.dart';


Widget avtBook (BuildContext ctx, {BookModel? book}){

  book ??= BookModel();

  return GestureDetector(
    onTap: (){
      Navigator.pushNamed(ctx, "/bookDetail", arguments: book);
      // print(book!.toJson());
    },
    child: Container(
      width: MediaQuery.of(ctx).size.width * 0.3,
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          const SizedBox(height: 5,),
          Text(
            book.title ?? "Tên sách",
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            book.description ?? "chua co mo ta",
            maxLines: 3,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10,),
        ],
      ),
    ),
  );
}