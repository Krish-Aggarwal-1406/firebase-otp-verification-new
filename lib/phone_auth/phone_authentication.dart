// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'otp_screen.dart';
//
// class PhoneAuth extends StatefulWidget {
//   const PhoneAuth({super.key});
//
//   @override
//   State<PhoneAuth> createState() => _PhoneAuthState();
// }
//
// class _PhoneAuthState extends State<PhoneAuth> {
//   TextEditingController phoneController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Authentication'),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25),
//             child: TextField(
//               keyboardType: TextInputType.phone,
//               controller: phoneController,
//               decoration: InputDecoration(
//                   suffixIcon: Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   hintText: 'Enter Phone Number'),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 await FirebaseAuth.instance.verifyPhoneNumber(
//                     verificationCompleted: (PhoneAuthCredential credential) {},
//                     verificationFailed: (FirebaseAuthException ex) {},
//                     codeSent: (String verificationId, int? resendToken) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   OtpScreen(verificationId: verificationId)));
//                     },
//                     codeAutoRetrievalTimeout: (String verificationId) {},
//                     phoneNumber: phoneController.text.toString());
//               },
//               child: Text('Send OTP'))
//         ],
//       ),
//     );
//   }
// }
