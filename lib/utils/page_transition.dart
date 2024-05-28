import 'package:flutter/material.dart';
import 'package:banko/pages/login/login_screen.dart';
import 'package:banko/pages/home/home_screen.dart';
import 'package:banko/pages/pix/pix_screen.dart';
import 'package:banko/pages/pix/transferencia/transfer_screen.dart';
import 'package:banko/pages/pix/transferencia/comprovante.dart';
import 'package:banko/pages/quote/quote_screen.dart';


PageRouteBuilder buildPageRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route<dynamic>? routes(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return buildPageRoute(LoginScreen(), settings);
    case '/home':
      return buildPageRoute(HomeScreen(), settings);
    case '/pix':
      return buildPageRoute(PixScreen(), settings);
    case '/transfer':
      return buildPageRoute(TransferScreen(), settings);
    case '/comprovante':
      final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return buildPageRoute(
        ComprovanteScreen(
          amount: args['amount']!,
          cpf: args['cpf']!,
        ),
        settings,
      );
    case '/quote':
      return buildPageRoute(QuoteScreen(), settings);
    default:
      return buildPageRoute(LoginScreen(), settings);
  }
}
