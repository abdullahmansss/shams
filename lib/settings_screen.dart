import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/register_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool push = false;
  bool email = false;

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging().configure(onMessage: (msg) {
      print(msg['data']['push']);
      print(msg['data']['email']);

      setState(() {
        push = msg['data']['push'] == 'true' ? true : false;
        email = msg['data']['email'] == 'true' ? true : false;

        msg['data']['id'] == '5'
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(),
                ),
              );
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'Mentions Notifications',
                ),
                Spacer(),
                CupertinoSwitch(
                  value: push,
                  onChanged: (value) {
                    setState(() {
                      if (value)
                        FirebaseMessaging().subscribeToTopic('mention');
                      else
                        FirebaseMessaging().unsubscribeFromTopic('mention');
                      push = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'Add Requests Notifications',
                ),
                Spacer(),
                CupertinoSwitch(
                  value: email,
                  onChanged: (value) {
                    setState(() {
                      if (value)
                        FirebaseMessaging().subscribeToTopic('add');
                      else
                        FirebaseMessaging().unsubscribeFromTopic('add');
                      email = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
