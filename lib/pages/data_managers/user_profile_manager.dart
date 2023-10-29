import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_profile.dart';

class UserProfileManager {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("userProfile");

  Future<UserProfile> getUserProfile() async {
      final userFuture = await userCollection.doc(user!.uid).get();
      print(userFuture);
      return UserProfile.fromJson(userFuture.data() as Map<String,dynamic>);
  }
}