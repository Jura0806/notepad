import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/pages/home_page.dart';
import 'package:notepad/pages/signin_page.dart';
import 'package:notepad/services/auth_service.dart';
import 'package:notepad/services/prefs_service.dart';
import 'package:notepad/utils/toast_util.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);
  static final String id = "signUp_page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  doSignUp(){

    String name = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if(name.isEmpty || email.isEmpty || password.isEmpty) return  Utils.fireToast("Check your Informations!");

    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser)
    });
  }
  _getFirebaseUser(FirebaseUser firebaseUser)  async{
    if(firebaseUser != null){
      await Prefs.savUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast("Check your Informations!");
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(
          children: [
            Container(
              height: size / 1.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30)),
                  // color: Colors.green,
                  image: DecorationImage(
                    image: AssetImage("assets/images/notes.jpg"),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            SizedBox(height: 20,),
            Text("Let's Get Started!", style: TextStyle(color: Colors.blueAccent, fontSize: 30,fontWeight:  FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Create your own account!", style: TextStyle(color: Colors.blueAccent),),
            SizedBox(height: 45,),
            textField(hintText: "FullName", controller: fullNameController,isHiddenPassword: false),
            SizedBox(height: 30,),
            textField(hintText: "Email", controller: emailController, isHiddenPassword: false),
            SizedBox(height: 30,),
            textField(hintText: "Password", controller: passwordController, isHiddenPassword: true),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: doSignUp,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 100),
                height: 55,
                width: double.infinity,
                child: Center(child: Text("Sign Up".toUpperCase(), style: TextStyle(fontSize: 25, color: Colors.blueAccent, fontWeight: FontWeight.bold),)),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(65),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(6,2),
                        spreadRadius: 3,
                        blurRadius: 6,
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                      ),
                      BoxShadow(
                        offset: Offset(-3,-3),
                        spreadRadius: 3,
                        blurRadius: 6,
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                      )
                    ]
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, SignInPage.id);
                    },
                    child: Text("LOG IN", style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
  Widget textField({hintText, controller , isHiddenPassword}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
            hintStyle: TextStyle(color: Colors.black38),
        ),
        obscureText: isHiddenPassword,
      ),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(6,2),
              spreadRadius: 3,
              blurRadius: 6,
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            BoxShadow(
              offset: Offset(-3,-3),
              spreadRadius: 3,
              blurRadius: 6,
              color: Color.fromRGBO(255, 255, 255, 0.9),
            )
          ]
      ),
    );
  }
}
