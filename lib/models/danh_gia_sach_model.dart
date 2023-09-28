class DanhGiaSachModel {
  final String? id;
  final String userId;
  final String userName;
  final String mssv;
  final String bookId;
  final String? danhGia;
  final int rating;

  DanhGiaSachModel(
      {this.id,
      required this.userId,
      required this.userName,
      required this.mssv,
      required this.bookId,
      this.danhGia,
      required this.rating});

  factory DanhGiaSachModel.fromJson(Map<String, dynamic> json) {
    return DanhGiaSachModel(
        id: json['id'] ?? "",
        userId: json['userId'],
        userName: json['userName'],
        mssv: json['mssv'],
        bookId: json['bookId'],
        danhGia: json['danhGia'],
        rating: json['rating']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['mssv'] = mssv;
    data['bookId'] = bookId;
    data['danhGia'] = danhGia;
    data['rating'] = rating;
    return data;
  }
}
