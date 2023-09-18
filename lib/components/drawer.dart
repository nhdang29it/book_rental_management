import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_thu_vien/pages/export_pages.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green.shade600,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=2000",
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                    user.displayName ?? "chua co ten",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("Liên hệ, phản hồi"),
            onTap: (){},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: Text("Thể loại sách".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold),),
          ),
          ListTile(
            title: const Text("Sách tiếng việt"),
            onTap: (){},
          ),
          ListTile(
            title: const Text("Sách tiếng anh"),
            onTap: (){},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: Text("Luận văn".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold),),
          ),
          ListTile(
            title: const Text("Luận văn KHMT"),
            onTap: (){},
          ),
          ListTile(
            title: const Text("Luận văn CNTT"),
            onTap: (){},
          ),
          ListTile(
            title: const Text("Luận văn HTTT"),
            onTap: (){},
          ),
          ListTile(
            title: const Text("Network configure"),
            onTap: ()  {
              Navigator.of(context).pushNamed(NetWorkConfigPage.myProperty["routeName"]);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Đăng xuất"),
            trailing: const Icon(Icons.logout_outlined),
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
