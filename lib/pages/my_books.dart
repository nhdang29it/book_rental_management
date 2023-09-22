import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/models/network_model.dart';
import 'package:quan_ly_thu_vien/pages/search_page.dart';
import 'package:quan_ly_thu_vien/providers/network_provider.dart';
import '../components/bottom_nav_bar.dart';

class MyBooks extends ConsumerWidget {
  const MyBooks({super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/myBook", "bot_nav_idx": 1};

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    NetWorkConfigure network = ref.watch(networkProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sách của tôi"),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: SearchPageDelegate(network: network));
            },
            icon: const Icon(Icons.search),
          ),
          // Icon(Icons.library_books_outlined),
          const SizedBox(width: 5,)
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: MyBottomNavBar(currentIndex: myProperty["bot_nav_idx"]),

      body: ListView(
        children: const [
          Text("Chua co sach")
        ],
      ),
    );
  }
}
