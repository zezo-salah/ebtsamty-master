// ignore_for_file: unused_import
import 'package:ebtsamty/Pages/Certificates.dart';
import 'package:ebtsamty/Pages/DateDoctor.dart';
import 'package:ebtsamty/Pages/DatePatient.dart';
import 'package:ebtsamty/Pages/Health%20statement.dart';
import 'package:ebtsamty/Pages/Home_Page.dart';
import 'package:ebtsamty/Pages/Invoices.dart';
import 'package:ebtsamty/Pages/LogoScreen.dart';
import 'package:ebtsamty/Pages/Profile_Doctor.dart';
import 'package:ebtsamty/Pages/Profile_Patient.dart';
// import 'package:ebtsamty/Pages/Profile_Doctor.dart';
import 'package:ebtsamty/Pages/Register_Patient.dart';
import 'package:ebtsamty/Pages/Register_doctor.dart';
import 'package:ebtsamty/Pages/Reservation.dart';
import 'package:ebtsamty/Pages/Sigin.dart';
import 'package:ebtsamty/Pages/StartScreen.dart';
import 'package:ebtsamty/Pages/The%20prescription.dart';
import 'package:ebtsamty/Pages/Verify_Email.dart';
import 'package:ebtsamty/Pages/Booking_Now.dart';
import 'package:ebtsamty/Pages/join_us.dart';
import 'package:ebtsamty/Pages/test.dart';
import 'package:ebtsamty/shared/SnackBar.dart';
import 'package:ebtsamty/shared/google_signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:DatePatientPage (),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "هناك خطأ ما");
            } else if (snapshot.hasData) {
              // return HomePage();
              return HomePage();
            } else {
              return LogoScreen();
            }
          }),
    );
  }
}
