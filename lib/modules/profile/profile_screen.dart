import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //hello from init 2
  //hello from init 4
  Map data = {};
  File image;

  @override
  void initState() {
    super.initState();

    getRealTimeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: image == null
                      ? NetworkImage(data['image'] ??
                          'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png')
                      : FileImage(image),
                ),
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: CircleAvatar(
                    radius: 15.0,
                    child: Icon(
                      Icons.edit,
                      size: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              data['username'] ?? 'demo',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              data['email'] ?? 'demo@demo.com',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              data['id'] ?? 'demo id',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    navigateAndFinish(
                      context,
                      LoginScreen(),
                    );
                  });
                },
                height: 40.0,
                color: Colors.blue,
                child: Text(
                  'sign out'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        data = value.data();
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getRealTimeData() {
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

  Future<void> pickImage() async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);

        print(value.path);
        uploadImage();
        setState(() {});
      }
    });
  }

  uploadImage()
  {
    if(data['last_path'] != 'demo')
    {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${data['last_path']}')
          .delete()
          .then((value) {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(image.path).pathSegments.last}')
            .putFile(image)
            .onComplete
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .update({
              'image': value.toString(),
              'last_path': Uri.file(image.path).pathSegments.last,
            }).then((value) {
              //getData();
              print('success');
            }).catchError((error) {
              print(error.toString());
            });
          });
        });
      }).catchError((error) {});
    }
  }
}