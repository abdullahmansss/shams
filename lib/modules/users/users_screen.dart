import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/chat/chat_screen.dart';
import 'package:flutter_app/shared/components/components.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List users = [];

  @override
  void initState() {
    super.initState();

    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Users',
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (users.length > 0)
            ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index)
              {
                if(users[index]['id'] != FirebaseAuth.instance.currentUser.uid)
                  return buildItem(users[index]);
                else
                  return Container();
              },
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              itemCount: users.length,
            ),
          if (users.length == 0)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
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

  void getUsers()
  {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      print(event.docs.length);
      users = event.docs;

      setState(() {});
    });
  }
}
