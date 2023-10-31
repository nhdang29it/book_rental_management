import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quan_ly_thu_vien/models/danh_gia_sach_model.dart';
import 'package:quan_ly_thu_vien/pages/data_managers/danh_gia_sach_manager.dart';
import 'package:quan_ly_thu_vien/pages/data_managers/yeu_thich_manager.dart';
import '../models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/books_cart.dart';
import '../components/rating_widget.dart';
import '../components/review_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({required this.book,super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/bookDetail", "bot_nav_idx": 6};

  final BookModel book;

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {



  final currentUser = FirebaseAuth.instance.currentUser!;
  final YeuThichManager yeuThichManager = YeuThichManager();
  final TextEditingController moTaController = TextEditingController();
  final DanhGiaSachManager danhGiaSachManager = DanhGiaSachManager();

  double ratingScore = 3.0;
  bool isFavorite = false;

  @override
  void initState(){
    yeuThichManager.layYeuThich(widget.book.id!).then((value){
      setState(() {
        isFavorite = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sách"),
        actions: [

          IconButton(
            onPressed: ()async{
              yeuThichManager.toggleYeuThich(widget.book).then((value) {
                setState(() {
                  isFavorite = value;
                });
              });
            },
            icon:Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          ),


        ],
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child){
          final books = ref.read(bookCartProvider.notifier);
          return FloatingActionButton.extended(
            onPressed: (){
              // them sach vao gio hang
              if(books.addBook(widget.book)) {
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
              widget.book.url ?? "https://cdn2.iconfinder.com/data/icons/books-16/26/books002-512.png",
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
                "${widget.book.title}",
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

            BookRating(bookId: widget.book.id ?? "null",),

            const SizedBox(height: 20,),
            Text(
                "Loại sách: ${widget.book.type}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
            ),
            Text("Tác giả: ${widget.book.author}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),),
            Text("Vị trí: ${widget.book.viTri ?? "chưa có thông tin"}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),),
            const Divider(),
            const Text("MÔ TẢ", style: TextStyle(fontWeight: FontWeight.bold),),
            // Text(book.description ?? "Chưa có mô tả", maxLines: 6, overflow: TextOverflow.ellipsis, softWrap: true,),
            ReadMoreText(
              widget.book.description ?? "chua co mo ta",
              trimLines: 5,
              trimMode: TrimMode.Length,
              trimCollapsedText: 'Xem thêm',
              trimExpandedText: ' ẩn bớt',
              moreStyle: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500
              ),
              lessStyle: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w500
              ),
            ),
            const Divider(),

            const SizedBox(height: 5,),
            const Text(
                "Viết đánh giá",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16
              ),
            ),
            TextField(
              readOnly: true,
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    builder: (context){
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 12,
                      right: 12,
                      top: 24
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Số sao"),
                        ),
                        RatingBar.builder(
                          initialRating: ratingScore,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          updateOnDrag: false,
                          onRatingUpdate: (rating) {
                            ratingScore = rating;
                          },
                        ),
                        const SizedBox(width: 5,),
                        const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text("Đánh giá của bạn"),
                        ),
                        TextField(
                          controller: moTaController,
                        ),
                        const SizedBox(height: 5,),
                        TextButton(
                          onPressed: () async {

                            final data = await FirebaseFirestore.instance.collection("userProfile").doc(currentUser.uid).get();
                            final mssv = data.get("mssv");

                            DanhGiaSachModel dgs = DanhGiaSachModel(
                              id: "${currentUser.uid}${widget.book.id}",
                                userId: currentUser.uid,
                                userName: currentUser.displayName ?? "chua co ten",
                                mssv: mssv.toString(),
                                bookId: widget.book.id ?? "chua co id",
                                tenSach: widget.book.title.toString(),
                                danhGia: moTaController.text,
                                rating: ratingScore
                            );

                            // print(dgs.toJson());

                            danhGiaSachManager.danhGiaSach(dgs).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Đã đánh giá sách!!"),
                              ));
                              moTaController.clear();
                              Navigator.pop(context);
                            });

                          },
                          child: const Text("Thêm đánh giá"),
                        ),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  );
                });
              },
              decoration: InputDecoration(
                hintText: "Đánh giá của bạn...",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.notes, color: Colors.grey.shade400,),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade400,
                  fontSize: 14
                )
              ),
            ),
            const SizedBox(height: 20,),
            ReviewBook(bookId: widget.book.id!),
            const Divider(),
            const Text("bình luận..."),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
