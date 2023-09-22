import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
          duration: const Duration(milliseconds: 400)
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
    default:
      return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100)
      );
  }
}