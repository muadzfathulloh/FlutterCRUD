import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_3/views/detail_screen.dart';
import 'package:flutter_3/views/edit_screen.dart';
import 'package:flutter_3/views/form_screen.dart';
import 'package:flutter_3/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/detail-screen': (context) => DetailScreen(),
        '/form': (context) => FormScreen(),
        '/form-edit': (context) => EditScreen(),
      },
    );
  }
}
