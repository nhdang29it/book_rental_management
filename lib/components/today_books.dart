import 'package:flutter/material.dart';
import '../contrast/style.dart';
// import 'book.dart';

class TodayBooks extends StatelessWidget {
  const TodayBooks({super.key});

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
                "Luận văn".toUpperCase(),
              style: myTextStyle(context)
            ),
          ),
          Text("Sach"),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       for(var i = 1; i <= 10; i++) avtBook(context)
          //     ],
          //   ),
          // ),

          const SizedBox(height: 5,),
        ],
      ),
    );
  }
}
