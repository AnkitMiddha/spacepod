import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spacepod/pages/home_page.dart';

void main()
{
  runApp(MyApp());

}
class  MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.deepPurple.shade300,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
     home: HomePage()
   );
  }

}