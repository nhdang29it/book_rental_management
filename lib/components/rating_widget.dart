import 'package:flutter/material.dart';
import '../pages/data_managers/danh_gia_sach_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class BookRating extends StatelessWidget {
  const BookRating({required this.bookId, super.key});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    final DanhGiaSachManager danhGiaSachManager = DanhGiaSachManager();
    return FutureBuilder(
      future: danhGiaSachManager.getBookRatingById(bookId),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("0.0"),
              const SizedBox(width: 5,),
              RatingBarIndicator(
                itemBuilder: (context, index){
                  return const Icon(Icons.star, color: Colors.amber,);
                },
                itemCount: 5,
                rating: 0,
                itemSize: 30,
              ),
              const SizedBox(width: 5,),
              const Text("(?)")
            ],
          );
        }

        if(snapshot.hasError) return const Center(child: Text("Chưa có đánh giá"),);

        if(snapshot.hasData && snapshot.data!.isNotEmpty){

          final data = snapshot.data;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${data!["ratingScore"]}"),
              const SizedBox(width: 5,),
              RatingBarIndicator(
                itemBuilder: (context, index){
                  return const Icon(Icons.star, color: Colors.amber,);
                },
                itemCount: 5,
                rating: data["ratingScore"],
                itemSize: 30,
              ),
              const SizedBox(width: 5,),
              Text("(${data["soLuotDanhGia"]})")
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 5,),
              RatingBarIndicator(
                itemBuilder: (context, index){
                  return const Icon(Icons.star, color: Colors.amber,);
                },
                itemCount: 5,
                rating: 0,
                itemSize: 30,
              ),
              const SizedBox(width: 5,),
              const Text("(0)")
            ],
          );
        }
      },
    );
  }
}
