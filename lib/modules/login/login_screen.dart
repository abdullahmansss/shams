import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/verification/verification_screen.dart';
import 'package:flutter_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget
{
  var codeController = TextEditingController()..text = '+20';
  var phoneController = TextEditingController();

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
              'Enter your phone number to get started.',
              textAlign: TextAlign.center,
              style: blackBold18(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'you will receive a verification code.',
              style: grey14(),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children:
              [
                Container(
                  width: 50.0,
                  child: TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'code',
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    focusNode: node,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'phone number',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            defaultButton(
              function: ()
              {
                phoneVerification(phoneController.text, context);
              },
              text: 'next',
            ),
          ],
        ),
      ),
    );
  }

  void phoneVerification(String phone, context) async
  {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+20$phone',
      verificationCompleted: (PhoneAuthCredential credential)
      {

      },
      verificationFailed: (FirebaseAuthException e)
      {
        print(e.message);
      },
      codeSent: (String verificationId, int resendToken)
      {
        navigateTo(context, VerificationScreen(verificationId),);
      },
      codeAutoRetrievalTimeout: (String verificationId)
      {

      },
    );
  }
}