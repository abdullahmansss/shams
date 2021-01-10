import 'package:flutter/material.dart';
import 'package:flutter_app/modules/login/login_screen.dart';
import 'package:flutter_app/shared/components/components.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Expanded(
              child: Icon(
                Icons.access_alarm,
                size: 100.0,
              ),
            ),
            Text(
              'Take privacy with you.',
              style: blackBold18(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Be yourself in every message.',
              style: blackBold18(),
            ),
            SizedBox(
              height: 50.0,
            ),
            defaultButton(
              function: () {
                navigateTo(
                  context,
                  LoginScreen(),
                );
              },
              text: 'continue',
            ),
            SizedBox(
              height: 25.0,
            ),
            MaterialButton(
              onPressed: () {},
              child: Text(
                'Terms & Privacy Policy',
                style: grey14(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
