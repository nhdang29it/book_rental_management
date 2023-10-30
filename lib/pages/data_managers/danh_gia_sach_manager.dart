import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_thu_vien/models/danh_gia_sach_model.dart';

class DanhGiaSachManager {
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("DanhGiaSach");

  Future<Map<String, dynamic>> getBookRatingById(String bookId) async {
    final Map<String, dynamic> rating = <String,dynamic>{};
    // rating: {
    //  "soLuotDanhGia": 1,
    //  "ratingScore": 4.5
    // }
    final List<DanhGiaSachModel> dsDanhGiaSach = [];
    final QuerySnapshot danhGiaSachSnapshot = await collectionReference.where("bookId", isEqualTo: bookId ).get();
    rating["soLuotDanhGia"] = danhGiaSachSnapshot.docs.length;
    for (final document in danhGiaSachSnapshot.docs) {
      DanhGiaSachModel dgs = DanhGiaSachModel.fromJson(document.data() as Map<String,dynamic>);
      dsDanhGiaSach.add(dgs);
    }
    rating["ratingScore"] = _ratingAverage(dsDanhGiaSach);
    return rating;
  }

  Future<void> danhGiaSach(DanhGiaSachModel dgs) async {
    collectionReference.doc(dgs.id!).set(dgs.toJson());
  }
  
  Future<DanhGiaSachModel> getUserRating(String id, String bookId) async {
    final userRating = await collectionReference.doc(id+bookId).get();

    final dgs = DanhGiaSachModel(
        userId: userRating.get("userId"),
        userName: userRating.get("userName"),
        mssv: userRating.get("mssv"),
        bookId: userRating.get("bookId"),
        tenSach: userRating.get("tenSach"),
        rating: userRating.get("rating")
    );

    return dgs;
  }

  Future<List<DanhGiaSachModel>> getDanhGiaSach(String bookId) async {
    final List<DanhGiaSachModel> dsDanhGiaSach = [];
    final QuerySnapshot danhGiaSachSnapshot = await collectionReference.where("bookId", isEqualTo: bookId ).get();

    for(final document in danhGiaSachSnapshot.docs){
      DanhGiaSachModel dgs = DanhGiaSachModel.fromJson(document.data() as Map<String,dynamic>);
      dsDanhGiaSach.add(dgs);
    }

    return dsDanhGiaSach;
  }

  double _ratingAverage(List<DanhGiaSachModel> ds) {
    double ratingAverage = 0;
    for(final danhGia in ds){
      ratingAverage += danhGia.rating;
    }
    return ratingAverage == 0 ? 0 : ratingAverage/ds.length;
  }

}