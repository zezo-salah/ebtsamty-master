// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Profile_Patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TheprescriptionPage extends StatefulWidget {
  TheprescriptionPage({super.key});

  @override
  State<TheprescriptionPage> createState() => _TheprescriptionPageState();
}

class _TheprescriptionPageState extends State<TheprescriptionPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool check = true;
  String url = "";
  bool checkphoto = true;
  String urrl = "";
  bool checkname = true;
  String urrrl = "";
  bool checkage = true;
  String urrrrl = "";
  bool checklastname = true;
  String urll = "";
  @override
  Widget build(BuildContext context) {
    if (check) {
      check = false;
      getimage();
    }
    if (checkphoto) {
      checkphoto = false;
      getphoto();
    }
    if (checkname) {
      checkname = false;
      getname();
    }
    if (checkage) {
      checkage = false;
      getage();
    }
    if (checklastname) {
      checklastname = false;
      getlastname();
    }
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePatient()),
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
        backgroundColor: const Color.fromARGB(232, 243, 248, 255),
        body: Stack(
          children: [
            // Container(
            //   // color: Colors.amber,
            //   height: 60,
            //   padding: const EdgeInsets.only(left: 320),
            //   child: Image.asset(
            //     "assets/icons/Logo2.png",
            //     width: 200,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 5),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.arrow_back,
            //       color: Colors.black,
            //     ),
            //     onPressed: () {
            //       // _globalKey.currentState?.openDrawer();
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => EditProfilePatient()),
            //       );
            //     },
            //   ),
            // ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(232, 243, 248, 255),
                            radius: 65,
                            backgroundImage: NetworkImage(urrl)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      urrrl,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 25, 58, 114)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      urll,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 25, 58, 114)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "سنة ",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 25, 58, 114)),
                    ),
                    Text(
                      urrrrl,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 25, 58, 114)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  // padding: EdgeInsets.only(bottom: 40),
                  // color: Colors.amber,
                  height: 400,
                  width: 500,
                  child: Image.network(url),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getimage() async {
    var collection = FirebaseFirestore.instance.collection('Patient');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['alrowshta'];
      print("====$value");
      setState(() {
        this.url = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  getphoto() async {
    var collection = FirebaseFirestore.instance.collection('Patient');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['photo'];
      print("====$value");
      setState(() {
        this.urrl = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  getname() async {
    var collection = FirebaseFirestore.instance.collection('Patient');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['first_name'];
      print("====$value");
      setState(() {
        this.urrrl = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  getage() async {
    var collection = FirebaseFirestore.instance.collection('Patient');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['age'];
      print("====$value");
      setState(() {
        this.urrrrl = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  getlastname() async {
    var collection = FirebaseFirestore.instance.collection('Patient');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['last_name'];
      print("====$value");
      setState(() {
        this.urll = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }
}


// bool checkfirstName = true;
//   String urrrl = "";
//   bool checkage = true;
//   String _age = "";
//   if (checkfirstName) {
//       checkphoto = false;
//       name();
//     }
//     if (checkage) {
//       checkphoto = false;
//       age();
//     }
//     name() async {
//     var collection = FirebaseFirestore.instance.collection('Patient');
//     var docSnapshot =
//         await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
//     if (docSnapshot.exists) {
//       Map<String, dynamic>? data = docSnapshot.data();
//       var value = data?['firstName'];
//       print("====$value");
//       setState(() {
//         this.urrrl = value;
//       });
//       // <-- The value you want to retrieve.
//       // Call setState if needed.
//     }
//   }
//   age() async {
//     var collection = FirebaseFirestore.instance.collection('Patient');
//     var docSnapshot =
//         await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
//     if (docSnapshot.exists) {
//       Map<String, dynamic>? data = docSnapshot.data();
//       var value = data?['age'];
//       print("====$value");
//       setState(() {
//         this._age = value;
//       });
//       // <-- The value you want to retrieve.
//       // Call setState if needed.
//     }
//   }