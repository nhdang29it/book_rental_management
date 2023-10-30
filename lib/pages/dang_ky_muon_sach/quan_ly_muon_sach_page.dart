import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/models/dang_ki_muon_sach_model.dart';
import '../data_managers/dang_ki_muon_sach_manager.dart';
import '../../contrast/expansion_list_tile_style.dart';

class QuanLyMuonSachPage extends StatefulWidget {
  const QuanLyMuonSachPage({super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/dangKyMuonSach", "bot_nav_idx": 7};

  @override
  State<QuanLyMuonSachPage> createState() => _QuanLyMuonSachPageState();
}

class _QuanLyMuonSachPageState extends State<QuanLyMuonSachPage> {

  final dkms = DangKiMuonSachManager();
  int sort = -1;
  String sortField = "trangThai";

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý mượn sách"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushReplacementNamed(context, "/dangKyMuonSach/muonSach");
        },
        label: const Row(
          children: [
            Text("Đăng kí mượn "),
            Icon(
              Icons.book_outlined
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: dkms.getAllDkms(),
          builder: (context, snapshot){

            if(snapshot.connectionState == ConnectionState.waiting ){
              return const Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasError){
              return const Center(child: Text("Đã có lỗi xảy ra"),);
            }

            if(snapshot.hasData && snapshot.data!.isNotEmpty){

              final List<DangKiMuonSachModel> data = snapshot.data!;

              data.sort((a, b){
                return a.timestamp!.compareTo(b.timestamp!) * sort; // - : decrease, + : increase
              });

              return ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownMenu(
                        initialSelection: sort,
                        width: 140,
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(
                              value: 1,
                              label: "Cũ nhất"
                          ),
                          DropdownMenuEntry(
                              value: -1,
                              label: "Mới nhất"
                          )
                        ],
                        onSelected: (value){
                          setState(() {
                            sort = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  for(final result in data)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      child: ExpansionTile(
                        leading: const Icon(Icons.notes),
                        title: Text("Đơn mượn sách ĐK ngày : ${result.ngayDK}"),
                        backgroundColor: Colors.grey[300],
                        shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        collapsedShape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        collapsedBackgroundColor: listPropertyExpansionTile[int.parse(result.trangThai)]["collapsedBackgroundColor"],
                        subtitle: Text("${result.books.length} sách"),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text("Ngày mượn: ${result.ngayMuon}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text("Ngày trả: ${result.ngayTra}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              listPropertyExpansionTile[int.parse(result.trangThai)]["trangThai"].toString(),
                              style: TextStyle(
                                color: listPropertyExpansionTile[int.parse(result.trangThai)]["textColor"],
                              ),
                            ),
                          ),
                          for(final book in result.books)
                          ListTile(
                            title: Text("Tên sách: ${book.title}"),
                            subtitle: Text("Tác giả: ${book.author}"),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: result.trangThai == "0" ? (){
                                dkms.xoaDangKiMuon(result.dkmsId!).then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Xóa thành công")));
                                  Navigator.pop(context);
                                });
                              } : null,
                              child: const Text("Xóa", style: TextStyle(color: Colors.red),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 45,)



                ],
              );
            } else {
              return const Center(child: Text("Chưa có dữ liệu"),);
            }
          },
        ),
      ),
    );
  }
}
