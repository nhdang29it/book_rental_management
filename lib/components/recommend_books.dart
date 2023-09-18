import 'package:flutter/material.dart';
import 'book.dart';
import '../contrast/style.dart';

class RecommendBooks extends StatelessWidget {
  const RecommendBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              "Sách nên đọc".toUpperCase(),
              style: myTextStyle(context)
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for(var i = 1; i <= 10; i++) avtBook(context)
              ],
            ),
          ),
          const SizedBox(height: 5,),
        ],
      ),
    );
  }
}
