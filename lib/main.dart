import 'package:flutter/material.dart';
import 'package:banko/utils/page_transition.dart'; // Importa o novo arquivo

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'banko',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: routes,
    );
  }
}
