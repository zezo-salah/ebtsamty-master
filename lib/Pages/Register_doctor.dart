// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable
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

class DoctorScreenRegister extends StatefulWidget {
  DoctorScreenRegister({super.key});
  @override
  State<DoctorScreenRegister> createState() => _DoctorScreenRegisterState();
}

class _DoctorScreenRegisterState extends State<DoctorScreenRegister> {
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
  // bool isGender = false;
  bool Isvisibility = false;
  bool Isvisibility2 = false;
  List dropDown = [
    {"title": "قسم الفم والفكين وأمراض الفم واللثة"},
    {"title": "قسم المالجة التحفظية"},
    {"title": "قسم أسنان الاطفال والتقويم"},
    {"title": "قسم الاستعاضات السنية المتحركة"},
    {"title": "اخصائي زراعة وتركيبات الاسنان"},
  ];
  String _value = "";
  final FirstNameController = TextEditingController();
  final LastNameController = TextEditingController();
  final PhoneController = TextEditingController();
  final DateController = TextEditingController();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final GenderController = TextEditingController();
  final ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text,
        password: PasswordController.text,
      );
      print(credential.user!.uid);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      CollectionReference users =
          FirebaseFirestore.instance.collection('Doctor');
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
            "first_name": FirstNameController.text,
            "last_name": LastNameController.text,
            "phone_number": PhoneController.text,
            "date": DateController.text,
            "age": ageController.text,
            "email": EmailController.text,
            "password": PasswordController.text,
            "confirmPass": confirmpasswordController.text,
            "gender": genderSelectionControllar.selectedGender.value,
            "department": _value,
            "type": "Doctor",
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
      isLoading = false;
    });
  }

  @override
  void dispose() {
    FirstNameController.dispose();
    LastNameController.dispose();
    PhoneController.dispose();
    DateController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    confirmpasswordController.dispose();
    GenderController.dispose();
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
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.white24, Colors.transparent],
            ).createShader(rect),
            blendMode: BlendMode.darken,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/doctor.jpeg"),
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
                key: _formKey,
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
                      "التسجيل كطبيب",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: FirstNameController,
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
                        controller: LastNameController,
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
                        controller: PhoneController,
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
                        controller: DateController,
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
                              DateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              ageController.text = age.toString();
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      child: ListView(
                        children: [
                          InputDecorator(
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                              Icons.person_add_alt_1,
                              color: Colors.blue,
                            )),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  isDense: true,
                                  value: _value,
                                  isExpanded: true,
                                  // menuMaxHeight: 350,
                                  items: [
                                    DropdownMenuItem(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Text(
                                        "الاقسام",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        // textAlign: TextAlign.center,
                                        selectionColor: Colors.black,
                                      ),
                                      value: "",
                                    ),
                                    ...dropDown
                                        .map<DropdownMenuItem<String>>((date) {
                                      return DropdownMenuItem(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          date["title"],
                                        ),
                                        value: date["title"],
                                      );
                                    }).toList(),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value!;
                                      print(dropDown);
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: // we return "null" when something is valid
                            (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "أدخل بريد إلكتروني صحيح";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: EmailController,
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

                        validator: (PassCurrentValue) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{8,}$');
                          var passNonNullValue = PassCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("كلمة المرور مطلوبة");
                          } else if (passNonNullValue.length < 4) {
                            return ("كلمة المرور يجب أن تكون أكثر من 4 أحرف");
                          } else if (!regex.hasMatch(passNonNullValue)) {
                            return ("({!?@#\$&*~},ارقام,احرف)يجب أن تحتوي كلمة المرور على");
                          }
                          if (PassCurrentValue!.isEmpty) return 'فارغ';
                          return null;

                          // return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: Isvisibility ? false : true,
                        controller: PasswordController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Isvisibility = !Isvisibility;
                                    // PasswordController == PasswordController2;
                                  });
                                },
                                icon: Isvisibility
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
                        validator: (PassCurrentValue) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{8,}$');
                          var passNonNullValue = PassCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("كلمة المرور مطلوبة");
                          } else if (passNonNullValue.length < 4) {
                            return ("كلمة المرور يجب أن تكون أكثر من 4 أحرف");
                          } else if (!regex.hasMatch(passNonNullValue)) {
                            return ("({!?@#\$&*~},ارقام,احرف)يجب أن تحتوي كلمة المرور على");
                          }
                          if (PassCurrentValue!.isEmpty) ;
                          if (PassCurrentValue != PasswordController.text)
                            return 'لا يتطابق';
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: Isvisibility2 ? false : true,
                        controller: confirmpasswordController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Isvisibility2 = !Isvisibility2;
                                    // PasswordController2 == PasswordController;
                                  });
                                },
                                icon: Isvisibility2
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
                      controller: GenderController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await register();
                          if (!mounted) return;
                          // setState(() {
                          //   Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomePage()),
                          //   );
                          // });
                        } else {
                          showSnackBar(context, 'كلمة السر غير متطابقان');
                        }
                      },
                      child: isLoading
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













  // int calculateAge(DateTime birthDate) {
  //   DateTime currentDate = DateTime.now();
  //   int age = currentDate.year - birthDate.year;
  //   if (currentDate.month < birthDate.month ||
  //       (currentDate.month == birthDate.month &&
  //           currentDate.day < birthDate.day)) {
  //     age--;
  //   }
  //   return age;
  // }

  // GenderSelectionControllar genderSelectionControllar =
  //     Get.put(GenderSelectionControllar());
  // var selectedGender = "";
  // // bool isGender = false;
  // bool Isvisibility = false;
  // bool Isvisibility2 = false;
  // List dropDown = [
  //   {"title": "قسم الفم والفكين وأمراض الفم واللثة"},
  //   {"title": "قسم المالجة التحفظية"},
  //   {"title": "قسم أسنان الاطفال والتقويم"},
  //   {"title": "قسم الاستعاضات السنية المتحركة"},
  //   {"title": "اخصائي زراعة وتركيبات الاسنان"},
  // ];
  // String _value = "";
  // final FirstNameController = TextEditingController();
  // final LastNameController = TextEditingController();
  // final PhoneController = TextEditingController();
  // final DateController = TextEditingController();
  // final EmailController = TextEditingController();
  // final PasswordController = TextEditingController();
  // final confirmpasswordController = TextEditingController();
  // final GenderController = TextEditingController();
  // final ageController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  // bool isLoading = false;
  // register() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: EmailController.text,
  //       password: PasswordController.text,
  //     );
  //     print(credential.user!.uid);
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //     );
  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('Doctor');

  //     users
  //         .doc(credential.user!.uid)
  //         .set({
  //           "first_name": FirstNameController.text,
  //           "last_name": LastNameController.text,
  //           "phone_number": PhoneController.text,
  //           "date": DateController.text,
  //           "age": ageController.text,
  //           "email": EmailController.text,
  //           "password": PasswordController.text,
  //           "confirmPass": confirmpasswordController.text,
  //           "gender": genderSelectionControllar.selectedGender.value,
  //           "department": _value,
  //           "type": "Doctor",

// Container(
//                     padding: const EdgeInsets.only(right: 45),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           height: 20,
//                           width: 20,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: const Color.fromARGB(255, 2, 0, 0))),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           "انثي",
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           width: 50,
//                         ),
//                         Container(
//                           height: 20,
//                           width: 20,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: isGender ? Colors.green : Colors.white,
//                               border: Border.all(
//                                   color: const Color.fromARGB(255, 2, 0, 0))),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           "ذكر",
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),