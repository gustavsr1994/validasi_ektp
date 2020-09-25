import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color colorBlueDark = Colors.blue.shade900;
Color colorBlueSky = Colors.blue[400];
Color colorBackground = Colors.blue[200];
Color colorText = Colors.blue[50];
Color colorError = Colors.redAccent[400];

TextStyle fontTitle = GoogleFonts.lato(color: colorText, fontSize: 25, fontWeight: FontWeight.bold);
TextStyle fontButton = GoogleFonts.lato(color: colorText, fontSize: 20);
TextStyle fontEditText = GoogleFonts.lato(color: colorBlueDark, fontSize: 17, fontStyle: FontStyle.normal);
TextStyle fontError = GoogleFonts.lato(color: colorError, fontSize: 15, fontStyle: FontStyle.italic);
String textBlankField = "Please, fill the blank";
// TextStyle font