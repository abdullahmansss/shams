import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/chat/chat_screen.dart';
import 'package:flutter_app/modules/settings/settings_screen.dart';
import 'package:flutter_app/modules/users/users_screen.dart';
import 'package:flutter_app/shared/components/components.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  Map data = {};
  List myChats = [];

  @override
  void initState() {
    super.initState();

    updateStatus();
    getRealTimeData();
    getMyChats();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: GestureDetector(
          onTap: () {
            navigateTo(
              context,
              SettingsScreen(),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                child: Image(
                  image: data['image'] == null ? NetworkImage('https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png') : NetworkImage(data['image']),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                'Chat App',
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'My Chats',
              style: blackBold16(),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (myChats.length > 0)
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index)
                    {
                      if(myChats[index]['id'] != FirebaseAuth.instance.currentUser.uid)
                        return buildItem(myChats[index]);
                      else
                        return Container();
                    },
                    separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    itemCount: myChats.length,
                  ),
                if (myChats.length == 0)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(
            context,
            UsersScreen(),
          );
        },
        child: Icon(
          Icons.edit,
        ),
      ),
    );
  }

  Widget buildItem(item) => InkWell(
    onTap: () {
      navigateTo(
        context,
        ChatScreen(item['id']),
      );
    },
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30.0,
                child: Image(
                  image: NetworkImage(
                    item['image'],
                  ),
                ),
              ),
              if (item['status'] == 'online')
                CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Colors.green,
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item['first_name']} ${item['last_name']}',
                  style: blackBold16(),
                ),
                Text(
                  '${item['phone']}',
                  style: grey14(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  void getMyChats()
  {
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('chats').snapshots().listen((event) {
      print(event.docs.length);
      myChats = event.docs;

      setState(() {});
    });
  }

  void getRealTimeData()
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        data = event.data();
      });
    });
  }

  void updateStatus()
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'status': 'online',
    }).then((value) {
      //getData();
      print('success');
    }).catchError((error) {
      print(error.toString());
    });
  }
}
