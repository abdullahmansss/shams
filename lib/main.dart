import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/home/home_screen.dart';
import 'package:flutter_app/modules/welcome/welcome_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Widget myWidget;

  var user = FirebaseAuth.instance.currentUser;

  if(user != null)
  {
    myWidget = HomeScreen();
  } else
    {
      myWidget = WelcomeScreen();
    }

  runApp(MyApp(myWidget));
}

class MyApp extends StatefulWidget
{
  Widget myWidget;

  MyApp(this.myWidget);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver
{
  AppLifecycleState _lastLifecycleState;

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose()
  {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    setState(()
    {
      _lastLifecycleState = state;
      print(state.toString());
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if(_lastLifecycleState == null)
    {
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(FirebaseAuth.instance.currentUser.uid)
      //     .update({
      //   'status': 'off',
      // }).then((value) {
      //   //getData();
      //   print('success');
      // }).catchError((error) {
      //   print(error.toString());
      // });

      print('offfff');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: widget.myWidget,
    );
  }
}

// class LifecycleWatcher extends StatefulWidget
// {
//   @override
//   _LifecycleWatcherState createState() => _LifecycleWatcherState();
// }
//
// class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver
// {
//   AppLifecycleState _lastLifecycleState;
//
//   @override
//   void initState()
//   {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose()
//   {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state)
//   {
//     setState(() {
//       _lastLifecycleState = state;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_lastLifecycleState == null)
//       return Text('This widget has not observed any lifecycle changes.', textDirection: TextDirection.ltr);
//
//     return Text('The most recent lifecycle state this widget observed was: $_lastLifecycleState.',
//         textDirection: TextDirection.ltr);
//   }
// }