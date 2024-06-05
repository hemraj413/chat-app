import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddMsg extends StatefulWidget {
    final String sender;
  final QueryDocumentSnapshot reciever;
  const AddMsg({super.key,required this.reciever,required this.sender});

  @override
  State<AddMsg> createState() => _AddMsgState();
}

class _AddMsgState extends State<AddMsg> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: ()async{
              Navigator.pop(context);
              await FirebaseFirestore.instance.collection("chats").doc(widget.sender).collection("messages").add({
                "msg":_controller.text,
                "sender":widget.sender,
                "reciever":widget.reciever.id
              });
               await FirebaseFirestore.instance.collection("chats").doc(widget.reciever.id).collection("messages").add({
                "msg":_controller.text,
                "sender":widget.sender,
                "reciever":widget.reciever.id
              });
        

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlue
              ),
              child:const Text("send", style: TextStyle(color: Colors.white),),
            ),
          ),

        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration:const InputDecoration(
              hintText: "Message",
              border: InputBorder.none
              
            ),
          )
        ],
      ),
    );
  }
}