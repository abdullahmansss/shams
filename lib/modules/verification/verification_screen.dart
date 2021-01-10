import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/home/home_screen.dart';
import 'package:flutter_app/shared/components/components.dart';

class VerificationScreen extends StatelessWidget
{
  String code;

  VerificationScreen(this.code);

  var codeController = TextEditingController();

  var node = FocusNode();

  @override
  Widget build(BuildContext context)
  {
    node.requestFocus();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              'Enter your verification code.',
              textAlign: TextAlign.center,
              style: blackBold18(),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: codeController,
              focusNode: node,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'sms code',
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            defaultButton(
              function: ()
              {
                phoneAuthentication(codeController.text, context);
              },
              text: 'start',
            ),
          ],
        ),
      ),
    );
  }

  void phoneAuthentication(String code, context) async
  {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: this.code, smsCode: code);

    await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value)
    {
      print(value.user.uid);

      FirebaseFirestore.instance.collection('users').doc(value.user.uid).set({
        'first_name': 'first',
        'last_name': 'last',
        'id': value.user.uid,
      }).then((value)
      {
        navigateAndFinish(
          context,
          HomeScreen(),
        );
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((e){});
  }
}