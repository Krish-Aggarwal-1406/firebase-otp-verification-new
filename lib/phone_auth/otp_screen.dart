// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class OtpScreen extends StatefulWidget {
//   String verificationId;
//    OtpScreen({super.key, required this.verificationId});
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   TextEditingController otpController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Screen'),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal: 25),
//             child: TextField(
//               keyboardType: TextInputType.phone,
//               controller: otpController,
//               decoration: InputDecoration(
//                   suffixIcon: Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)
//                   ),
//                   hintText: 'Enter Phone Number'
//               ),
//
//             ),
//           ),
//           SizedBox(height: 20,),
//           ElevatedButton(onPressed: (){
//             try{
//               PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otpController.text);
//               FirebaseAuth.instance.signInWithCredential(credential);
//                 }catch(ex){
//             }
//                   }, child: Text('OTP'))
//         ],
//       ),
//     );
//   }
// }
