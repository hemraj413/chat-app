import 'package:chat_app/auth/components/continue_google.dart';
import 'package:chat_app/auth/login.dart';
import 'package:chat_app/auth/signup.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLogin = true;

  void changeLoginState(){
    setState(() {
      isLogin =!isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.2,),  
              const Icon(Icons.messenger, size: 60,),//might change later
              const SizedBox(height: 30,),
              isLogin?const LoginPart():const SignupPart(),
              const SizedBox(height: 10,),
              const Text("or"),
              const SizedBox(height: 10,),

              const ContinueGoogle(),
              SizedBox(height: MediaQuery.of(context).size.height*.1,), 

              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isLogin?"Don't have an account?":"Already have an Account?"),
                  TextButton(onPressed: (){
                    changeLoginState();
                  }, child: Text(isLogin?"Register":"Login now"))
                ],
              )
                  
            ],
                    ),
        ),
      ),
    );
  }
}