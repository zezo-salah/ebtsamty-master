// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Profile_Doctor.dart';
import 'package:ebtsamty/Pages/Profile_Patient.dart';
import 'package:ebtsamty/Pages/Reservation.dart';
import 'package:ebtsamty/Pages/Sigin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String type = "wait...";
  bool condition = true;
  bool isExsit = false;
  @override
  Widget build(BuildContext context) {
    if (condition) {
    gettayp();
    condition = false;
    }
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Color.fromARGB(255, 217, 212, 238),
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 132, 184, 227),
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(children: [
                    Container(
                      // padding: EdgeInsets.only(left: 5),
                      child: SizedBox(
                        child: Image.asset(
                          "assets/icons/Logo2.png",
                          width: 65,
                          // height: 100,
                        ),
                      ),
                    ),
                    Container(
                      child: Text('Ebtsamty',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  SizedBox(
                    height: 25,
                  ),
                  ListTile(
                      title: Text(
                        type == "wait..."
                            ? "wait..."
                            : ! isExsit 
                                ? "Doctor Profile"
                                : "Patient Profile",
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
                            builder: (context) =>! isExsit 
                                ? EditProfileDoctor()
                                : EditProfilePatient(),
                          ),
                        );
                      }),
                  // ListTile(
                  //     title: Text(
                  //       "Patient Profile",
                  //       textAlign: TextAlign.left,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 18,
                  //           color: Colors.white),
                  //     ),
                  //     leading: Icon(
                  //       Icons.recent_actors,
                  //       color: Color.fromARGB(255, 4, 51, 90),
                  //       size: 25,
                  //     ),
                  //     onTap: () {
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => EditProfilePatient(),
                  //         ),
                  //       );
                  //     }),
                  ListTile(
                      title: Text(
                        "Logout",
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
              height: 450,
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
              // Container(
              //     margin: EdgeInsets.only(bottom: 12),
              //     child: Text(
              //       "Developed by Zizo Salah © 2023",
              //       style: TextStyle(fontSize: 16),
              //     ))
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 180, 211, 237),
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
            Row(
              children: [
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
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 180, 211, 237),
                height: 160,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "اهلا بكم في ابتسامتي",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 2, 43, 113)),
                          ),
                          Text(
                            "نحن نجعل ابتسامتك افضل",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 2, 43, 113)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ! isExsit 
                                ? HomePage()
                                : ReservationPage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 23, 2, 98)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 30)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55))),
                            ),
                            child: Text(
                              "احجز الان",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          width: 155,
                          height: 150,
                          child: Image.asset("assets/images/LogoTeeth-.png")),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                height: h * 0.64,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(),
                      Form(
                          child: Column(
                        children: [
                          Text(
                            "لماذا نحن الافضل؟",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 2, 43, 113)),
                          ),
                          Text(
                            "سياستنا",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 2, 43, 113)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 84, 161, 223)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(12)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55))),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                        "assets/images/Earphone.png")),
                                Text(
                                  "مستوي الرعاية",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 2, 43, 113)),
                                ),
                                Text(
                                  "تتميز العيادة بتقديم الخدمات الوقائية والعلاجية",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  "الخاصة بطب الاسنان علي اسس علمية سليمة",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  ".باستخدام افضل خامات طب الاسنان",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 84, 161, 223)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 5)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55))),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset("assets/images/1.png")),
                                Text(
                                  "التعقيم ومكافحة العدوي",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 2, 43, 113)),
                                ),
                                Text(
                                  "لان من اهم اولوياتنا مكافحة العدوي تم",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  "تجهيز العيادة باقوي اجهزة التعقيم",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  "التي بدورها تقضي علي كامل الميكروبات",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  "وتجعل الادوات المستخدمة معقمة%100",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 84, 161, 223)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55))),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset("assets/images/2.png")),
                                Text(
                                  "المواعيد",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 2, 43, 113)),
                                ),
                                Text(
                                  "نتتبع بالعيادة نظام الحجز بالمواعيد حيث",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  "يتم تخصيص موعدا مسبقا محدد لكل مريض",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  " .حرصا علي الوقت وتقليل مدة الانتظار",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                        ],
                      )),
                      Container(
                        color: Color.fromARGB(96, 144, 188, 224),
                        width: double.infinity,
                        height: 650,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                "تعرف علي فريقنا",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 2, 43, 113)),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(119, 144, 188, 224),
                                ),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(44))),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 140,
                                    width: 150,
                                    // color: Color.fromARGB(96, 144, 188, 224),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset("assets/images/3.png"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "د.محمد احمد",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 2, 43, 113)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(119, 144, 188, 224),
                                ),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(44))),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 140,
                                    width: 150,
                                    // color: Color.fromARGB(96, 144, 188, 224),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset("assets/images/3.png"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "د.طارق محمد",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 2, 43, 113)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(119, 144, 188, 224),
                                ),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(44))),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 140,
                                    width: 150,
                                    // color: Color.fromARGB(96, 144, 188, 224),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset("assets/images/3.png"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "د.كريم السيد",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 2, 43, 113)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "افضل العروض بخصم %20",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 2, 43, 113),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 250,
                            child: ClipRRect(
                              child: Image.asset("assets/images/4.jpeg"),
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 84, 161, 223)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 8)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                            child: Text(
                              "تبيض الاسنان بالليزر",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Color.fromARGB(255, 2, 43, 113),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 250,
                            child: ClipRRect(
                              child: Image.asset("assets/images/5.jpeg"),
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 84, 161, 223)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 8)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                            child: Text(
                              "تركيب التقويم المعدني",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Color.fromARGB(255, 2, 43, 113),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                            height: 200,
                            color: Color.fromARGB(255, 84, 161, 223),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "اتصل بينا",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 2, 43, 113)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              width: 25,
                                              height: 25,
                                              child: Image.asset(
                                                "assets/images/6.png",
                                                color: Colors.black,
                                              )),
                                          Text(
                                            "Ebtsamty.com",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: 25,
                                              height: 25,
                                              child: Image.asset(
                                                  "assets/images/7.png")),
                                          Text(
                                            "11505",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: 25,
                                              height: 25,
                                              child: Image.asset(
                                                  "assets/images/8.png")),
                                          Text(
                                            "الشروق ش الحجاز",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                          "assets/images/9.png",
                                          color: Colors.green,
                                        )),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Container(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                          "assets/images/10.png",
                                          color:
                                              Color.fromARGB(255, 3, 129, 232),
                                        )),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Container(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                          "assets/images/11.png",
                                          color:
                                              Color.fromARGB(255, 96, 96, 96),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  gettayp() async {
    var collection = FirebaseFirestore.instance.collection('Patient');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    print("===========${docSnapshot.exists}");
    setState(() {
      isExsit = docSnapshot.exists;
      print("==========${docSnapshot.toString()}");
      type = docSnapshot.toString();
    });
  }
}
