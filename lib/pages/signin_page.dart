import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/pages/home_page.dart';
import 'package:notepad/pages/signup_page.dart';
import 'package:notepad/services/auth_service.dart';
import 'package:notepad/services/prefs_service.dart';
import 'package:notepad/utils/toast_util.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);
  static final  String id = "signIn_page";

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  doLogIn(){

    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if(email.isEmpty || password.isEmpty) return  Utils.fireToast("Check your email or password");

    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser)
    });
  }
  _getFirebaseUser(FirebaseUser firebaseUser) async{
    if(firebaseUser != null){
      await Prefs.savUserId(firebaseUser.uid);
      print(firebaseUser.toString());
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast("Check your email or password");
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
                image: AssetImage("assets/images/succes.jpg"),
                fit: BoxFit.cover,
              )
            ),
          ),
          SizedBox(height: 20,),
          Text("Welcome back!", style: TextStyle(color: Colors.blueAccent, fontSize: 30,fontWeight:  FontWeight.bold),),
          SizedBox(height: 10,),
          Text("Log in to your account with your information!", style: TextStyle(color: Colors.blueAccent),),
          SizedBox(height: 45,),
          textField(hintText: "Email", controller: emailController, isHiddenPassword: false),
          SizedBox(height: 30,),
          textField(hintText: "Password", controller: passwordController, isHiddenPassword: true),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left: 250),
            child: TextButton(
              onPressed: (){

              },
              child: Text("Forgot Password"),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: doLogIn,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              height: 55,
              width: double.infinity,
              child: Center(child: Text("Log in".toUpperCase(), style: TextStyle(fontSize: 25, color: Colors.blueAccent, fontWeight: FontWeight.bold),)),
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
                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                  },
                  child: Text("SIGN UP", style: TextStyle(fontWeight: FontWeight.bold),),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Widget textField({hintText, controller, isHiddenPassword }){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black38)
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
