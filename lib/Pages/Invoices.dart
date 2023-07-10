// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Profile_Patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvoicesPage extends StatefulWidget {
  InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool check = true;
  String url = "";
  bool checkkk = true;
  String urll = "";
  @override
  Widget build(BuildContext context) {
    if (check) {
      check = false;
      getPrice();
    }
 if (checkkk) {
      checkkk = false;
      getservice();
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
        // drawer: Drawer(
        //     surfaceTintColor: Colors.black,
        //     backgroundColor: Color.fromARGB(255, 132, 184, 227),
        //     child: Column(
        //       children: [
        //         ListTile(
        //           title: Text("CertificatesPage"),
        //           leading: Icon(Icons.exit_to_app),
        //           onTap: () {
        //             Navigator.pushNamed(context, '/last');
        //           }),
        //       ListTile(
        //           title: Text("profileDoctor"),
        //           leading: Icon(Icons.exit_to_app),
        //           onTap: () {
        //             Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => EditProfileDoctor(),
        //               ),
        //             );
        //           }),
        //       ],
        //     ),
        //     ),
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
            //          Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => EditProfilePatient()),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "الفاتورة",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 51, 50, 86)),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(bottom: 40),
                    // color: Colors.amber,
                    height: 180,
                    width: 1000,
                    child: Image.asset("assets/images/CreditCard.png"),
                  ),
                  Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.only(right: 70),
                    width: double.infinity,
                    child: Text(
                      "الخدمة",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 7)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55))),
                    ),
                    child: Text(
                     urll,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.only(right: 70),
                    width: double.infinity,
                    child: Text(
                      "سعر الخدمة",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 111, vertical: 12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55))),
                    ),
                    child: Text(
                      "$url LE",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.only(right: 70),
                    width: double.infinity,
                    child: Text(
                      "اجمالي التكلفة",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 111, vertical: 12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55))),
                    ),
                    child: Text(
                      "$url LE",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getPrice() async {
    var collection = FirebaseFirestore.instance.collection('hagz');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['price'];
      print("====$value");
      setState(() {
        this.url = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }
 getservice() async {
    var collection = FirebaseFirestore.instance.collection('hagz');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['service'];
      print("====$value");
      setState(() {
        this.urll = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }
}

// appBar: AppBar(
//           backgroundColor: const Color.fromARGB(232, 243, 248, 255),
//           centerTitle: true,
//           foregroundColor: Colors.black,
//           actions: [
//             Container(
//               // color: Colors.amber,
//               height: 0,
//               padding: const EdgeInsets.only(left: 330),
//               child: Image.asset(
//                 "assets/icons/Logo2.png",
//                 width: 62,
//               ),
//             ),
//           ],
//           elevation: 0,
//         ),
