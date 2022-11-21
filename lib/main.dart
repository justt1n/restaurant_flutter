import 'package:flutter/material.dart';
import 'package:restaurant/pages/login_page.dart';
import 'package:restaurant/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  final firebaseService = FirebaseService();

  final List burgeritems = [];
  get_data() async {
    final Future<List> fsBurgeritems = firebaseService.getProduct('products');
    burgeritems.add(fsBurgeritems);
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
