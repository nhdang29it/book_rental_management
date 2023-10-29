class DanhGiaSachModel {
  final String? id;
  final String userId;
  final String userName;
  final String mssv;
  final String bookId;
  final String tenSach;
  final String? danhGia;
  final double rating;

  DanhGiaSachModel(
      {this.id,
      required this.userId,
      required this.userName,
      required this.mssv,
      required this.bookId,
        required this.tenSach,
      this.danhGia,
      required this.rating});

  factory DanhGiaSachModel.fromJson(Map<String, dynamic> json) {
    return DanhGiaSachModel(
        id: json['id'],
        userId: json['userId'] ?? "?",
        userName: json['userName'] ?? "?",
        mssv: json['mssv'] ?? "?",
        bookId: json['bookId'] ?? "?",
        tenSach: json["tenSach"] ?? "?",
        danhGia: json['danhGia'],
        rating: json['rating'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['mssv'] = mssv;
    data['bookId'] = bookId;
    data['tenSach'] = tenSach;
    data['danhGia'] = danhGia ?? "";
    data['rating'] = rating;
    return data;
  }
}
