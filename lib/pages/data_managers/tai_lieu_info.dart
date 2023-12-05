import 'package:cloud_firestore/cloud_firestore.dart';

class TaiLieuInfo{
  final CollectionReference luanVanInfoCollection = FirebaseFirestore.instance.collection("LuanVanInfo");

  Future<Map<String, dynamic>> getTaiLieuInfo(String id) async {
    final data = await luanVanInfoCollection.doc(id).get();
    return data.data() as Map<String, dynamic>;
  }
}