import 'book_model.dart';


class DangKiMuonSachModel {
  final String userId;
  final String? dkmsId;
  final String userName;
  final String mssv;
  final String email;
  final List<BookModel> books;
  final String ngayDK;
  final String ngayMuon;
  final String ngayTra;
  final String trangThai;
  final DateTime? timestamp;

  DangKiMuonSachModel(
      {required this.userId,
        this.dkmsId,
        required this.userName,
        required this.mssv,
        required this.email,
        required this.books,
        required this.ngayDK,
        required this.ngayMuon,
        required this.trangThai,
        required this.ngayTra,
        this.timestamp
      });

  factory DangKiMuonSachModel.fromJson(Map<String, dynamic> json) {

    final data = json["books"] as List<dynamic>;

    return DangKiMuonSachModel(
        userId : json['userId'] ?? "?",
        dkmsId : json['dkmsId'],
        userName : json['userName'] ?? "?",
        mssv : json['mssv'] ?? "?",
        email : json['email'] ?? "?",
        books : data.isEmpty ? [] : data.map((e) => BookModel.fromJson(e as Map<String,dynamic>)).toList(),
        ngayDK : json['ngayDK'] ?? "?",
        ngayMuon : json['ngayMuon'] ?? "?",
        ngayTra : json['ngayTra'] ?? "?",
      trangThai: json['trangThai'] ?? "?",
      timestamp: json['timestamp']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // dkmsId tu dong create
    data['userId'] = userId;
    data['userName'] = userName;
    data['mssv'] = mssv;
    data['email'] = email;
    data['books'] = books.map((e) => e.toJson()).toList();
    data['ngayDK'] = ngayDK;
    data['ngayMuon'] = ngayMuon;
    data['ngayTra'] = ngayTra;
    data['trangThai'] = trangThai;
    return data;
  }
}
