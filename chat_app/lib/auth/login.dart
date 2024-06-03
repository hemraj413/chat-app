import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPart extends StatefulWidget {
  const LoginPart({super.key});

  @override
  State<LoginPart> createState() => _LoginPartState();
}

class _LoginPartState extends State<LoginPart> {
  String errMsg ='';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onTap()async{
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      setState(() {
        errMsg = e.code.toString();
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            
            label: Text("Email Address")
          ),
        ),
        const SizedBox(height: 10,),
            TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            
            label: Text("password")
          ),
          obscureText: true,
        ),
        Text(errMsg,style: const TextStyle(color: Colors.red),),
        const SizedBox(height:20,),
    
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width*.35,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Colors.black
            ),
            child:const Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),),
            
          ),
        )
        
    
      ],
    
    );
  }
}