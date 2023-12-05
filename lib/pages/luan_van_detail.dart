import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/models/tai_lieu_model.dart';
import 'package:quan_ly_thu_vien/pages/data_managers/tai_lieu_info.dart';
// import 'package:quan_ly_thu_vien/providers/network_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';

class LuanVanDetail extends StatelessWidget {
  const LuanVanDetail({required this.taiLieu, super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/luanVanDetail", "bot_nav_idx": 10};

  final TaiLieuModel taiLieu;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết tài liệu"),
      ),
      body: FutureBuilder(
        future: TaiLieuInfo().getTaiLieuInfo(taiLieu.id!),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(child: Text("Da co loi xay ra"),);
          }
          if(snapshot.hasData){

            final data = snapshot.data;
            final luanvan = taiLieu.copyWith(
              title: data!["title"],
              description: data["description"],
              viTri: data["viTri"],
              language: data["language"]
            );

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  buildMyTile(label: "Tiêu đề", value: luanvan.title.toString()),
                  const Divider(),
                  buildMyTile(label: "Tên file", value: taiLieu.file!.filename!),
                  const Divider(),
                  buildMyTile(label: "Tác giả", value: taiLieu.meta!.author!),
                  const Divider(),
                  buildMyTile(label: "Mô tả", value: luanvan.description.toString()),
                  const Divider(),
                  buildMyTile(label: "Kích thước", value: "${(taiLieu.file!.filesize! / 1024).round()} KB"),
                  const Divider(),
                  buildMyTile(label: "Vị trí lưu trữ", value: luanvan.viTri.toString()),
                  const Divider(),
                  buildMyTile(label: "Ngôn ngữ", value: luanvan.language.toString()),
                  const Divider(),
                  buildMyTile(label: "Ngày tạo", value: formatDate(DateTime.parse(taiLieu.meta!.created!), [dd,'-',mm,'-',yyyy, ' ', HH, ':', nn])),
                  const Divider(),
                  buildMyTile(label: "Chỉnh sửa lần cuối", value: formatDate(DateTime.parse(taiLieu.file!.lastModified!), [dd,'-',mm,'-',yyyy, ' ', HH, ':', nn])),
                  const Divider(),
                  buildMyTile(label: "Loại tài liệu", value: taiLieu.file!.extension!),
                  const Divider(),
                  const SizedBox(height: 20,),
                  Consumer(
                    builder: (context, ref, child){
                      // final netWork = ref.watch(networkProvider);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const ElevatedButton(
                            // onPressed: ()async {
                            //   final Uri url = Uri.parse("http://${netWork.host}:8001/?filename=${taiLieu.file!.filename}");
                            //   if (!await launchUrl(url)) {
                            //     throw Exception('Could not launch $url');
                            //   }
                            //   // print("http://${netWork.host}:8001/?filename=${taiLieu.file!.filename}");
                            // },
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.download_rounded),
                                SizedBox(width: 5,),
                                Text("Tải file pdf"),
                              ],
                            ),
                          ),

                          ElevatedButton(
                            onPressed: (){},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.visibility),
                                SizedBox(width: 5,),
                                Text("Xem tài liệu"),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

Widget buildMyTile({required String label, required String value}){
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Text(
            label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(value),
      )
    ],
  );
}
