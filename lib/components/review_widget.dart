import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/pages/data_managers/danh_gia_sach_manager.dart';


class ReviewBook extends StatelessWidget {
  const ReviewBook({required this.bookId ,super.key});

  final String bookId;

  @override
  Widget build(BuildContext context) {

    final DanhGiaSachManager dgs = DanhGiaSachManager();

    return FutureBuilder(
      future: dgs.getDanhGiaSach(bookId),
      builder: (context, snapshot){
        if(snapshot.hasError) {
          return const Text("Đã có lỗi xảy ra");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          final data = snapshot.data;

          if(data!.isEmpty) return const Text("Chưa có đánh giá...");

          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for(final rv in data) Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 12,),
                      CircleAvatar(
                        backgroundColor: Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        child: Text(rv.userName[0].toUpperCase()),
                      ),
                      const SizedBox(width: 12,),
                      Text(rv.userName),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  ListTile(
                    title: Text("Review: ${rv.danhGia}"),
                    subtitle: Row(
                      children: [
                        Text(rv.rating.toString()),
                        const SizedBox(width: 5,),
                        const Icon(Icons.star, color: Colors.amber,)
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        }

        return const Text("Chưa có review");
      },
    );
  }
}
