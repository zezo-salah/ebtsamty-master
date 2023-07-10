import 'package:ebtsamty/Pages/Sigin.dart';
import 'package:ebtsamty/Pages/join_us.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(232, 243, 248, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 243, 248, 255),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(
                  child: Image.asset(
                    "assets/icons/Logo2.png",
                    width: 60,
                    // height: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Center(
                    child: Text(
                  "Ebtsamty",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "اهلا بكم في ابتسامتي",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 43, 113)),
              ),
            ),
            Text(
              "نحن نجعل ابتسامتك افضل",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 43, 113)),
            ),
            Container(
              // color: Colors.amber,
              height: 430,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Image.asset(
                "assets/images/doctor2.png",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SigninScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 90, 154, 249)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 111, vertical: 12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(66))),
              ),
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => joinUs(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 90, 154, 249)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 113, vertical: 12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(66))),
              ),
              child: Text(
                "مستخدم جديد",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    ));
  }
}
