import 'package:firebase_services/email_auth/auth_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Splash Screen",
              style: TextStyle(color: Colors.blue, fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
