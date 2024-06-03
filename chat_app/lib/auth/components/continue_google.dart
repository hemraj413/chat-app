import 'package:chat_app/auth/auth_services.dart';
import 'package:flutter/material.dart';

class ContinueGoogle extends StatelessWidget {
  const ContinueGoogle({super.key});

  @override
  Widget build(BuildContext context) {

    void onTap()async{
      try{
        signInWithGoogle();
      }catch (e){
        debugPrint(e.toString());
      }

    }
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width*.6,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all()
          
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Continue with ", style: TextStyle(fontSize: 20),),
            Image.asset("assets/images/google.png",width: 30,height: 30,),
          ],
        ),
      
      ),
    );
  }
}