import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/modules/profile/profile_screen.dart';
import 'package:flutter_app/register_screen.dart';
import 'package:flutter_app/settings_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Widget myWidget;

  var user = FirebaseAuth.instance.currentUser;

  if(user != null)
  {
    myWidget = ProfileScreen();
  } else
    {
      myWidget = LoginScreen();
    }

  runApp(MyApp(myWidget));
}

class MyApp extends StatelessWidget
{
  Widget myWidget;

  MyApp(this.myWidget);


  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: myWidget,
    );
  }
}