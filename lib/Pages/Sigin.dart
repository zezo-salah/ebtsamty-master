// ignore_for_file: file_names, implementation_imports, unnecessary_import, unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:ebtsamty/Pages/Forgot_Password.dart';
import 'package:ebtsamty/Pages/Home_Page.dart';
import 'package:ebtsamty/Pages/join_us.dart';
import 'package:ebtsamty/shared/SnackBar.dart';
import 'package:ebtsamty/shared/custom_textfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool Isvisibility = false;
  bool isLoading = false;
  final _EmailController = TextEditingController();
  final _PasswordController = TextEditingController();
  SigIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _EmailController.text,
        password: _PasswordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :${e.code}");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _EmailController.dispose();
    _PasswordController.dispose();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(232, 243, 248, 255),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(0, 243, 248, 255),
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
          // backgroundColor: Colors.blue,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   height: 65,
                //   padding: EdgeInsets.only(left: 320),
                //   child: Image.asset(
                //     "assets/icons/Logo2.png",
                //     width: 200,
                //   ),
                // ),
                Container(
                  // color: Colors.amber,
                  height: 275,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    "assets/images/doctor2.png",
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  padding: EdgeInsets.only(right: 42),
                  width: double.infinity,
                  child: Text(
                    "ادخل اسم المستخدم",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Center(
                    child: Container(
                  padding: EdgeInsets.only(left: 25, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 155, 191, 245),
                  ),
                  width: 320,
                  height: 50,
                  child: TextField(
                    controller: _EmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: decorationTextfield.copyWith(
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 19),
                    ),
                  ),
                )),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(right: 42),
                  width: double.infinity,
                  child: Text(
                    "ادخل كلمة المرور",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Center(
                    child: Container(
                  padding: EdgeInsets.only(left: 25, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 155, 191, 245),
                  ),
                  width: 320,
                  height: 50,
                  child: TextField(
                    obscureText: Isvisibility ? false : true,
                    controller: _PasswordController,
                    keyboardType: TextInputType.text,
                    decoration: decorationTextfield.copyWith(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              Isvisibility = !Isvisibility;
                            });
                          },
                          icon: Isvisibility
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.blue,
                                )),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 19),
                    ),
                  ),
                )),
                SizedBox(
                  height: 1,
                ),
                Container(
                  // color: Colors.amber,
                  padding: EdgeInsets.only(left: 140),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()),
                      );
                    },
                    child: Text(
                      "نسيت كلمة المرور",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await SigIn();
                    if (!mounted) return;
                    // showSnackBar(context, "done..");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 90, 154, 249)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 111, vertical: 12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(66))),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const joinUs()),
                      );
                    },
                    child: Text(
                      "مستخدم جديد",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
              ],
            ),
          )),
    );
  }
}



// Center(
//                           child: Container(
//                             padding:
//                                 EdgeInsets.fromLTRB(30, 10, 30, 10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               color: Color.fromARGB(255, 113, 169, 252),
//                             ),
//                             width: 266,
//                             child: TextField(
//                               obscureText: true,
//                               // keyboardType: TextInputType.name,
//                               textInputAction: TextInputAction.next,
//                               decoration: InputDecoration(
//                                   icon: Icon(Icons.visibility),
//                                   // suffixIcon: Icon(Icons.visibility),
//                                   border: InputBorder.none,
//                                   hintText: "Password:",
//                                   hintStyle: TextStyle(fontSize: 19)
//                                   // icon:Icon(Icons.lock,color: Color.fromARGB(255, 156, 48, 186),)
//                                   ),
//                             ),
//                           ),
//                         ),





// Container(
//                   // color: Colors.amber,
//                   width: double.infinity,
//                   padding: EdgeInsets.only(right: 0),
//                   child: TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         "نسيت كلمة المرور",
//                         style:
//                             TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.right,
                
//                       )
//                       ),
//                 ),