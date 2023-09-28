
class DangKiMuonSachModel {
  final String userId;
  final String? dkmsId;
  final String userName;
  final String mssv;
  final String email;
  final List<String> books;
  final String ngayDK;
  final String ngayMuon;
  final String ngayTra;

  DangKiMuonSachModel(
      {required this.userId,
        this.dkmsId,
        required this.userName,
        required this.mssv,
        required this.email,
        required this.books,
        required this.ngayDK,
        required this.ngayMuon,
        required this.ngayTra});

  factory DangKiMuonSachModel.fromJson(Map<String, dynamic> json) {
    return DangKiMuonSachModel(
        userId : json['userId'],
        dkmsId : json['dkmsId'] ?? "",
        userName : json['userName'],
        mssv : json['mssv'],
        email : json['email'],
        books : json['books'].cast<String>(),
        ngayDK : json['ngayDK'],
        ngayMuon : json['ngayMuon'],
        ngayTra : json['ngayTra'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // dkmsId tu dong create
    data['userId'] = userId;
    data['userName'] = userName;
    data['mssv'] = mssv;
    data['email'] = email;
    data['books'] = books;
    data['ngayDK'] = ngayDK;
    data['ngayMuon'] = ngayMuon;
    data['ngayTra'] = ngayTra;
    return data;
  }
}
