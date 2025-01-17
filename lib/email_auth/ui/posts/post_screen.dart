import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/email_auth/ui/posts/add_post.dart';
import 'package:firebase_services/email_auth/utils/utils.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final CollectionReference ref = FirebaseFirestore.instance.collection('posts');
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  String? selectedDocId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Post Screen"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: ref.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['title']),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: ListTile(
                                      onTap: () {
                                        editController.text = data['title'];
                                        selectedDocId = doc.id;
                                        Navigator.pop(context); // Close the PopupMenu
                                        showMyDialog();
                                      },
                                      title: Text("Edit"),
                                      leading: Icon(Icons.edit),
                                    ),
                                    value: "edit",
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      onTap: () {
                                        ref.doc(doc.id).delete().then((_) {
                                          Utils().toastMessage('Deleted');
                                        }).catchError((error) {
                                          Utils().toastMessage('Deletion failed');
                                        });
                                        Navigator.pop(context);
                                      },
                                      title: Text("Delete"),
                                      leading: Icon(Icons.delete),
                                    ),
                                    value: "edit",
                                  ),
                                ],
                                icon: Icon(Icons.more_vert),
                              ),
                            );
                          },
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Post'),
        content: Container(
          child: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Enter new title',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.doc(selectedDocId).update({'title': editController.text}).then((_) {
                Navigator.pop(context);
                Utils().toastMessage('Updated');
              }).catchError((error) {
                Utils().toastMessage('Updation failed');
              });
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
