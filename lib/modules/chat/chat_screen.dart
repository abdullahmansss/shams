import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  String id;

  ChatScreen(this.id);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map data = {};
  List messagesList = [];
  var messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getRealTimeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              child: Image(
                image: NetworkImage(
                  data['image'] ??
                      'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png',
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data['first_name']} ${data['last_name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${data['status']}',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.phone,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.video_call,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (messagesList.length > 0)
                  ListView.builder(
                    itemBuilder: (context, index) {
                      if (messagesList[index]['id'] ==
                          FirebaseAuth.instance.currentUser.uid)
                        return myItem(messagesList[index]);
                      else
                        return userItem(messagesList[index]);
                    },
                    itemCount: messagesList.length,
                  ),
                if (messagesList.length == 0)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      border: Border.all(
                        color: Colors.grey[300],
                        width: 1.0,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'enter message ...'),
                      maxLines: null,
                      onChanged: (s) {
                        if (s.length > 0) {
                          updateStatus('typing ...');
                        }

                        if (s.length == 0) {
                          updateStatus('online');
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    createChat();
                    sendMessage(messageController.text);
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void createChat() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .doc(data['id'])
        .set(data)
        .then((value) {
      print('success');

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('chats')
          .doc(data['id'])
          .set(data)
          .then((value) {
        print('success');
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  void sendMessage(String message) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .doc(data['id'])
        .collection('messages')
        .add({
      'message': message,
      'id': FirebaseAuth.instance.currentUser.uid,
      'image':
          'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png',
    }).then((value) {
      print('success');
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getMessages() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .doc(data['id'])
        .collection('messages')
        .orderBy(
          'iii',
          descending: true,
        )
        .snapshots()
        .listen((event) {
      print('list =====> ${event.docs.length}');
      messagesList = event.docs;

      setState(() {});
    });
  }

  void updateStatus(String status) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'status': status,
    }).then((value) {
      //getData();
      print('success');
    }).catchError((error) {
      print(error.toString());
    });
  }

  Widget userItem(item) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 17.0,
              child: Image(
                image: NetworkImage(item['image']),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    15.0,
                  ),
                  bottomRight: Radius.circular(
                    15.0,
                  ),
                  topLeft: Radius.circular(
                    0.0,
                  ),
                  topRight: Radius.circular(
                    15.0,
                  ),
                ),
              ),
              padding: EdgeInsets.all(
                10.0,
              ),
              child: Text(
                '${item['message']}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget myItem(item) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    15.0,
                  ),
                  bottomRight: Radius.circular(
                    15.0,
                  ),
                  topLeft: Radius.circular(
                    15.0,
                  ),
                  topRight: Radius.circular(
                    0.0,
                  ),
                ),
              ),
              padding: EdgeInsets.all(
                10.0,
              ),
              child: Text(
                '${item['message']}',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );

  void getRealTimeData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      setState(() {
        data = event.data();

        getMessages();
      });
    });
  }
}
