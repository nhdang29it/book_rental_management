import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_thu_vien/models/dang_ki_muon_sach_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DangKiMuonSachManager {

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("DangKiMuonSach");
  final User user = FirebaseAuth.instance.currentUser!;

  Future<List<DangKiMuonSachModel>> getAllDkms()async { // lay tat ca cac don dang ki muon sach
    final List<DangKiMuonSachModel> dkms = [];
    final QuerySnapshot querySnapshot = await collectionReference.where("userId", isEqualTo: user.uid).get();

    for (var element in querySnapshot.docs) {
      final result = element.data() as Map<String, dynamic>;
      result["dkmsId"] = element.id;
      result['timestamp'] = (result['timestamp'] as Timestamp).toDate();

      dkms.add(DangKiMuonSachModel.fromJson(result));
    }

    return dkms;
  }

  Future<bool> kiemTraMuon() async {
    final data = await collectionReference.where("userId", isEqualTo: user.uid ).where("trangThai", whereIn: ["0", "1", "3"]).get();
    return data.docs.isEmpty ? false : true;
  }


  Future<void> dangKiMuon(DangKiMuonSachModel dkms, {DateTime? datetime}) async {
    final data = dkms.toJson();
    if(data["trangThai"] == null) {
      data["trangThai"] = "0";
    }
    if(datetime != null) {
      data["timestamp"] = datetime;
    }
    await collectionReference.add(data);
  }

  Future<void> xoaDangKiMuon(String id) async {
    await collectionReference.doc(id).delete();
  }

  Future<DangKiMuonSachModel> getByDkmsId(String id) async {
    final DocumentSnapshot documentSnapshot = await collectionReference.doc(id).get();
    final Map<String, dynamic> data = documentSnapshot.data as Map<String, dynamic>;
    data["dkmsId"] = documentSnapshot.id; // them truong 'id dang ki muon sach' trong data
    return DangKiMuonSachModel.fromJson(data);
  }

}