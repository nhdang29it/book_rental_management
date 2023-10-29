import 'package:flutter/material.dart';
import '../models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/books_cart.dart';
import '../components/rating_widget.dart';
import '../components/review_widget.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({required this.book,super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/bookDetail", "bot_nav_idx": 6};

  final BookModel book;


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sách"),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child){
          final books = ref.read(bookCartProvider.notifier);
          return FloatingActionButton.extended(
            onPressed: (){
              // them sach vao gio hang
              if(books.addBook(book)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Đã thêm vào danh sách mượn"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, "/dangKyMuonSach/muonSach");
                    },
                    label: "Đến trang Đăng kí mượn",
                  ),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(milliseconds: 1500), content: Text("Không thể thực hiện!!!")));
              }

            },
            label: const Text("Đăng kí mượn sách"),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Image.network(
              book.url ?? "https://cdn2.iconfinder.com/data/icons/books-16/26/books002-512.png",
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              // width: 100,
              height: size.height * 0.3,
            ),
            const SizedBox(width: 10,),
            Text(
                "${book.title}",
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                wordSpacing: 1.5
              ),
            ),
            const SizedBox(height: 15,),

            BookRating(bookId: book.id ?? "null",),

            const SizedBox(height: 20,),
            Text(
                "Loại sách: ${book.type}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
            ),
            Text("Tác giả: ${book.author}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),),
            Text("Vị trí: ${book.viTri ?? "chưa có thông tin"}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),),
            const Divider(),
            const Text("MÔ TẢ", style: TextStyle(fontWeight: FontWeight.bold),),
            Text(book.description ?? "Chưa có mô tả", maxLines: 6, overflow: TextOverflow.ellipsis, softWrap: true,),
            const Divider(),
            ReviewBook(bookId: book.id!),
            const Divider(),
            const Text("bình luận..."),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
