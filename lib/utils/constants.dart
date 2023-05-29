
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

DatabaseReference? tripRequestRef;

const kYellow = Color(0xFFFFCF61);
const kBlack = Color(0xFF2F2F2F);
const kLBlack = Color(0xFF292D30);
const kDBlack = Color(0xFF191919);

class CustomTextStyles {
  static const boldStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontFamily: 'Rubik',
      fontSize: 14
  );
}

const kDrawerItemStyle = TextStyle(fontSize: 16);