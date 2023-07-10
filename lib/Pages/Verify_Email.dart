// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'dart:async';
// import 'package:ebtsamty/Pages/Home_Page.dart';
// import 'package:ebtsamty/shared/SnackBar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class VerifyEmailPage extends StatefulWidget {
//   VerifyEmailPage({Key? key}) : super(key: key);

//   @override
//   State<VerifyEmailPage> createState() => _VerifyEmailPageState();
// }

// class _VerifyEmailPageState extends State<VerifyEmailPage> {
//   bool isEmailVerified = false;
//   bool canResendEmail = false;
//   Timer? timer;

//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
//     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

//     if (!isEmailVerified) {
//       sendVerificationEmail();

//       timer = Timer.periodic(Duration(seconds: 12), (timer) async {
//         // when we click on the link that existed on yahoo
//         await FirebaseAuth.instance.currentUser!.reload();

//         // is email verified or not (clicked on the link or not) (true or false)
//         setState(() {
//           isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//         });

//         if (isEmailVerified) {
//           timer.cancel();
//         }
//       });
//     }
//   }

//   sendVerificationEmail() async {
//     try {
//       await FirebaseAuth.instance.currentUser!.sendEmailVerification();
//       setState(() {
//         canResendEmail = false;
//       });
//       await Future.delayed(Duration(seconds: 12));
//       setState(() {
//         canResendEmail = true;
//       });
//     } catch (e) {
//       showSnackBar(context, "ERROR => ${e.toString()}");
//     }
//   }

//   @override
//   void dispose() {
//     // ignore: todo
//     // TODO: implement dispose
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: isEmailVerified
//           ? HomePage()
//           : Scaffold(
//               backgroundColor: const Color.fromARGB(232, 243, 248, 255),
//               body: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "تم إرسال بريد إلكتروني للتحقق إلى بريدك الإلكتروني",
//                       style: TextStyle(fontSize: 20),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         canResendEmail ? sendVerificationEmail() : null;
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                             Color.fromARGB(255, 90, 154, 249)),
//                         padding: MaterialStateProperty.all(EdgeInsets.all(12)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8))),
//                       ),
//                       child: Text(
//                         "تفقد البريد الإلكتروني",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 11,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         FirebaseAuth.instance.signOut();
//                       },
//                       // style: ButtonStyle(
//                       //   backgroundColor: MaterialStateProperty.all(BTNpink),
//                       //   padding: MaterialStateProperty.all(EdgeInsets.all(12)),
//                       //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(8))),
//                       // ),
//                       child: Text(
//                         "إلغاء",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
