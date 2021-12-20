import 'package:chat_online/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async  {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());


 FirebaseFirestore.instance.collection("message").snapshots().listen((dado){
   dado.docs.forEach((element) {
     print(element.data());
   });

  });
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
        primarySwatch: Colors.blueGrey,
        iconTheme: const IconThemeData(
          color:Colors.black
        ),
      ),
      home:  const ChatScreen(),
    );
  }
}
