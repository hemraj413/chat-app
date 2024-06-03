import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPart extends StatefulWidget {
  const SignupPart({super.key});

  @override
  State<SignupPart> createState() => _SignupPartState();
}

class _SignupPartState extends State<SignupPart> {
  String errMsg = '';
  

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void onTap()async{

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
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
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Full name"),
            hintText: "You can't change it later"
          ),
        ),
        const SizedBox(height: 10,),
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
            child:const Text("Signup", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),),
            
          ),
        )
        

      ],

    );
  }
}