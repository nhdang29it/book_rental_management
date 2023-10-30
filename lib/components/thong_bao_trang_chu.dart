import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ThongBaoTrangChu extends StatelessWidget {
  const ThongBaoTrangChu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 35,
          color: Colors.white,
        ),
        Container(
            decoration: const BoxDecoration(
                color: Colors.white
            ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.center,
          // height: 40,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("ThongBao").snapshots(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return const Center(child: Text("da co loi xay ra"),);
              }
              if(snapshot.hasData){

                final data = snapshot.data!.docs;


                // return Marquee(
                //   text: data.get("noiDung"),
                //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                //   scrollAxis: Axis.horizontal,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   blankSpace: 25.0,
                //   velocity: 100.0,
                //   pauseAfterRound: const Duration(seconds: 1),
                //   startPadding: 0.0,
                //   accelerationDuration: const Duration(seconds: 1),
                //   accelerationCurve: Curves.linear,
                //   decelerationDuration: const Duration(milliseconds: 500),
                //   decelerationCurve: Curves.easeOut,
                // );

                return CarouselSlider(
                  options: CarouselOptions(
                      // height: 200.0,
                      autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    aspectRatio: 16/8,
                    enlargeCenterPage: true,

                  ),
                  items: data.map((document) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: const BoxDecoration(
                                  color: Colors.greenAccent,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    blurStyle: BlurStyle.normal,
                                    color: Colors.greenAccent
                                  )
                                ]
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('${document.get("noiDung")}',
                                  style: const  TextStyle(
                                      fontSize: 16.0,
                                    color: Colors.indigo
                                  ),
                                ),
                              ))
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
              return const Center(child: Text("Thông báo ....."),);
            },
          ),

        ),
      ],
    );
  }
}
