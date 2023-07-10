// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Home_Page.dart';
import 'package:ebtsamty/Pages/Sigin.dart';
import 'package:ebtsamty/Pages/join_us.dart';
import 'package:ebtsamty/shared/Gender_Selection_Controllar.dart';
import 'package:ebtsamty/shared/SnackBar.dart';
import 'package:ebtsamty/shared/gender_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';

class PatientScreenRegister extends StatefulWidget {
  PatientScreenRegister({super.key});
  @override
  State<PatientScreenRegister> createState() => _PatientScreenRegisterState();
}

class _PatientScreenRegisterState extends State<PatientScreenRegister> {
  String createUniqueCode() {
    Random random = Random();
    int value = random.nextInt(90000) +
        10000; // يتم إنشاء رقم عشوائي يتراوح بين 10000 و 99999
    String code = value.toString();
    return code;
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  GenderSelectionControllar genderSelectionControllar =
      Get.put(GenderSelectionControllar());
  var selectedGender = "";
  bool _Isvisibility = false;
  bool _Isvisibility2 = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _FormKey = GlobalKey<FormState>();
  bool _IsLoading = false;
  _Register2() async {
    setState(() {
      _IsLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print(credential.user!.uid);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      CollectionReference users =
          FirebaseFirestore.instance.collection('Patient');
      String code = createUniqueCode();
      QuerySnapshot querySnapshot =
          await users.where("code", isEqualTo: code).get();
      while (querySnapshot.docs.isNotEmpty) {
        code = createUniqueCode();
        querySnapshot = await users.where("code", isEqualTo: code).get();
      }
      users
          .doc(credential.user!.uid)
          .set({
            'code': code,
            "first_name": _firstNameController.text,
            "last_name": _lastNameController.text,
            "phone_number": _phoneController.text,
            "date": _dateController.text,
            "age": _ageController.text,
            "email": _emailController.text,
            "password": _passwordController.text,
            "confirmPass": _confirmpasswordController.text,
            "gender": genderSelectionControllar.selectedGender.value,
            "type": "Patient",
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "كلمة المرور المقدمة ضعيفة للغاية");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'الحساب موجود بالفعل لهذا البريد الإلكتروني');
      } else {
        showSnackBar(context, 'خطأ - يرجى المحاولة مرة أخرى في وقت أخر');
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
    setState(() {
      _IsLoading = false;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _genderController.dispose();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (_rect) => const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.white24, Colors.transparent],
            ).createShader(_rect),
            blendMode: BlendMode.darken,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/patient.jpeg"),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black38, BlendMode.darken)),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.white54,
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
                    MaterialPageRoute(
                      builder: (context) => joinUs(),
                    ),
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
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _FormKey,
                child: Column(
                  children: [
                    // Container(
                    //   // color: Colors.amber,
                    //   height: 55,
                    //   padding: const EdgeInsets.only(left: 320),
                    //   child: Image.asset(
                    //     "assets/icons/Logo2.png",
                    //     width: 200,
                    //   ),
                    // ),
                    const Text(
                      "التسجيل كمريض",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            hintText: "الاسم الاول",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.family_restroom_sharp,
                              color: Colors.blue,
                            ),
                            hintText: "اسم العائلة",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_in_talk,
                              color: Colors.blue,
                            ),
                            hintText: "ادخل رقم هاتفك",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        keyboardType: TextInputType.datetime,
                        obscureText: false,
                        textAlign: TextAlign.end,
                        controller: _dateController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.blue,
                            ),
                            hintText: "ادخل تاريخ ميلادك",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            int age = calculateAge(pickedDate);
                            setState(() {
                              _dateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              _ageController.text = age.toString();
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: // we return "null" when something is valid
                            (_email) {
                          return _email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "أدخل بريد إلكتروني صحيح";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.g_mobiledata_sharp,
                              size: 50,
                              color: Colors.blue,
                            ),
                            hintText: "ادخل بريدك الالكتروني",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        // we return "null" when something is valid
                        // validator: (value) {
                        //   return value!.length < 8
                        //       ? "استخدام 8 أحرف على الأقل"
                        //       : null;
                        // },

                        validator: (_PassCurrentValue) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{8,}$');
                          var passNonNullValue = _PassCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("كلمة المرور مطلوبة");
                          } else if (passNonNullValue.length < 4) {
                            return ("كلمة المرور يجب أن تكون أكثر من 4 أحرف");
                          } else if (!regex.hasMatch(passNonNullValue)) {
                            return ("({!?@#\$&*~},ارقام,احرف)يجب أن تحتوي كلمة المرور على");
                          }
                          if (_PassCurrentValue!.isEmpty) return 'فارغ';
                          return null;

                          // return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _Isvisibility ? false : true,
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _Isvisibility = !_Isvisibility;
                                    // PasswordController == PasswordController2;
                                  });
                                },
                                icon: _Isvisibility
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.blue,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.blue,
                                      )),
                            hintText: "ادخل كلمه السر",
                            hintStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        // we return "null" when something is valid
                        // validator: (value) {
                        //   return value!.length < 8
                        //       ? "استخدام 8 أحرف على الأقل"
                        //       : null;
                        // },
                        validator: (_PassCurrentValue) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{8,}$');
                          var passNonNullValue = _PassCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("كلمة المرور مطلوبة");
                          } else if (passNonNullValue.length < 4) {
                            return ("كلمة المرور يجب أن تكون أكثر من 4 أحرف");
                          } else if (!regex.hasMatch(passNonNullValue)) {
                            return ("({!?@#\$&*~},-ارقام,احرف)يجب أن تحتوي كلمة المرور على");
                          }
                          if (_PassCurrentValue!.isEmpty) ;
                          if (_PassCurrentValue != _passwordController.text)
                            return 'لا يتطابق';
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _Isvisibility2 ? false : true,
                        controller: _confirmpasswordController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _Isvisibility2 = !_Isvisibility2;
                                    // PasswordController2 == PasswordController;
                                  });
                                },
                                icon: _Isvisibility2
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.blue,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.blue,
                                      )),
                            hintText: "تاكيد كلمة السر",
                            hintStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GenderSelection(
                      controller: _genderController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() async {
                          if (_FormKey.currentState!.validate()) {
                            await _Register2();
                            if (!mounted) return;
                            //  Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomePage()),
                            //   );
                          } else {
                            showSnackBar(context, 'كلمة السر غير متطابقان');
                          }
                        });
                      },
                      child: _IsLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "قم بالتسجيل",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 90, 154, 249)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 111, vertical: 12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(66))),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()),
                          );
                        },
                        child: const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}



//  int calculateAge(DateTime birthDate) {
//     DateTime currentDate = DateTime.now();
//     int age = currentDate.year - birthDate.year;
//     if (currentDate.month < birthDate.month ||
//         (currentDate.month == birthDate.month &&
//             currentDate.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }

//   GenderSelectionControllar genderSelectionControllar =
//       Get.put(GenderSelectionControllar());
//   var selectedGender = "";
//   bool _Isvisibility = false;
//   bool _Isvisibility2 = false;
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _dateController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmpasswordController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _genderController = TextEditingController();
//   final _FormKey = GlobalKey<FormState>();
//   bool _IsLoading = false;
//   _Register2() async {
//     setState(() {
//       _IsLoading = true;
//     });
//     try {
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       print(credential.user!.uid);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//       CollectionReference users =
//           FirebaseFirestore.instance.collection('Patient');

//       users
//           .doc(credential.user!.uid)
//           .set({
//             "first_name": _firstNameController.text,
//             "last_name": _lastNameController.text,
//             "phone_number": _phoneController.text,
//             "date": _dateController.text,
//             "age": _ageController.text,
//             "email": _emailController.text,
//             "password": _passwordController.text,
//             "confirmPass": _confirmpasswordController.text,
//             "gender": genderSelectionControllar.selectedGender.value,
//             "type": "Patient",
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         showSnackBar(context, "كلمة المرور المقدمة ضعيفة للغاية");
//       } else if (e.code == 'email-already-in-use') {
//         showSnackBar(context, 'الحساب موجود بالفعل لهذا البريد الإلكتروني');
//       } else {
//         showSnackBar(context, 'خطأ - يرجى المحاولة مرة أخرى في وقت أخر');
//       }
//     } catch (error) {
//       showSnackBar(context, error.toString());
//     }
//     setState(() {
//       _IsLoading = false;
//     });
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     _dateController.dispose();
//     _ageController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmpasswordController.dispose();
//     _genderController.dispose();
//     // ignore: todo
//     // TODO: implement dispose
//     super.dispose();
//   }