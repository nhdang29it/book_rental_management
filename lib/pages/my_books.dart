import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quan_ly_thu_vien/models/network_model.dart';
import 'package:quan_ly_thu_vien/pages/data_managers/yeu_thich_manager.dart';
// import 'package:quan_ly_thu_vien/pages/search_page.dart';
// import 'package:quan_ly_thu_vien/providers/network_provider.dart';
import '../components/bottom_nav_bar.dart';

class MyBooks extends ConsumerWidget {
  const MyBooks({super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/myBook", "bot_nav_idx": 1};

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // NetWorkConfigure network = ref.watch(networkProvider);
    final YeuThichManager yeuThichManager = YeuThichManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sách của tôi"),
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       showSearch(context: context, delegate: SearchPageDelegate(network: network, types: []));
        //     },
        //     icon: const Icon(Icons.search),
        //   ),
        //   // Icon(Icons.library_books_outlined),
        //   const SizedBox(width: 5,)
        // ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: myProperty["bot_nav_idx"]),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: yeuThichManager.dsytStream(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text("Đã có lỗi xảy ra"),);
            }
            if(snapshot.hasData) {

              final ds = snapshot.data!.docs;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 250
                ),
                itemCount: ds.length,
                itemBuilder: (context, index) {

                  final book = ds[index].data() as Map<String, dynamic>;
                  book["id"] = ds[index].id;

                  return InkWell(
                    onTap: () async {
                      // Navigator.pushNamed(context, "/bookDetail", arguments: book);
                    },
                    splashColor: Colors.blueGrey,
                    highlightColor: Colors.blueGrey,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: Colors.green.shade50.withOpacity(0.9),
                      ),
                      height: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          Image.network(
                            book["img"],
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${book["title"]}",
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
