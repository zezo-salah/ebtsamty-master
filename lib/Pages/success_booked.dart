import 'package:ebtsamty/Pages/Home_Page.dart';
import 'package:flutter/material.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(232, 243, 248, 255),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                    "assets/images/—Pngtree—green-check-mark-icon-flat_5253210.png"),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "تم الحجز بنجاح",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 23, 2, 98)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 90, vertical: 10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text(
                    "العودة إلى الصفحة الرئيسية",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
  