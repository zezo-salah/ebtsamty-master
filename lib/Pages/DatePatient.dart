// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Profile_Patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePatientPage extends StatefulWidget {
  DatePatientPage({super.key});

  @override
  State<DatePatientPage> createState() => _DatePatientPageState();
}

class _DatePatientPageState extends State<DatePatientPage> {
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final ref = FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid);
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool checkname = true;
  String url = "";
  bool checktime = true;
  String urll = "";
  bool checkdate = true;
  String urlll = "";
  @override
  Widget build(BuildContext context) {
    if (checkname) {
      checkname = false;
      getiname();
    }
    if (checktime) {
      checktime = false;
      getTime();
    }
    if (checkdate) {
      checkdate = false;
      getDate();
    }
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        backgroundColor: const Color.fromARGB(232, 243, 248, 255),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(0, 243, 248, 255),
            elevation: 0,
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
            ]),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  shrinkWrap: true,
                  itemBuilder: (context, snapshot, animation, index) {
                    String date_hagz =
                        snapshot.child("date_hagz").value.toString();
                    DateTime hagzDateTime = DateTime.parse(date_hagz);
                    String formattedDate =
                        "${hagzDateTime.year}-${hagzDateTime.month.toString().padLeft(2, '0')}-${hagzDateTime.day.toString().padLeft(2, '0')}";
                    Map Contact = snapshot.value as Map;
                    Contact['key'] = snapshot.key;
                    return Padding(
                      padding:
                          const EdgeInsets.only(right: 6, left: 6, bottom: 15),
                      child: Card(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          title: Column(
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    snapshot.child("doctor").value.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "لقد قمت بحجز موعد مع",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.child("time").value.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),                                                          
                              SizedBox(
                                width: 1,
                              ),
                              Text(
                                // "time",
                                " الساعة",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(
                                // "time",
                                " $formattedDate",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(
                                // "time",
                                " وذلك يوم",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          // trailing: CircleAvatar(
                          //   backgroundImage:
                          //       AssetImage("assets/images/doctor.jpeg"),
                          // ),
                          leading: IconButton(
                              onPressed: () {
                                DatabaseReference reference = FirebaseDatabase
                                    .instance
                                    .ref()
                                    .child(FirebaseAuth.instance.currentUser!.uid);
                                reference.child(Contact['key']).remove();
                              },
                              icon: Icon(Icons.remove)),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  getiname() async {
    var collection = FirebaseFirestore.instance.collection('hagz');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['doctor'];
      print("====$value");
      setState(() {
        this.url = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  getTime() async {
    var collection = FirebaseFirestore.instance.collection('hagz');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['time'];
      print("====$value");
      setState(() {
        this.urll = value;
      });
      // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  getDate() async {
    var collection = FirebaseFirestore.instance.collection('hagz');
    var docSnapshot =
        await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
    print(docSnapshot.data());
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['date_hagz'];
      print("====$value");
      Timestamp timestamp = value; // تحويل Timestamp إلى تاريخ DateTime
      DateTime date = timestamp.toDate();
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(date); // تنسيق التاريخ بالشكل المطلوب
      setState(() {
        this.urlll =
            formattedDate; // استخدام التاريخ المنسق في الحفظ في الحالة الداخلية للصفحة
      });
    }
  }
}



//  Container(
  //   width: 375,
                  //   decoration: BoxDecoration(
                  //     color: Colors.greenAccent,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Material(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Colors.grey[500],
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(13),
                  //       child: Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               CircleAvatar(
                  //                 backgroundImage:
                  //                     AssetImage("assets/images/doctor.jpeg"),
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     "د.محمد احمد",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   const SizedBox(
                  //                     width: 2,
                  //                   ),
                  //                   Text(
                  //                     "قسم الفم والفكين وأمراض الفم واللثة",
                  //                     style: TextStyle(color: Colors.black),
                  //                   )
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 0,
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(
                  //                 color: Colors.grey,
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             width: double.infinity,
                  //             padding: EdgeInsets.all(20),
                  //             child: Row(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Icon(
                  //                   Icons.calendar_today_rounded,
                  //                   color: Colors.white,
                  //                   size: 15,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Text(
                  //                   "Monday, 10/4/2023",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 20,
                  //                 ),
                  //                 Icon(
                  //                   Icons.access_alarm,
                  //                   color: Colors.white,
                  //                   size: 17,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Flexible(
                  //                     child: Text(
                  //                   "6:00 PM",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ))
                  //               ],
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 0,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Expanded(
                  //                 child: ElevatedButton(
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.red,
                  //                   ),
                  //                   child: Text(
                  //                     "Cancel",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 20,
                  //               ),
                  //               Expanded(
                  //                 child: ElevatedButton(
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.blue,
                  //                   ),
                  //                   child: Text(
                  //                     "Completed",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   width: 375,
                  //   decoration: BoxDecoration(
                  //     color: Colors.greenAccent,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Material(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Colors.grey[500],
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(13),
                  //       child: Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               CircleAvatar(
                  //                 backgroundImage:
                  //                     AssetImage("assets/images/doctor.jpeg"),
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     "د.محمد احمد",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   const SizedBox(
                  //                     width: 2,
                  //                   ),
                  //                   Text(
                  //                     "قسم الفم والفكين وأمراض الفم واللثة",
                  //                     style: TextStyle(color: Colors.black),
                  //                   )
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 0,
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(
                  //                 color: Colors.grey,
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             width: double.infinity,
                  //             padding: EdgeInsets.all(20),
                  //             child: Row(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Icon(
                  //                   Icons.calendar_today_rounded,
                  //                   color: Colors.white,
                  //                   size: 15,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Text(
                  //                   "Monday, 10/4/2023",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 20,
                  //                 ),
                  //                 Icon(
                  //                   Icons.access_alarm,
                  //                   color: Colors.white,
                  //                   size: 17,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Flexible(
                  //                     child: Text(
                  //                   "6:00 PM",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ))
                  //               ],
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 0,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Expanded(
                  //                 child: ElevatedButton(
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.red,
                  //                   ),
                  //                   child: Text(
                  //                     "Cancel",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 20,
                  //               ),
                  //               Expanded(
                  //                 child: ElevatedButton(
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.blue,
                  //                   ),
                  //                   child: Text(
                  //                     "Completed",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   width: 375,
                  //   decoration: BoxDecoration(
                  //     color: Colors.greenAccent,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Material(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Colors.grey[500],
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(13),
                  //       child: Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               CircleAvatar(
                  //                 backgroundImage:
                  //                     AssetImage("assets/images/doctor.jpeg"),
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     "د.محمد احمد",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   const SizedBox(
                  //                     width: 2,
                  //                   ),
                  //                   Text(
                  //                     "قسم الفم والفكين وأمراض الفم واللثة",
                  //                     style: TextStyle(color: Colors.black),
                  //                   )
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 0,
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(
                  //                 color: Colors.grey,
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             width: double.infinity,
                  //             padding: EdgeInsets.all(20),
                  //             child: Row(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Icon(
                  //                   Icons.calendar_today_rounded,
                  //                   color: Colors.white,
                  //                   size: 15,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Text(
                  //                   "Monday, 10/4/2023",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 20,
                  //                 ),
                  //                 Icon(
                  //                   Icons.access_alarm,
                  //                   color: Colors.white,
                  //                   size: 17,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Flexible(
                  //                     child: Text(
                  //                   "6:00 PM",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ))
                  //               ],
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 0,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Expanded(
                  //                 child: ElevatedButton(
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.red,
                  //                   ),
                  //                   child: Text(
                  //                     "Cancel",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 20,
                  //               ),
                  //               Expanded(
                  //                 child: ElevatedButton(
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.blue,
                  //                   ),
                  //                   child: Text(
                  //                     "Completed",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),

//  getDate() async {
//     var collection = FirebaseFirestore.instance.collection('hagz');
//     var docSnapshot =
//         await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
//     print(docSnapshot.data());
//     if (docSnapshot.exists) {
//       Map<String, dynamic>? data = docSnapshot.data();
//       var value = data?['date_hagz'];
//       print("====$value");
//       String timedate = value.toString();
//       setState(() {
//         int milsec = int.parse(timedate
//             .replaceAll("Timestamp(", "")
//             .replaceAll(")", "")
//             .replaceAll("=", ":")
//             .split(",")[0]
//             .replaceAll("seconds:", ""));
//         DateTime date = DateTime.fromMicrosecondsSinceEpoch(milsec);
//         print("++++++$date");
//         this.urlll = "${date.year}-${date.month}-${date.day}";
//       });
//       // <-- The value you want to retrieve.
//       // Call setState if needed.
//     }
//   }

 //  getDate() async {
  //   var collection = FirebaseFirestore.instance.collection('hagz');
  //   var docSnapshot =
  //       await collection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
  //   print(docSnapshot.data());
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     var value = data?['date_hagz'];
  //     print("====$value");
  //     String timedate = value.toString();
  //     setState(() {
  //       int milsec = int.parse(timedate
  //           .replaceAll("Timestamp(", "")
  //           .replaceAll(")", "")
  //           .replaceAll("=", ":")
  //           .split(",")[0]
  //           .replaceAll("seconds:", ""));
  //       DateTime date =  DateTime.fromMillisecondsSinceEpoch(milsec);
  //       print("++++++$date");
  //       this.urll ="${date.year}-${date.month}-${date.day}";
  //     });
  //     // <-- The value you want to retrieve.
  //     // Call setState if needed.
  //   }
  // }                 