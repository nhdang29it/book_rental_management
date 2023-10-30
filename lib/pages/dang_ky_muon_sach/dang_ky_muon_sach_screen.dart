import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/models/dang_ki_muon_sach_model.dart';
import 'package:quan_ly_thu_vien/pages/data_managers/user_profile_manager.dart';
import '../../providers/books_cart.dart';
import '../data_managers/dang_ki_muon_sach_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DangKyMuonSachScreen extends StatelessWidget {
  const DangKyMuonSachScreen({super.key});

  static const Map<String, dynamic> myProperty = {
    "routeName": "/dangKyMuonSach/muonSach",
    "bot_nav_idx": 8
  };

  @override
  Widget build(BuildContext context) {
    final DangKiMuonSachManager dkms = DangKiMuonSachManager();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final UserProfileManager userProfileManager = UserProfileManager();

    final dateTimeNow = DateTime.now();
    final TextEditingController ngayMuonController = TextEditingController();
    final TextEditingController ngayTraController = TextEditingController();
    DateTime ngayMuon = dateTimeNow;
    DateTime ngayTra = dateTimeNow;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng ký mượn sách"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final books = ref.watch(bookCartProvider);

          if (books.isEmpty) return const Center(child: Text("Hãy thêm sách"));

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                for (final book in books)
                  Card(
                    child: ListTile(
                      leading: Image.network(
                        book.url!
                      ),
                      title: Text("${book.title}"),
                      subtitle: Text("id: ${book.id}"),
                      trailing: IconButton(
                        onPressed: () {
                          ref.read(bookCartProvider.notifier).deleteBook(book);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Tổng cộng: ${books.length} sách",
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 14, color: Colors.black38),
                ),
                TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text("Xóa danh sách mượn?"),
                        content: Text("Bạn có muốn xóa ${books.length} sách không?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              ref.read(bookCartProvider.notifier).clearCart();
                              Navigator.pop(context);
                            },
                            child: const Text(
                                "Đồng ý",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Hủy",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    });
                  },
                  child: const Text("Xóa tất cả"),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ngayMuonController,
                  onTap: () async {
                    DateTime? muon = await showDatePicker(
                        context: context,
                        initialDate: dateTimeNow,
                        firstDate: dateTimeNow,
                        lastDate: dateTimeNow.add(const Duration(days: 14)));

                    if (muon != null) {
                      ngayMuon = muon;
                      ngayMuonController.text =
                          "${muon.day}-${muon.month}-${muon.year}";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText: "dd-MM-yyyy",
                    labelText: "Chọn ngày mượn",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ngayTraController,
                  onTap: () async {
                    DateTime? tra = await showDatePicker(
                        context: context,
                        initialDate: ngayMuon.add(const Duration(days: 1)),
                        firstDate: ngayMuon.add(const Duration(days: 1)),
                        lastDate: ngayMuon.add(const Duration(days: 14)));

                    if (tra != null) {
                      ngayTra = tra;
                      ngayTraController.text =
                          "${tra.day}-${tra.month}-${tra.year}";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText: "dd-MM-yyyy",
                    labelText: "Chọn ngày trả",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shadowColor: Colors.red.shade200,
                  surfaceTintColor: Colors.red.shade300,
                  elevation: 3.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Thông tin đăng kí mượn sách".toUpperCase(), style: const TextStyle(
                          fontWeight: FontWeight.w500
                        ),),
                        const SizedBox(height: 10,),
                        infoTileRow(label: "ID user:", value: currentUser!.uid),
                        const SizedBox(height: 5,),
                        infoTileRow(label: "Tên:", value: currentUser.displayName!),
                        const SizedBox(height: 5,),
                        infoTileRow(label: "Email:", value: currentUser.email!),
                        const SizedBox(height: 5,),
                        infoTileRow(label: "Ngày đăng kí:", value: "${dateTimeNow.day}-${dateTimeNow.month}-${dateTimeNow.year}"),
                        const SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    final value = await dkms.kiemTraMuon();
                    if(!value){
                      if(ngayTra.isBefore(ngayMuon)){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ngày trả phải sau ngày mượn!!")));
                      } else {
                        final user = await userProfileManager.getUserProfile();
                        dkms
                            .dangKiMuon(DangKiMuonSachModel(
                            userId: currentUser.uid,
                            userName: currentUser.displayName!,
                            mssv: user.mssv!,
                            email: currentUser.email!,
                            books: books,
                            ngayDK:
                            "${dateTimeNow.day}-${dateTimeNow.month}-${dateTimeNow.year}",
                            trangThai: "0",
                            ngayMuon: ngayMuonController.text,
                            ngayTra: ngayTraController.text), datetime: dateTimeNow)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đăng ký thành công")));
                          Navigator.pop(context);
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bạn không thể đăng ký")));
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.shade700,
                    shadowColor: Colors.greenAccent.shade400,
                    elevation: 2.5
                  ),
                  child: const Text("Đăng kí", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 1
                  ),),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          );
        },
      ),
    );
  }
}



Row infoTileRow({required String label, required String value}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
        flex: 4,
        child: Text(label, textAlign: TextAlign.end,style: const TextStyle(
          fontWeight: FontWeight.w500
        ),)
    ),
    const SizedBox(width: 5,),
    Expanded(
        flex: 9,
        child: Text(value)
    ),
  ],
);
