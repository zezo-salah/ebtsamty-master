import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Certificates.dart';
import 'package:ebtsamty/Pages/DateDoctor.dart';
import 'package:ebtsamty/Pages/Home_Page.dart';
import 'package:ebtsamty/Pages/Sigin.dart';
import 'package:ebtsamty/shared/data_firebase_doctor.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileDoctor extends StatefulWidget {
  const EditProfileDoctor({super.key});

  @override
  State<EditProfileDoctor> createState() => _EditProfileDoctorState();
}

class _EditProfileDoctorState extends State<EditProfileDoctor> {
  CollectionReference users = FirebaseFirestore.instance.collection('Doctor');
  final credential = FirebaseAuth.instance.currentUser;
  bool Isvisibility = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Scaffold(
          backgroundColor: const Color.fromARGB(232, 243, 248, 255),
          key: _globalKey,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(0, 243, 248, 255),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                _globalKey.currentState?.openDrawer();
              },
            ),
            actions: [
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 65),
              //     child: Text(
              //       "الملف الشخصي",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 25,
              //           color: Color.fromARGB(255, 25, 58, 114)),
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(left: 5),
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
          ),
          drawer: Drawer(
            width: 280,
            // surfaceTintColor: Colors.black,
            backgroundColor: Color.fromARGB(255, 132, 184, 227),
            child: Column(
              children: [
                Row(children: [
                  Container(
                    // padding: EdgeInsets.only(left: 5),
                    child: SizedBox(
                      child: Image.asset(
                        "assets/icons/Logo2.png",
                        width: 60,
                        // height: 100,
                      ),
                    ),
                  ),
                  Container(
                    child: Text('Ebtsamty Doctor',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ]),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                    title: Text(
                      "الصفحة الرئيسية",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 4, 51, 90),
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }),
                ListTile(
                    title: Text(
                      "الملف الشخصي",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.recent_actors,
                      color: Color.fromARGB(255, 4, 51, 90),
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileDoctor(),
                        ),
                      );
                    }),
                ListTile(
                    title: Text(
                      "الشهادات",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.hive,
                      color: Color.fromARGB(255, 4, 51, 90),
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CertificatesPage(),
                        ),
                      );
                    }),
                ListTile(
                    title: Text(
                      "المواعيد و الحجوزات",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.date_range,
                      color: Color.fromARGB(255, 4, 51, 90),
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DateDoctorPage(),
                        ),
                      );
                    }),
                    ListTile(
                      title: Text(
                        "تسجيل الخروج",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Color.fromARGB(255, 4, 51, 90),
                        size: 25,
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninScreen(),
                          ),
                        );
                      }),
                     SizedBox(
              height: 310,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Copyright ©2023 All rights",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 18.7,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "reserved | This template is",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "made by Team 61",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Ebtsamty.com",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color:Color.fromARGB(255, 4, 51, 90)),
                ),
              ),
            ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetDataFirebaseDoctor(
                  documentId: credential!.uid,
                )
              ],
            ),
          ),
        )),
      ],
    );
  }
}
