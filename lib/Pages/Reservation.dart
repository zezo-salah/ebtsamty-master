// ignore_for_file: unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Booking_Now2.dart';
import 'package:ebtsamty/Pages/Booking_Now3.dart';
import 'package:ebtsamty/Pages/Profile_Patient.dart';
import 'package:ebtsamty/Pages/Booking_Now.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final DateController = TextEditingController();
  // showmodel() {
  //   // final FirebaseFirestore users = FirebaseFirestore.instance;
  //   // CollectionReference users = FirebaseFirestore.instance.collection('Patient');
  //   // final credential = FirebaseAuth.instance;
  //   setState(() {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 150),
  //             child: AlertDialog(
  //               actionsAlignment: MainAxisAlignment.end,
  //               icon: Padding(
  //                 padding: const EdgeInsets.only(left: 210),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     IconButton(
  //                       icon: Icon(
  //                         Icons.cancel_outlined,
  //                         color: Colors.blue,
  //                       ),
  //                       onPressed: () {
  //                         // _globalKey.currentState?.openDrawer();
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               content: Container(
  //                 height: 320,
  //                 width: 460,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       child: Text(
  //                         "اختر الميعاد المناسب لك",
  //                         style: TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.blue),
  //                         textAlign: TextAlign.end,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 200,
  //                       child: TextField(
  //                         controller: DateController,
  //                         keyboardType: TextInputType.datetime,
  //                         obscureText: false,
  //                         textAlign: TextAlign.center,
  //                         decoration: const InputDecoration(
  //                             prefixIcon: Icon(
  //                               Icons.calendar_today_rounded,
  //                               color: Colors.blue,
  //                             ),
  //                             hintText: "mm/dd/yyyy    ",
  //                             hintStyle: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.black)),
  //                         onTap: () async {
  //                           DateTime? pickedDate = await showDatePicker(
  //                               context: context,
  //                               initialDate: DateTime.now(),
  //                               firstDate: DateTime(1000),
  //                               lastDate: DateTime(2100));
  //                           if (pickedDate != null) {
  //                             setState(() {
  //                               DateController.text =
  //                                   DateFormat('yyyy-MM-dd').format(pickedDate);
  //                             });
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 50,
  //                     ),
  //                     Column(
  //                       children: [
  //                         Container(
  //                           child: Text(
  //                             "هل تعاني من أي أمراض مزمنة؟",
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.blue),
  //                             textAlign: TextAlign.end,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         InputDecorator(
  //                           // textAlign: TextAlign.center,
  //                           decoration: decorationTextfield2.copyWith(),
  //                           child: DropdownButtonHideUnderline(
  //                             child: DropdownButton<String>(
  //                                 dropdownColor:
  //                                     Color.fromARGB(255, 132, 184, 227),
  //                                 isDense: true,
  //                                 value: _value,
  //                                 isExpanded: true,
  //                                 // menuMaxHeight: 350,
  //                                 items: [
  //                                   DropdownMenuItem(
  //                                     alignment: AlignmentDirectional.center,
  //                                     child: Text(
  //                                       "الأمراض المزمنة",
  //                                       style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.bold),
  //                                       // textAlign: TextAlign.center,
  //                                       selectionColor: Colors.black,
  //                                     ),
  //                                     value: "",
  //                                   ),
  //                                   ...dropDown
  //                                       .map<DropdownMenuItem<String>>((date) {
  //                                     return DropdownMenuItem(
  //                                       alignment: Alignment.topRight,
  //                                       child: Text(
  //                                         date["title"],
  //                                       ),
  //                                       value: date["title"],
  //                                     );
  //                                   }).toList(),
  //                                 ],
  //                                 onChanged: (value) {
  //                                   setState(() {
  //                                     _value = value!;
  //                                     print(dropDown);
  //                                   });
  //                                 }),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 40,
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           showmodel();
  //                           final credential =
  //                               FirebaseAuth.instance.currentUser;
  //                           CollectionReference users =
  //                               FirebaseFirestore.instance.collection('hagz');
  //                           users
  //                               .doc(credential!.uid)
  //                               .set({
  //                                 'date_hagz': DateController.text,
  //                                 // "health_status": _value,
  //                                 "health_status": _value,
  //                                 "doctor": "د.محمد احمد",
  //                                 "price": "200",
  //                                 "service":
  //                                     "استشارى زراعة وتقويم الفم والاسنان",
  //                               })
  //                               .then((value) => print('Date added'))
  //                               .catchError((error) =>
  //                                   print('Failed to add date: $error'));
  //                         });
  //                       },
  //                       style: ButtonStyle(
  //                         backgroundColor: MaterialStateProperty.all(
  //                             Color.fromARGB(255, 23, 2, 98)),
  //                         padding: MaterialStateProperty.all(
  //                             EdgeInsets.symmetric(
  //                                 horizontal: 45, vertical: 8)),
  //                         shape: MaterialStateProperty.all(
  //                             RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(8))),
  //                       ),
  //                       child: Text(
  //                         "احجز ميعادك",
  //                         style: TextStyle(fontSize: 19),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

  // showmodel2() {
  //   // final FirebaseFirestore users = FirebaseFirestore.instance;
  //   // CollectionReference users = FirebaseFirestore.instance.collection('Patient');
  //   // final credential = FirebaseAuth.instance;
  //   setState(() {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 150),
  //             child: AlertDialog(
  //               actionsAlignment: MainAxisAlignment.end,
  //               icon: Padding(
  //                 padding: const EdgeInsets.only(left: 210),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     IconButton(
  //                       icon: Icon(
  //                         Icons.cancel_outlined,
  //                         color: Colors.blue,
  //                       ),
  //                       onPressed: () {
  //                         // _globalKey.currentState?.openDrawer();
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               content: Container(
  //                 height: 320,
  //                 width: 460,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       child: Text(
  //                         "اختر الميعاد المناسب لك",
  //                         style: TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.blue),
  //                         textAlign: TextAlign.end,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 200,
  //                       child: TextField(
  //                         controller: DateController,
  //                         keyboardType: TextInputType.datetime,
  //                         obscureText: false,
  //                         textAlign: TextAlign.center,
  //                         decoration: const InputDecoration(
  //                             prefixIcon: Icon(
  //                               Icons.calendar_today_rounded,
  //                               color: Colors.blue,
  //                             ),
  //                             hintText: "mm/dd/yyyy    ",
  //                             hintStyle: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.black)),
  //                         onTap: () async {
  //                           DateTime? pickedDate = await showDatePicker(
  //                               context: context,
  //                               initialDate: DateTime.now(),
  //                               firstDate: DateTime(1000),
  //                               lastDate: DateTime(2100));
  //                           if (pickedDate != null) {
  //                             setState(() {
  //                               DateController.text =
  //                                   DateFormat('yyyy-MM-dd').format(pickedDate);
  //                             });
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 50,
  //                     ),
  //                     Column(
  //                       children: [
  //                         Container(
  //                           child: Text(
  //                             "هل تعاني من أي أمراض مزمنة؟",
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.blue),
  //                             textAlign: TextAlign.end,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         InputDecorator(
  //                           // textAlign: TextAlign.center,
  //                           decoration: decorationTextfield2.copyWith(),
  //                           child: DropdownButtonHideUnderline(
  //                             child: DropdownButton<String>(
  //                                 dropdownColor:
  //                                     Color.fromARGB(255, 132, 184, 227),
  //                                 isDense: true,
  //                                 value: _value,
  //                                 isExpanded: true,
  //                                 // menuMaxHeight: 350,
  //                                 items: [
  //                                   DropdownMenuItem(
  //                                     alignment: AlignmentDirectional.center,
  //                                     child: Text(
  //                                       "الأمراض المزمنة",
  //                                       style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.bold),
  //                                       // textAlign: TextAlign.center,
  //                                       selectionColor: Colors.black,
  //                                     ),
  //                                     value: "",
  //                                   ),
  //                                   ...dropDown
  //                                       .map<DropdownMenuItem<String>>((date) {
  //                                     return DropdownMenuItem(
  //                                       alignment: Alignment.topRight,
  //                                       child: Text(
  //                                         date["title"],
  //                                       ),
  //                                       value: date["title"],
  //                                     );
  //                                   }).toList(),
  //                                 ],
  //                                 onChanged: (value) {
  //                                   setState(() {
  //                                     _value = value!;
  //                                     print(dropDown);
  //                                   });
  //                                 }),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 40,
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           showmodel();
  //                           final credential =
  //                               FirebaseAuth.instance.currentUser;
  //                           CollectionReference users =
  //                               FirebaseFirestore.instance.collection('hagz');
  //                           users
  //                               .doc(credential!.uid)
  //                               .set({
  //                                 'date_hagz': DateController.text,
  //                                 // "health_status": _value,
  //                                 "health_status": _value,
  //                                 "doctor": "د.طارق احمد",
  //                                 "price": "10000",
  //                                 "service":
  //                                     "استشاري اول جراحة الفم والفكين والتقويم",
  //                               })
  //                               .then((value) => print('Date added'))
  //                               .catchError((error) =>
  //                                   print('Failed to add date: $error'));
  //                         });
  //                       },
  //                       style: ButtonStyle(
  //                         backgroundColor: MaterialStateProperty.all(
  //                             Color.fromARGB(255, 23, 2, 98)),
  //                         padding: MaterialStateProperty.all(
  //                             EdgeInsets.symmetric(
  //                                 horizontal: 45, vertical: 8)),
  //                         shape: MaterialStateProperty.all(
  //                             RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(8))),
  //                       ),
  //                       child: Text(
  //                         "احجز ميعادك",
  //                         style: TextStyle(fontSize: 19),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

  // showmodel3() {
  //   // final FirebaseFirestore users = FirebaseFirestore.instance;
  //   // CollectionReference users = FirebaseFirestore.instance.collection('Patient');
  //   // final credential = FirebaseAuth.instance;
  //   setState(() {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 150),
  //             child: AlertDialog(
  //               actionsAlignment: MainAxisAlignment.end,
  //               icon: Padding(
  //                 padding: const EdgeInsets.only(left: 210),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     IconButton(
  //                       icon: Icon(
  //                         Icons.cancel_outlined,
  //                         color: Colors.blue,
  //                       ),
  //                       onPressed: () {
  //                         // _globalKey.currentState?.openDrawer();
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               content: Container(
  //                 height: 320,
  //                 width: 460,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       child: Text(
  //                         "اختر الميعاد المناسب لك",
  //                         style: TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.blue),
  //                         textAlign: TextAlign.end,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 200,
  //                       child: TextField(
  //                         controller: DateController,
  //                         keyboardType: TextInputType.datetime,
  //                         obscureText: false,
  //                         textAlign: TextAlign.center,
  //                         decoration: const InputDecoration(
  //                             prefixIcon: Icon(
  //                               Icons.calendar_today_rounded,
  //                               color: Colors.blue,
  //                             ),
  //                             hintText: "mm/dd/yyyy    ",
  //                             hintStyle: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.black)),
  //                         onTap: () async {
  //                           DateTime? pickedDate = await showDatePicker(
  //                               context: context,
  //                               initialDate: DateTime.now(),
  //                               firstDate: DateTime(1000),
  //                               lastDate: DateTime(2100));
  //                           if (pickedDate != null) {
  //                             setState(() {
  //                               DateController.text =
  //                                   DateFormat('yyyy-MM-dd').format(pickedDate);
  //                             });
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 50,
  //                     ),
  //                     Column(
  //                       children: [
  //                         Container(
  //                           child: Text(
  //                             "هل تعاني من أي أمراض مزمنة؟",
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.blue),
  //                             textAlign: TextAlign.end,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         InputDecorator(
  //                           // textAlign: TextAlign.center,
  //                           decoration: decorationTextfield2.copyWith(),
  //                           child: DropdownButtonHideUnderline(
  //                             child: DropdownButton<String>(
  //                                 dropdownColor:
  //                                     Color.fromARGB(255, 132, 184, 227),
  //                                 isDense: true,
  //                                 value: _value,
  //                                 isExpanded: true,
  //                                 // menuMaxHeight: 350,
  //                                 items: [
  //                                   DropdownMenuItem(
  //                                     alignment: AlignmentDirectional.center,
  //                                     child: Text(
  //                                       "الأمراض المزمنة",
  //                                       style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.bold),
  //                                       // textAlign: TextAlign.center,
  //                                       selectionColor: Colors.black,
  //                                     ),
  //                                     value: "",
  //                                   ),
  //                                   ...dropDown
  //                                       .map<DropdownMenuItem<String>>((date) {
  //                                     return DropdownMenuItem(
  //                                       alignment: Alignment.topRight,
  //                                       child: Text(
  //                                         date["title"],
  //                                       ),
  //                                       value: date["title"],
  //                                     );
  //                                   }).toList(),
  //                                 ],
  //                                 onChanged: (value) {
  //                                   setState(() {
  //                                     _value = value!;
  //                                     print(dropDown);
  //                                   });
  //                                 }),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 40,
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           showmodel();
  //                           final credential =
  //                               FirebaseAuth.instance.currentUser;
  //                           CollectionReference users =
  //                               FirebaseFirestore.instance.collection('hagz');
  //                           users
  //                               .doc(credential!.uid)
  //                               .set({
  //                                 'date_hagz': DateController.text,
  //                                 // "health_status": _value,
  //                                 "health_status": _value,
  //                                 "doctor": "د.كريم السيد",
  //                                 "price": "4500",
  //                                 "service":
  //                                     "اخصائي زراعة وتركيبات الاسنان وطب الاسنان التجميلي",
  //                               })
  //                               .then((value) => print('Date added'))
  //                               .catchError((error) =>
  //                                   print('Failed to add date: $error'));
  //                         });
  //                       },
  //                       style: ButtonStyle(
  //                         backgroundColor: MaterialStateProperty.all(
  //                             Color.fromARGB(255, 23, 2, 98)),
  //                         padding: MaterialStateProperty.all(
  //                             EdgeInsets.symmetric(
  //                                 horizontal: 45, vertical: 8)),
  //                         shape: MaterialStateProperty.all(
  //                             RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(8))),
  //                       ),
  //                       child: Text(
  //                         "احجز ميعادك",
  //                         style: TextStyle(fontSize: 19),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

  List dropDown = [
    {"title": "لا يوجد"},
    {"title": "أمراض القلب والأوعية الدموية"},
    {"title": "أمراض الجهاز التنفسي"},
    {"title": "السرطان"},
    {"title": "الصرع والنوبات"},
    {"title": "مشاكل صحة الفم"},
    {"title": "الجلوكوما"},
    {"title": "التصلب اللويجي"},
    {"title": "مرض باراكنسون"},
    {"title": "سيولة الدم"},
    {"title": "أمراض الجهاز الهضمي"},
  ];
  String _value = "";
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EditProfilePatient()),
            );
            // Navigator.pop(context);
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
      body: SingleChildScrollView(
        child: Stack(
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
            // SizedBox(
            //   height: 50,
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "د.محمد احمد",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 25, 58, 114)),
                                  ),
                                  Text("استشاري زراعة وتقويم الاسنان",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 25, 58, 114))),
                                  Text("دكتوراة في جراحة الفم والاسنان",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 25, 58, 114))),                               
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Image.asset("assets/images/dr.png"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // showmodel();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingPage(),
                                  ),
                                );
                                final credential =
                                  FirebaseAuth.instance.currentUser;
                              CollectionReference users =
                                  FirebaseFirestore.instance.collection('hagz');
                              users
                                  .doc(credential!.uid)
                                  .set({                                 
                                    "doc": "71oDwcR8BGZhyqqB30LH65zeY3w2",
                                    "doctor": "د.محمد احمد",
                                    "price": "200",
                                    "Specialization":
                                        "استشارى زراعة وتقويم الفم والاسنان",
                                  })
                                  .then((value) => print('Date added'))
                                  .catchError((error) =>
                                      print('Failed to add date: $error'));
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 90, 154, 249)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 3)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55))),
                            ),
                            child: Text(
                              "حجز",
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 90),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "د.طارق احمد",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 25, 58, 114)),
                                  ),
                                  Text("استشاري اول جراحة الفم",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 25, 58, 114))),
                                  Text("والفكين والتقويم",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 25, 58, 114))),
                                  SizedBox(
                                    height: 5,
                                  ),                                
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Image.asset("assets/images/dr.png"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingPage2(),
                                  ),
                                );
                                final credential =
                                  FirebaseAuth.instance.currentUser;
                              CollectionReference users =
                                  FirebaseFirestore.instance.collection('hagz');
                              users
                                  .doc(credential!.uid)
                                  .set({
                                    "doc": "kuL8sSGtJMOFjfCOL7YdqfAtXDw1",
                                    "doctor": "د.طارق احمد",
                                    "price": "1200",
                                    "Specialization":
                                        "استشاري اول جراحة الفم والفكين والتقويم",
                                  })
                                  .then((value) => print('Date added'))
                                  .catchError((error) =>
                                      print('Failed to add date: $error'));
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 90, 154, 249)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 3)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55))),
                            ),
                            child: Text(
                              "حجز",
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "د.كريم السيد",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 25, 58, 114)),
                                  ),
                                  Text("اخصائي زراعة وتركيبات الاسنان",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 25, 58, 114))),
                                  Text("    وطب الاسنان التجميلي",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 25, 58, 114))),                               
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Image.asset("assets/images/dr.png"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingPage3(),
                                ),
                              );
                               final credential =
                                  FirebaseAuth.instance.currentUser;
                              CollectionReference users =
                                  FirebaseFirestore.instance.collection('hagz');
                              users
                                  .doc(credential!.uid)
                                  .set({
                                    "doc": "K9x5vdSJSUXdOwRRQSif7G9JVKC2",
                                    "doctor": "د.كريم السيد",
                                    "price": "4000",
                                    "Specialization":
                                        "اخصائي زراعة وتركيبات الاسنان وطب الاسنان التجميلي",
                                  })
                                  .then((value) => print('Date added'))
                                  .catchError((error) =>
                                      print('Failed to add date: $error'));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 90, 154, 249)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 3)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55))),
                            ),
                            child: Text(
                              "حجز",
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
 
 
 
 
 
 
 
  // showmodel2() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 150),
  //           child: AlertDialog(
  //             icon: Padding(
  //               padding: const EdgeInsets.only(left: 210),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   IconButton(
  //                     icon: Icon(
  //                       Icons.cancel_outlined,
  //                       color: Colors.blue,
  //                     ),
  //                     onPressed: () {
  //                       // _globalKey.currentState?.openDrawer();
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             content: Container(
  //               height: 320,
  //               width: 460,
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     child: Text(
  //                       "اختر الميعاد المناسب لك",
  //                       style: TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.blue),
  //                       textAlign: TextAlign.end,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 200,
  //                     child: TextField(
  //                       keyboardType: TextInputType.datetime,
  //                       obscureText: false,
  //                       textAlign: TextAlign.center,
  //                       controller: DateController,
  //                       decoration: const InputDecoration(
  //                           prefixIcon: Icon(
  //                             Icons.calendar_today_rounded,
  //                             color: Colors.blue,
  //                           ),
  //                           hintText: "mm/dd/yyyy    ",
  //                           hintStyle: TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black)),
  //                       onTap: () async {
  //                         DateTime? pickedDate = await showDatePicker(
  //                             context: context,
  //                             initialDate: DateTime.now(),
  //                             firstDate: DateTime(1000),
  //                             lastDate: DateTime(2100));
  //                         if (pickedDate != null) {
  //                           setState(() {
  //                             DateController.text =
  //                                 DateFormat('yyyy-MM-dd').format(pickedDate);
  //                           });
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 50,
  //                   ),
  //                   Column(
  //                     children: [
  //                       Container(
  //                         child: Text(
  //                           "هل تعاني من أي أمراض مزمنة؟",
  //                           style: TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.blue),
  //                           textAlign: TextAlign.end,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       InputDecorator(
  //                         // textAlign: TextAlign.center,
  //                         decoration: decorationTextfield2.copyWith(),

  //                         child: DropdownButtonHideUnderline(
  //                           child: DropdownButton<String>(
  //                               dropdownColor:
  //                                   Color.fromARGB(255, 132, 184, 227),
  //                               isDense: true,
  //                               value: _value,
  //                               isExpanded: true,
  //                               // menuMaxHeight: 350,
  //                               items: [
  //                                 DropdownMenuItem(
  //                                   alignment: AlignmentDirectional.center,
  //                                   child: Text(
  //                                     "الأمراض المزمنة",
  //                                     style: TextStyle(
  //                                         fontSize: 20,
  //                                         fontWeight: FontWeight.bold),
  //                                     // textAlign: TextAlign.center,
  //                                     selectionColor: Colors.black,
  //                                   ),
  //                                   value: "",
  //                                 ),
  //                                 ...dropDown
  //                                     .map<DropdownMenuItem<String>>((date) {
  //                                   return DropdownMenuItem(
  //                                     alignment: Alignment.topRight,
  //                                     child: Text(
  //                                       date["title"],
  //                                     ),
  //                                     value: date["value"],
  //                                   );
  //                                 }).toList(),
  //                               ],
  //                               onChanged: (value) {
  //                                 setState(() {
  //                                   _value = value!;
  //                                   print(dropDown);
  //                                 });
  //                               }),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 40,
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () {},
  //                     style: ButtonStyle(
  //                       backgroundColor: MaterialStateProperty.all(
  //                           Color.fromARGB(255, 23, 2, 98)),
  //                       padding: MaterialStateProperty.all(
  //                           EdgeInsets.symmetric(horizontal: 45, vertical: 8)),
  //                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(8))),
  //                     ),
  //                     child: Text(
  //                       "احجز ميعادك",
  //                       style: TextStyle(fontSize: 19),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // showmodel3() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 150),
  //           child: AlertDialog(
  //             icon: Padding(
  //               padding: const EdgeInsets.only(left: 210),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   IconButton(
  //                     icon: Icon(
  //                       Icons.cancel_outlined,
  //                       color: Colors.blue,
  //                     ),
  //                     onPressed: () {
  //                       // _globalKey.currentState?.openDrawer();
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             content: Container(
  //               height: 320,
  //               width: 460,
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     child: Text(
  //                       "اختر الميعاد المناسب لك",
  //                       style: TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.blue),
  //                       textAlign: TextAlign.end,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 200,
  //                     child: TextField(
  //                       keyboardType: TextInputType.datetime,
  //                       obscureText: false,
  //                       textAlign: TextAlign.center,
  //                       controller: DateController,
  //                       decoration: const InputDecoration(
  //                           prefixIcon: Icon(
  //                             Icons.calendar_today_rounded,
  //                             color: Colors.blue,
  //                           ),
  //                           hintText: "mm/dd/yyyy    ",
  //                           hintStyle: TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black)),
  //                       onTap: () async {
  //                         DateTime? pickedDate = await showDatePicker(
  //                             context: context,
  //                             initialDate: DateTime.now(),
  //                             firstDate: DateTime(1000),
  //                             lastDate: DateTime(2100));
  //                         if (pickedDate != null) {
  //                           setState(() {
  //                             DateController.text =
  //                                 DateFormat('yyyy-MM-dd').format(pickedDate);
  //                           });
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 50,
  //                   ),
  //                   Column(
  //                     children: [
  //                       Container(
  //                         child: Text(
  //                           "هل تعاني من أي أمراض مزمنة؟",
  //                           style: TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.blue),
  //                           textAlign: TextAlign.end,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       InputDecorator(
  //                         // textAlign: TextAlign.center,
  //                         decoration: decorationTextfield2.copyWith(),

  //                         child: DropdownButtonHideUnderline(
  //                           child: DropdownButton<String>(
  //                               dropdownColor:
  //                                   Color.fromARGB(255, 132, 184, 227),
  //                               isDense: true,
  //                               value: _value,
  //                               isExpanded: true,
  //                               // menuMaxHeight: 350,
  //                               items: [
  //                                 DropdownMenuItem(
  //                                   alignment: AlignmentDirectional.center,
  //                                   child: Text(
  //                                     "الأمراض المزمنة",
  //                                     style: TextStyle(
  //                                         fontSize: 20,
  //                                         fontWeight: FontWeight.bold),
  //                                     // textAlign: TextAlign.center,
  //                                     selectionColor: Colors.black,
  //                                   ),
  //                                   value: "",
  //                                 ),
  //                                 ...dropDown
  //                                     .map<DropdownMenuItem<String>>((date) {
  //                                   return DropdownMenuItem(
  //                                     alignment: Alignment.topRight,
  //                                     child: Text(
  //                                       date["title"],
  //                                     ),
  //                                     value: date["value"],
  //                                   );
  //                                 }).toList(),
  //                               ],
  //                               onChanged: (value) {
  //                                 setState(() {
  //                                   _value = value!;
  //                                   print(dropDown);
  //                                 });
  //                               }),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 40,
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () {},
  //                     style: ButtonStyle(
  //                       backgroundColor: MaterialStateProperty.all(
  //                           Color.fromARGB(255, 23, 2, 98)),
  //                       padding: MaterialStateProperty.all(
  //                           EdgeInsets.symmetric(horizontal: 45, vertical: 8)),
  //                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(8))),
  //                     ),
  //                     child: Text(
  //                       "احجز ميعادك",
  //                       style: TextStyle(fontSize: 19),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }