import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/pages/create_note.dart';
import 'package:notepad/pages/home_page.dart';
import 'package:notepad/pages/signin_page.dart';
import 'package:notepad/pages/signup_page.dart';
import 'package:notepad/services/prefs_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _startPage(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          Prefs.savUserId(snapshot.data.uid);
        return HomePage();
        }else{
          Prefs.removeUserId();
          return SignInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      routes: {
        HomePage.id : (context) => HomePage(),
        SignInPage.id : (context) => SignInPage(),
        SignUpPage.id : (context) => SignUpPage(),
        CreateNote.id : (context) => CreateNote()
      },
    );
  }
}
