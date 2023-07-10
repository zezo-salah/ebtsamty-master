import 'package:ebtsamty/Pages/StartScreen.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    // تحميل البيانات أو أي عملية أخرى قبل الانتقال إلى الشاشة التالية
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StartScreen(),
        ),
      ); // الانتقال إلى الشاشة التالية بعد انتهاء الوقت المحدد
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE8F3F8),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                // fit: BoxFit.fitHeight,
                // width: 359,
                // height: 780,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.94,
              ), // استخدام صورة اللوجو
              // SizedBox(height: 20),
              // CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
