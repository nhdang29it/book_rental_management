import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/models/tai_lieu_model.dart';
import 'package:quan_ly_thu_vien/pages/searchs/search_luan_van.dart';
import 'package:quan_ly_thu_vien/providers/network_provider.dart';
import 'package:quan_ly_thu_vien/services/elastic_search.dart';
// import 'package:url_launcher/url_launcher.dart';


class LuanVanScreen extends ConsumerWidget {
  const LuanVanScreen({super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/luanVan", "bot_nav_idx": 9};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final netWork = ref.watch(networkProvider);
    final elastic = ElasticService(baseUrl: "${netWork.host}:${netWork.port}",  index: "pdf_indexing", type: "_search");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Luận văn"),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: SearchLuanVan(network: netWork.copyWith(newIndex: "pdf_indexing")));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: FutureBuilder(
        future: elastic.getAllLuanVan(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(child: Text("Đã có lỗi xảy ra"),);
          }
          if(snapshot.hasData){
            final data = snapshot.data['hits']['hits'] as List<dynamic>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data['hits']['total']['value'],
                itemBuilder: (BuildContext context, int index) {
                  final json = data[index]["_source"];
                  json["id"] = data[index]["_id"];
                  final TaiLieuModel taiLieu = TaiLieuModel.fromJson(json);
                  return Card(
                    child: ListTile(
                      title: Text("${taiLieu.file!.filename}", style: const TextStyle(fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis,),
                      leading: Image.asset("assets/images/luan-van.jpg"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tác giả: ${taiLieu.meta!.author}"),
                          Text("Kích thước: ${(taiLieu.file!.filesize!/1024).roundToDouble()} KB"),
                          Text("Loại file: ${taiLieu.file!.extension}"),
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, "/luanVanDetail", arguments: taiLieu);
                      },
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
