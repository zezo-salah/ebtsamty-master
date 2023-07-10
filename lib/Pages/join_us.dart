import 'package:ebtsamty/Pages/Register_Patient.dart';
import 'package:ebtsamty/Pages/Register_doctor.dart';
import 'package:ebtsamty/Pages/Sigin.dart';
import 'package:flutter/material.dart';

class joinUs extends StatefulWidget {
  const joinUs({super.key});

  @override
  State<joinUs> createState() => _joinUsState();
}

class _joinUsState extends State<joinUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(232, 243, 248, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 243, 248, 255),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // _globalKey.currentState?.openDrawer();
            //    Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => EditProfilePatient()),
            // );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SigninScreen(),
              ),
            );
          },
        ),
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   // color: Colors.amber,
            //   height: 55,
            //   padding: const EdgeInsets.only(left: 320),
            //   child: Image.asset(
            //     "assets/icons/Logo2.png",
            //     width: 200,
            //   ),
            // ),
            // const Padding(padding: EdgeInsets.only(bottom: 180)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(right: 100, left: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorScreenRegister()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 90, 154, 249)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(41)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                    ),
                    child: Text(
                      "دكتور",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(right: 100, left: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientScreenRegister()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 90, 154, 249)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(40)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                    ),
                    child: Text(
                      "مريض",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
