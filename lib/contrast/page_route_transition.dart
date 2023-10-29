import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quan_ly_thu_vien/models/book_model.dart';
import '../pages/export_pages.dart';

PageTransition pageRouteTransition(RouteSettings settings){
  switch (settings.name) {
    case '/myBook':
      return PageTransition(
          child: const MyBooks(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
      );
    case '/myAccount':
      return PageTransition(
          child: const MyAccount(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100)
      );
    case '/networkConfig':
      return PageTransition(
          child: const NetWorkConfigPage(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300)
      );
    case '/editProfile':
      return PageTransition(
          child: const EditProfile(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500)
      );
    case '/seeMore':
      return PageTransition(
          child: SeeMoreScreen(myArg: settings.arguments! as Map<String, dynamic>),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 500)
      );
    case '/bookDetail':
      return PageTransition(
          child: BookDetailScreen(book: settings.arguments as BookModel),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300)
      );
    case '/dangKyMuonSach':
      return PageTransition(
          child: const QuanLyMuonSachPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300)
      );
    case '/dangKyMuonSach/muonSach':
      return PageTransition(
          child: const DangKyMuonSachScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300)
      );
    default:
      return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100)
      );
  }
}