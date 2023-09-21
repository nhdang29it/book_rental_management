import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_thu_vien/models/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController displayNameController = TextEditingController(text: FirebaseAuth.instance.currentUser!.displayName ?? "" );
  TextEditingController ageController = TextEditingController();
  TextEditingController numberPhoneController = TextEditingController();
  TextEditingController lopController = TextEditingController();
  TextEditingController mssvController = TextEditingController();
  bool gender = true;
  bool onUpdate = false;


  Future<void> updateProfile() async {
    User user = FirebaseAuth.instance.currentUser!;
    final userProfileRef = FirebaseFirestore.instance.collection("userProfile").doc(user.uid);
    setState(() {
      onUpdate = true;
    });
    await userProfileRef.update(
        {
          "gender": gender,
          "age": ageController.text.toString(),
          "phone": numberPhoneController.text,
          "lop": lopController.text,
          "mssv": mssvController.text
        }
    );
    await user.updateDisplayName(displayNameController.text);
  }

  @override
  void initState(){
    super.initState();
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection("userProfile").doc(user.uid).withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
        toFirestore: (userProfile, _) => userProfile.toJson()
    ).get()
      .then((snapshot){
      UserProfile userProfile = snapshot.data()!;
      ageController.text = userProfile.age ?? "";
      numberPhoneController.text = userProfile.numberPhone ?? "";
      lopController.text = userProfile.lop ?? "";
      mssvController.text = userProfile.mssv ?? "";
      setState(() {
        gender = userProfile.gender;
      });
    });
  }

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

            Column(
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
                    Radio(
                        value: true,
                        groupValue: gender,
                        onChanged: (value){
                          if(value != null){
                            setState(() {
                              gender = value;
                            });
                          }
                        }
                    ),
                    const Text("nam"),
                    Radio(
                        value: false,
                        groupValue: gender,
                        onChanged: (value){
                          if(value != null){
                            setState(() {
                              gender = value;
                            });
                          }
                        }
                    ),
                    const Text("nữ")
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
            ),

            Center(
              child: ElevatedButton(
                onPressed: ()async{
                  updateProfile().then((value){
                    setState(() {
                      onUpdate = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Cập nhật thành công"),
                          backgroundColor: Colors.green,
                          duration: Duration(milliseconds: 1500),
                        )
                    );
                    Navigator.of(context).pop();
                  });

                },
                child: onUpdate ? const CircularProgressIndicator() : const Text("Cập nhật"),
              ),
            ),
            const SizedBox(height: 25,)

          ],
        ),
      ),
    );
  }
}

