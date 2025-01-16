import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services/email_auth/ui/posts/post_screen.dart';
import 'package:firebase_services/email_auth/ui/signup_screen.dart';
import 'package:firebase_services/email_auth/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/utils.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading=false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  Future<UserCredential> loginWithGoogle() async {
    final  googleUser = await GoogleSignIn().signIn();
    final  googleAuth = await googleUser!.authentication;
    final  googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await auth.signInWithCredential(googleAuthCredential);
  }
  void login(){
    setState(() {
      loading=true;
    });

    auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
      setState(() {
        loading=false;
      });
    }).onError((error,stackTrace){
      setState(() {
        loading=false;
      });
      Utils().toastMessage(error.toString());

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login Screen"),
            Form(
              key: formKey,
                child: Column(

                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          suffixIcon: Icon(Icons.email)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Email is required";
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: 10,),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(Icons.lock)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Password is required";
                        }
                        return null;
                      },

                    ),
                  ],
                )),
            SizedBox(height: 25,),

            RoundButton(loading: loading,
                title: "Login", onTap: (){
              if(formKey.currentState!.validate()){
                login();
              };
            }),
            SizedBox(height: 15,),
            RoundButton(title: "Sign in with Google", onTap: ()async{
              await loginWithGoogle();
            }),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account?"),
                SizedBox(width: 10,),
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupScreen()));
                  }, child: Text("Sign Up",style: TextStyle(color: Colors.blue),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
