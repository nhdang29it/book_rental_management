import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book_model.dart';


class BooksNotifier extends StateNotifier<List<BookModel>> {
  BooksNotifier() : super([]){
    fetchBook();
  }

  void addBook(BookModel book){
    state = [...state, book];
  }
  void removeBook(String bookId){
    state = [
      for(final book in state) if(book.id == bookId) book
    ];
  }

  Future<void> fetchBook() async {
    state = [
      BookModel(
          id: "1",
          title: "Dac nhan tam",
          description: "Mô tả ngắn, sadfdsaf masdf ffff ff ss cc vv bb hhh ttt 4 54  yydfhgs sdfg asdf adsf asdfcvx  vxc vv xxx",
          url: "https://salt.tikicdn.com/cache/w400/media/catalog/product/d/a/dacnhantam_2_1_1.jpg"
      ),
      BookModel(
          id: "2",
          title: "Java core",
          description: "Mô tả ngắn, sadfdsaf masdf ffff ff ss cc vv bb hhh ttt 4 54  yydfhgs sdfg asdf adsf asdfcvx  vxc vv xxx",
          url: "https://product.hstatic.net/200000211451/product/61v5jta1dll_6e8969d2f9004826be3e85ff542e2a22_master.jpeg"
      ),
      BookModel(
          id: "3",
          title: "Dac nhan tam 3",
          description: "Mô tả ngắn, sadfdsaf masdf ffff ff ss cc vv bb hhh ttt 4 54  yydfhgs sdfg asdf adsf asdfcvx  vxc vv xxx",
          url: "https://salt.tikicdn.com/cache/w400/media/catalog/product/d/a/dacnhantam_2_1_1.jpg"
      ),
      BookModel(
          id: "4",
          title: "Dac nhan tam 4",
          description: "Mô tả ngắn, sadfdsaf masdf ffff ff ss cc vv bb hhh ttt 4 54  yydfhgs sdfg asdf adsf asdfcvx  vxc vv xxx",
          url: "https://nhatminhad.net/files/assets/idesign-nhung-thiet-ke-bia-sach-dep-nhat-danh-cho-nam-2018-09.jpg"
      )
    ];
  }

}

final booksProvider = StateNotifierProvider<BooksNotifier, List<BookModel>>((ref) {
  return BooksNotifier();
});