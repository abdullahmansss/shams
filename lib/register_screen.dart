import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/modules/profile/profile_screen.dart';
import 'package:flutter_app/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'username must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'username',
                ),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'email must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'email',
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'password must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'password',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                height: 40.0,
                child: Text(
                  'Already have an account?',
                ),
              ),
              Container(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      createUser(
                        email: emailController.text,
                        password: passwordController.text,
                        username: usernameController.text,
                      );
                    }
                  },
                  height: 40.0,
                  color: Colors.blue,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createUser({
    email,
    password,
    username,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      //value.user.sendEmailVerification();
      saveUser(
        username: username,
        email: email,
        id: value.user.uid,
      );
      print(value.user.uid);
    }).catchError((error) {
      print(error.toString());
    });
  }

  void saveUser({
    email,
    username,
    id,
  }) async {
    FirebaseFirestore.instance.collection('users').doc(id).set({
      'email': email,
      'username': username,
      'id': id,
      'last_path': 'demo',
    }).then((value)
    {
      navigateAndFinish(
        context,
        ProfileScreen(),
      );
    }).catchError((error) {
      print(error.toString());
    });
  }
}
