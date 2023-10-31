import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';

class YeuThichManager {
  final CollectionReference yeuThichCollection = FirebaseFirestore.instance.collection("YeuThich");
  final User user = FirebaseAuth.instance.currentUser!;

  Future<void> themYeuThich(BookModel book) async {
    yeuThichCollection.doc(user.uid+book.id!).set({
      "userId": user.uid,
      "bookId": book.id!,
      "title": book.title!,
      "img": book.url!,
      "yeuThich": true
    });
  }


  Future<List<Map<String, dynamic>>> danhSachYeuThich() async {
    final dsyt = await yeuThichCollection.where("userId", isEqualTo: user.uid).get();
    return dsyt.docs.map((e) => e.data() as Map<String, dynamic>).toList();
  }

  Stream<QuerySnapshot<Object?>> dsytStream() {
    return yeuThichCollection.where("userId", isEqualTo: user.uid).snapshots();
  }

  Future<bool> layYeuThich(String bookId) async {
    final yt = await yeuThichCollection.where("userId", isEqualTo: user.uid).where("bookId", isEqualTo: bookId).get();

    if(yt.docs.isEmpty) return false;

    return yt.docs.first.get("yeuThich");
  }

  Future<bool> toggleYeuThich(BookModel book) async {
    final yt = await yeuThichCollection.where("userId", isEqualTo: user.uid).where("bookId", isEqualTo: book.id!).get();

    if(yt.docs.isEmpty){
      await themYeuThich(book);
      return true;
    } else{
      final isFav = yt.docs.first.get("yeuThich") as bool;
      yeuThichCollection.doc(user.uid+book.id!).update({
        "yeuThich": !isFav
      });
      return !isFav;
    }
  }

  Future<void> xoaYeuThich(String documentId)async{
    yeuThichCollection.doc(documentId).delete();
  }

}