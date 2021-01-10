import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/components/components.dart';

class SettingsScreen extends StatefulWidget
{
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
{
  Map data = {};

  @override
  void initState()
  {
    super.initState();

    getRealTimeData();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            Row(
              children:
              [
                CircleAvatar(
                  radius: 30.0,
                  child: Image(
                    image: NetworkImage(data['image']),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text(
                        '${data['first_name']} ${data['last_name']}',
                        style: blackBold16(),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser.phoneNumber,
                        style: grey14(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
