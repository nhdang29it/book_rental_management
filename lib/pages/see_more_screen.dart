import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/pages/search_page.dart';
import 'package:quan_ly_thu_vien/providers/network_provider.dart';

class SeeMoreScreen extends StatelessWidget {
  const SeeMoreScreen({required this.myArg ,super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/seeMore", "bot_nav_idx": 3};
  final Map<String, dynamic> myArg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myArg["label"]),
        actions: [
          Consumer(builder: (context, ref, child){
            final network = ref.watch(networkProvider);
            return IconButton(
              onPressed: (){
                showSearch(context: context, delegate: SearchPageDelegate(label: myArg["label"], network: network));
              },
              icon: const Icon(Icons.search),
            );
          }),
          // Icon(Icons.library_books_outlined),
          const SizedBox(width: 5,)
        ],
      ),
    );
  }
}