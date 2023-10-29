import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/book_model.dart';

class BookCartNotifier extends StateNotifier<List<BookModel>>{
  BookCartNotifier() : super([]);

  bool addBook(BookModel book){
    final result = state.where((element) => element.id == book.id);
    if( result.isEmpty && state.length < 4){
      state = [...state, book];
      return true;
    } else {
      return false;
    }
  }

  void clearCart(){
    state = [];
  }

  void deleteBook(BookModel book){
    state = [
      for(final b in state) if(book.id! != b.id) b
    ];
  }

}

final bookCartProvider = StateNotifierProvider<BookCartNotifier, List<BookModel>>((ref){
  return BookCartNotifier();
});