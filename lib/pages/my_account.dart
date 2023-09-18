import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/components/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_thu_vien/models/user_profile.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  static const Map<String, dynamic> myProperty = {
    "routeName": "/myAccount",
    "bot_nav_idx": 2
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin người dùng"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed("/editProfile");
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: const UserProfileScreen(),
      bottomNavigationBar:
          MyBottomNavBar(currentIndex: myProperty["bot_nav_idx"]),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=2000",
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: (){
            //     print(user.uid);
            //   },
            //   child: Text("print"),
            // ),
            const SizedBox(height: 20),
            Center(
              child: Text(user.displayName != null ? user.displayName! : "Your name",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold,

                  )
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                user.email!.isNotEmpty ? user.email! : "Your email",
                style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
              ),
            ),
            const SizedBox(height: 25),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(height: 25),
            FutureBuilder(
              future: FirebaseFirestore.instance.collection("userProfile").doc(user.uid)
                    .withConverter<UserProfile>(
                  fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
                  toFirestore: (userProfile, _) => userProfile.toJson()
              ).get(),
              builder: (context, snapshot){

                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }

                UserProfile userProfile = snapshot.data!.data()!;

                return Column(
                  children: [
                    Row(
                      children: [
                        const Text('Tuổi: ',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(userProfile.age.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(children: [
                      const Text(
                          'Giới tính: ',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(userProfile.gender ? "nam" : "nữ",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))
                    ]),
                    const SizedBox(height: 25),
                    Row(children: [
                      const Text('Số điện thoại: ',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(userProfile.numberPhone ?? "??",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))
                    ]),
                    const SizedBox(height: 25),
                    Row(children: [
                      const Text('Lớp: ',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(userProfile.lop ?? "??",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))
                    ]),
                    const SizedBox(height: 25),
                    Row(children: [
                      const Text('MSSV: ',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(userProfile.mssv ?? "??",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))
                    ])
                  ],
                );
              },
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
