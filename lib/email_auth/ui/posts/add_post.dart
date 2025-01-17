import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/email_auth/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class AddPostScreen extends StatefulWidget {

  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final databaseRef = FirebaseFirestore.instance.collection('posts');
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Add Post'),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(
                loading: loading,
                title: "Add",
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  databaseRef.add({
                    'title': postController.text.toString(),
                    'id': DateTime.now().millisecondsSinceEpoch.toString()
                  }).then((value) {
                    Utils().toastMessage('Post added');
                    setState(() {
                      loading = false;
                    });
                  }).catchError((error) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                }
            )
          ],
        ),
      ),
    );
  }
}
