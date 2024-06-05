
import 'package:chat_app/comp/slide_page_route.dart';
import 'package:chat_app/msg_screen/msg_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePgae extends StatefulWidget {
  const HomePgae({super.key});

  @override
  State<HomePgae> createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            

          }, child: const Icon(Icons.logout))
        ],),
        body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection("users")
      .where("email", isNotEqualTo: _currentUser?.email)
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('No data available'));
    } else {
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          final QueryDocumentSnapshot user = snapshot.data!.docs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, SlideRightPageRoute(page: MsgScreen(reciever:user, sender:_currentUser!.uid,)));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 40),
                      const SizedBox(width: 10), // Added spacing for better UI
                      Text(user["name"]),
                    ],
                  ),
                  const Icon(Icons.man_3),
                ],
              ),
            ),
          );
        },
      );
    }
  },
)

    );
  }
}