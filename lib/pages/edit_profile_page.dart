import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_thu_vien/models/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



final groupGender = StateProvider<bool>((ref) => true); // true false gender radio button state provider

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  static const Map<String, dynamic> myProperty = {
    "routeName": "/editProfile",
    "bot_nav_idx": 5
  };

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa thông tin"),
      ),
      body: const EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    User user = FirebaseAuth.instance.currentUser!;
    final userProfileRef = FirebaseFirestore.instance.collection("userProfile").doc(user.uid)
        .withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
        toFirestore: (userProfile, _) => userProfile.toJson()
    );


    TextEditingController displayNameController = TextEditingController();
    displayNameController.text = user.displayName ?? "";
    TextEditingController ageController = TextEditingController();
    TextEditingController numberPhoneController = TextEditingController();
    TextEditingController lopController = TextEditingController();
    TextEditingController mssvController = TextEditingController();


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
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                user.email!.isNotEmpty ? user.email! : "Your email",
                style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: displayNameController,
              decoration: const InputDecoration(
                label: Text(
                    'Tên: ',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              onSubmitted: (value){
                displayNameController.text = value;
              },
            ),
            const SizedBox(height: 6),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(height: 25),

            FutureBuilder(
              future: userProfileRef.get(),
              builder: (context, snapshot){

                if(!snapshot.hasData){
                  return const CircularProgressIndicator();
                }else {
                  UserProfile userProfile = snapshot.data!.data()!;
                  ageController.text = userProfile.age ?? "";
                  numberPhoneController.text = userProfile.numberPhone ?? "";
                  lopController.text = userProfile.lop ?? "";
                  mssvController.text = userProfile.mssv ?? "";

                  return Column(
                    children: [
                      TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text(
                              'Tuổi: ',
                              style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),

                        ),
                        onSubmitted:(value){
                          ageController.text = value;
                        },
                      ),

                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                              'Giới tính: ',
                              style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Consumer(
                            builder: (context, ref, child){
                              final grGenderWatch = ref.watch(groupGender);
                              return Row(
                                children: [
                                  Radio(
                                      value: true,
                                      groupValue: grGenderWatch,
                                      onChanged: (value){
                                        if(value != null){
                                          ref.read(groupGender.notifier).state = value;
                                        }
                                      }
                                  ),
                                  const Text("nam"),
                                  Radio(
                                      value: false,
                                      groupValue: grGenderWatch,
                                      onChanged: (value){
                                        if(value != null){
                                          ref.read(groupGender.notifier).state = value;
                                        }
                                      }
                                  ),
                                  const Text("nữ")
                                ],

                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 25),

                      TextField(
                        controller: numberPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          label: Text(
                              'Số điện thoại: ',
                              style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),

                        ),
                        onSubmitted:(value){
                          numberPhoneController.text = value;
                        },
                      ),
                      const SizedBox(height: 25),

                      TextField(
                        controller: lopController,
                        decoration: const InputDecoration(
                          label: Text(
                              'Lớp: ',
                              style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),

                        ),
                        onSubmitted:(value){
                          lopController.text = value;
                        },
                      ),
                      const SizedBox(height: 25),

                      TextField(
                        controller: mssvController,
                        decoration: const InputDecoration(
                          label: Text(
                              'MSSV: ',
                              style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),

                        ),
                        onSubmitted:(value){
                          mssvController.text = value;
                        },
                      ),
                      const SizedBox(height: 25),

                    ],
                  );
                }
              },
            ),

            Consumer(
              builder: (context, ref, child){

                return Center(
                  child: ElevatedButton(
                    onPressed: ()async{
                      userProfileRef.update(
                          {
                            "gender": ref.read(groupGender.notifier).state,
                            "age": ageController.text.toString(),
                            "phone": numberPhoneController.text,
                            "lop": lopController.text,
                            "mssv": mssvController.text
                          }
                      );
                      await user.updateDisplayName(displayNameController.text);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cập nhật thành công")));
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cập nhật"),
                  ),
                );
              },
            ),
            const SizedBox(height: 25,)


          ],
        ),
      ),
    );
  }
}

