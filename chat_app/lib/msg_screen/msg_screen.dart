import 'package:chat_app/comp/slide_page_route.dart';
import 'package:chat_app/msg_screen/add_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MsgScreen extends StatefulWidget {
  final String sender;
  final QueryDocumentSnapshot reciever;
  const MsgScreen({super.key,required this.reciever,required this.sender});

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  // final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciever['email']),
      ),
      // body: Container(
      //   constraints: BoxConstraints(
      //     maxHeight: MediaQuery.of(context).size.height
      //   ),
      //   child: Column(
      //     children: [
           
      //       Row(
      //         children: [
      //           TextField(
      //             controller: _controller,
      //             decoration:const InputDecoration(
      //               border: OutlineInputBorder()
      //             ),
      //           ),
      //           TextButton(onPressed: (){
        
      //           }, child:const Icon(Icons.arrow_upward))
      //         ],
      //       )
      //     ],
      //   ),
      // ),

      body:  Container(
              padding: const EdgeInsets.all(10),
 
              child: StreamBuilder(stream: FirebaseFirestore.instance.collection("chats").doc(widget.sender).collection('messages').where("reciever",isEqualTo:widget.reciever).where("reciever").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder:(context, index) {
                        final QueryDocumentSnapshot msg = snapshot.data!.docs[index];
                        return Container(
                          width: MediaQuery.of(context).size.width*.5,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 147, 221, 255)
                          ),
                          child: Text(msg['msg'], style: const TextStyle(fontSize: 20),));
                      }, 
                      );
                  }else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
                ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, SlideRightPageRoute(page: AddMsg(reciever: widget.reciever, sender: widget.sender)));

              },
              child:const Icon(Icons.add),
            ),
      
    );
  }
}