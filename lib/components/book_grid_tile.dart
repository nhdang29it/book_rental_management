
import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';


class BookGridTile extends StatelessWidget {
  const BookGridTile({required this.book,super.key});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, "/bookDetail", arguments: book);
      },
      splashColor: Colors.blueGrey,
      highlightColor: Colors.blueGrey,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.green.shade50.withOpacity(0.9),

        ),
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5,),
            Image.network(
              book.url!,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${book.title}",
                maxLines: 3,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
