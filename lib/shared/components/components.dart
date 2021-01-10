import 'dart:ui';

import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);

Widget defaultButton({@required function, @required String text}) => Container(
  width: double.infinity,
  child: MaterialButton(
    height: 40.0,
    color: Colors.indigo,
    onPressed: function,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

TextStyle black20() => TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);

TextStyle black18() => TextStyle(
  fontSize: 18.0,
  color: Colors.black,
);

TextStyle black16() => TextStyle(
  fontSize: 16.0,
  color: Colors.black,
);

TextStyle black14() => TextStyle(
  fontSize: 14.0,
  color: Colors.black,
);

TextStyle black12() => TextStyle(
  fontSize: 12.0,
  color: Colors.black,
);

TextStyle blackBold20() => TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle blackBold18() => TextStyle(
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle blackBold16() => TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle blackBold14() => TextStyle(
  fontSize: 14.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle blackBold12() => TextStyle(
  fontSize: 12.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle grey20() => TextStyle(
  fontSize: 20.0,
  color: Colors.grey,
);

TextStyle grey18() => TextStyle(
  fontSize: 18.0,
  color: Colors.grey,
);

TextStyle grey16() => TextStyle(
  fontSize: 16.0,
  color: Colors.grey,
);

TextStyle grey14() => TextStyle(
  fontSize: 14.0,
  color: Colors.grey,
);

TextStyle grey12() => TextStyle(
  fontSize: 12.0,
  color: Colors.grey,
);

TextStyle greyBold20() => TextStyle(
  fontSize: 20.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

TextStyle greyBold18() => TextStyle(
  fontSize: 18.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

TextStyle greyBold16() => TextStyle(
  fontSize: 16.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

TextStyle greyBold14() => TextStyle(
  fontSize: 14.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

TextStyle greyBold12() => TextStyle(
  fontSize: 12.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);