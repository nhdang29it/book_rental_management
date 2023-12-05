import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quan_ly_thu_vien/components/drawer.dart';
import 'package:quan_ly_thu_vien/components/all_book.dart';
import 'package:quan_ly_thu_vien/components/bottom_nav_bar.dart';
import 'package:quan_ly_thu_vien/components/thong_bao_trang_chu.dart';
// import 'package:quan_ly_thu_vien/models/book_model.dart';
import '../models/network_model.dart';
import '../providers/network_provider.dart';
import 'searchs/search_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const Map<String, dynamic> myProperty = {
    "routeName": "/",
    "bot_nav_idx": 0
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NetWorkConfigure network = ref.watch(networkProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Trang chủ"),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchPageDelegate(
                        label: "Tìm kiếm sách", network: network, types: []));
              },
              icon: const Icon(Icons.search),
            ),
            // Icon(Icons.library_books_outlined),
            const SizedBox(
              width: 5,
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        backgroundColor: Colors.grey.shade300,
        drawer: const MyDrawer(),
        bottomNavigationBar:
            MyBottomNavBar(currentIndex: myProperty["bot_nav_idx"]),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: ListView(
            children: const [
              ThongBaoTrangChu(),
              AllBook(label: "Sách lập trình", type: "lt",),
              SizedBox(
                height: 10,
              ),
              AllBook(label: "Sách Kĩ năng lập trình", type: "kn",),
              SizedBox(
                height: 10,
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     final book = BookModel(
              //         title: "sach 2",
              //         description:
              //             "Cách đối nhân xử thế luôn được coi là chuẩn mực đánh giá sự khéo léo, thông minh của một con người. Bạn có dám khẳng định rằng cách hành xử của mình luôn khiến mọi người xung quanh cảm thấy hài lòng? Bản thân tôi thì không! Đôi khi muốn hành động, cư xử một cách hoàn hảo lại là chuyện vô cùng khó. Theo thời gian tính cách của con người sẽ thay đổi, sự trưởng thành sẽ giúp họ nhận ra đối nhân xử thế là môn học mà bạn phải luôn học hỏi hàng ngày, học hỏi cả đời. Tôi thường băn khoăn làm sao để mỗi ngày trôi qua sẽ là một nấc thang đưa tôi đến thành công và có được cái nhìn thiện cảm của người khác đối với mình. Cho đến khi tôi chạm tay đến cuốn sách đã thay đổi cuộc sống của biết bao người, cuốn sách có tầm ảnh hưởng nhất mọi thời đại “ĐẮC NHÂN TÂM”.",
              //         type: "khoa hoc",
              //         author: "dang",
              //         id: "book1");
              //     Navigator.pushNamed(context, "/bookDetail", arguments: book);
              //   },
              //   child: Text("book detail"),
              // ),
            ],
          ),
        ));
  }
}
