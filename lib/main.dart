import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'home_page.dart';
// import 'second_page.dart';
// import 'forgot_password_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Navigation Demo',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(),
//         '/second': (context) => SecondPage(),
//         '/third' : (context) => ForgotPasswordPage(),
//       },
//     );
//   }
// }
