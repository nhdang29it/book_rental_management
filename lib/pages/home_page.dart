import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/components/drawer.dart';
import 'package:quan_ly_thu_vien/components/all_book.dart';
import 'package:quan_ly_thu_vien/components/bottom_nav_bar.dart';
import '../models/network_model.dart';
import '../providers/network_provider.dart';
import 'search_page.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/", "bot_nav_idx": 0};

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    NetWorkConfigure network = ref.watch(networkProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: SearchPageDelegate(label: "Tìm kiếm sách", network: network));
            },
            icon: const Icon(Icons.search),
          ),
          // Icon(Icons.library_books_outlined),
          const SizedBox(width: 5,)
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Colors.grey.shade300,
      drawer: const MyDrawer(),
      bottomNavigationBar: MyBottomNavBar(currentIndex: myProperty["bot_nav_idx"]),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: ListView(
          children: const [
            AllBook(),
            SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}
