// ignore_for_file: must_be_immutable
import 'package:ebtsamty/Pages/Profile_Doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DateDoctorPage extends StatefulWidget {
  DateDoctorPage({super.key});

  @override
  State<DateDoctorPage> createState() => _DateDoctorPageState();
}

class _DateDoctorPageState extends State<DateDoctorPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final ref = FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid);
  // bool checknname = true;
  // String url = "";
  // bool checkname = true;
  // String urll = "";
  @override
  Widget build(BuildContext context) {
    // if (checkname) {
    //   checkname = false;
    //   getiname();
    // }
    // if (checknname) {
    //   checknname = false;
    //   getname();
    // }
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
                  MaterialPageRoute(builder: (context) => EditProfileDoctor()),
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
                        padding: const EdgeInsets.only(
                            right: 6, left: 6, bottom: 15),
                        child: Card(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: ListTile(
                            // title: Column(
                            //   children: [
                            //     Row(
                            //       // crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Text(
                            //           urll,
                            //           textAlign: TextAlign.right,
                            //           style: TextStyle(color: Colors.black),
                            //         ),
                            //         SizedBox(
                            //           width: 1,
                            //         ),
                            //         Text(
                            //           url,
                            //           textAlign: TextAlign.right,
                            //           style: TextStyle(color: Colors.black),
                            //         ),
                            //         // SizedBox(
                            //         //   width: 5,
                            //         // ),
                            //         // Text(
                            //         //   "لقد قمت بحجز موعد مع",
                            //         //   textAlign: TextAlign.right,
                            //         //   style: TextStyle(color: Colors.black),
                            //         // ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            title: Row(
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
                                // Text(
                                //   // "time",
                                //   " وذلك يوم",
                                //   textAlign: TextAlign.right,
                                //   style: TextStyle(
                                //       color: Colors.black, fontSize: 15),
                                // ),
                                Text(
                                  // "time",
                                  "تاريخ الموعد ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),

                            leading: IconButton(
                                onPressed: () {
                                  DatabaseReference reference = FirebaseDatabase
                                      .instance
                                      .ref()
                                      .child(FirebaseAuth
                                          .instance.currentUser!.uid);
                                  reference.child(Contact['key']).remove();
                                },
                                icon: Icon(Icons.remove)),
                            // trailing: CircleAvatar(
                            //   backgroundImage:
                            //       AssetImage("assets/images/doctor.jpeg"),
                            // ),
                          ),
                        ),
                      );
                    })),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
//  table() {
//     final ref = FirebaseDatabase.instance.reference();
//     databaseref.once().then((DataSnapshot snapshot) {
//       print('Data : ${snapshot.value}');
//     });
//   }
  // getiname() async {
  //   var collection = FirebaseFirestore.instance.collection('Patient');
  //   var docSnapshot =
  //       await collection.doc('${'8yiKqkViRyTvVaEbgHSSETbRQpn1'}').get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     var value = data?['first_name'];
  //     print("====$value");
  //     setState(() {
  //       this.urll = value;
  //     });
  //     // <-- The value you want to retrieve.
  //     // Call setState if needed.
  //   }
  // }

  // getname() async {
  //   var collection = FirebaseFirestore.instance.collection('Patient');
  //   var docSnapshot =
  //       await collection.doc('${'8yiKqkViRyTvVaEbgHSSETbRQpn1'}').get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     var value = data?['last_name'];
  //     print("====$value");
  //     setState(() {
  //       this.url = value;
  //     });
  //     // <-- The value you want to retrieve.
  //     // Call setState if needed.
  //   }
  // }
}







//  return SafeArea(
//       child: Scaffold(
//         key: _globalKey,
//         backgroundColor: const Color.fromARGB(232, 243, 248, 255),
//         body: Stack(
//           children: [
//             Container(
//               // color: Colors.amber,
//               height: 60,
//               padding: const EdgeInsets.only(left: 320),
//               child: Image.asset(
//                 "assets/icons/Logo2.png",
//                 width: 200,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 5),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   // _globalKey.currentState?.openDrawer();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => EditProfileDoctor()),
//                   );
//                 },
//               ),
//             ),
//             Column(
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 35,
//                     ),
//                     child: Stack(
//                       children: [
//                         CircleAvatar(
//                             backgroundColor:
//                                 const Color.fromARGB(232, 243, 248, 255),
//                             radius: 65,
//                             backgroundImage:
//                                 AssetImage("assets/avatar/avatar1.png")),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "د/طارق محمد",
//                   style: TextStyle(
//                       fontSize: 25, color: Color.fromARGB(255, 25, 58, 114)),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   height: 400,
//                   width: 350,
//                   // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   decoration:
//                       BoxDecoration(color: Color.fromARGB(255, 252, 252, 252)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 12),
//                         child: Text('م/ احمد حسين',
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 color: Colors.blue)),
//                       ),
//                       CalendarDatePicker(
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now().subtract(Duration(days: 365)),
//                         lastDate: DateTime.now().add(Duration(days: 365)),
//                         onDateChanged: (value) {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );