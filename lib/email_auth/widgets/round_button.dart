import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  bool loading;
  final String title;
  final VoidCallback onTap;
  RoundButton({super.key,required this.title,required this.onTap,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading?CircularProgressIndicator(color: Colors.white,):Text(title,style: TextStyle(color: Colors.white,fontSize: 18),),
        ),
      ),
    );
  }
}
