import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePgae extends StatelessWidget {
  const HomePgae({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            

          }, child: const Icon(Icons.logout))
        ],),
    );
  }
}