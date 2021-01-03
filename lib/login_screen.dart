import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/profile/profile_screen.dart';
import 'package:flutter_app/register_screen.dart';
import 'package:flutter_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    onPressed: ()
                    {
                      navigateTo(context, RegisterScreen(),);
                    },
                    child: Text(
                      'Not have an account? Register',
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          loginUser(emailController.text,
                              passwordController.text, context);
                        }
                      },
                      height: 40.0,
                      color: Colors.blue,
                      child: Text(
                        'Login',
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
          if (isLogin) CircularProgressIndicator(),
        ],
      ),
    );
  }

  void loginUser(email, password, context) async {
    setState(() {
      isLogin = true;
    });

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user.uid);
      navigateAndFinish(context, ProfileScreen());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
