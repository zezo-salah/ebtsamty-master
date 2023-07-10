import 'package:flutter/material.dart';

const decorationTextfield2 = InputDecoration(
  fillColor: Color.fromARGB(232, 243, 248, 255),
  filled: true,
  contentPadding: EdgeInsets.all(8),
  // To delete borders
  border: OutlineInputBorder(
      // borderSide: BorderSide.none,
      ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 155, 191, 245),
    ),
  ),
);
