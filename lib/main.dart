import 'package:axact_studios/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child:CircularProgressIndicator());
        }else if(snapshot.hasError){
          return Center(child:Text("Firebase initialization error"));
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),);
      }
    );
  }
}

