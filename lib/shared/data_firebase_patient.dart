// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Home_Page.dart';
import 'package:ebtsamty/shared/custom_textfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' show basename, url;
import 'package:image_picker/image_picker.dart';

class GetDataFirebasePatient extends StatefulWidget {
  final String documentId;

  GetDataFirebasePatient({required this.documentId});

  @override
  State<GetDataFirebasePatient> createState() => _GetDataFirebasePatientState();
}

class _GetDataFirebasePatientState extends State<GetDataFirebasePatient> {
  File? _imageFile;
  String? _uploadedImageUrl;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      // _imageFile = File(pickedFile.path);
      _imageFile = File(pickedFile!.path);
      _uploadedImageUrl = basename(pickedFile.path);
      int random = Random().nextInt(9999999);
      _uploadedImageUrl = "$random$_uploadedImageUrl";
    });
  }

  Future<void> _uploadImage() async {
    try {
      final credential = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Patient');
      final storageRef =
          FirebaseStorage.instance.ref("alrawshta/$_uploadedImageUrl");
      await storageRef.putFile(_imageFile!);
      String url = await storageRef.getDownloadURL();
      users.doc(credential!.uid).update({
        "alrowshta": url,
      });
      // final UploadTask uploadTask = storageRef.putFile(_imageFile!);
      // final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
      // final String url = await downloadUrl.storageRef.getDownloadURL();
      setState(() {
        _uploadedImageUrl = url;
      });
    } catch (error) {
      print(error);
    }
  }

  File? imgPath;
  String? imgName;
  // File? imgPath;
  uploadImage(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  Showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final Edit_FirstNameController = TextEditingController();
  final Edit_LastNameController = TextEditingController();
  final Edit_PhoneController = TextEditingController();
  final Edit_DateController = TextEditingController();
  final Edit_EmailController = TextEditingController();
  final Edit_PasswordController = TextEditingController();
  final Edit_confirmpasswordController = TextEditingController();
  final Edit_GenderController = TextEditingController();
  final ageController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Patient');
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Patient');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Stack(
                        children: [
                          CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(232, 243, 248, 255),
                              radius: 65,
                              backgroundImage:
                                  AssetImage("assets/avatar/avatar1.png")),
                          imgPath == null
                              ? CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(232, 243, 248, 255),
                                  radius: 65,
                                  backgroundImage:
                                      // AssetImage("assets/avatar/avatar1.png")
                                      NetworkImage("${data["photo"]}"),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    imgPath!,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Positioned(
                              left: 95,
                              bottom: -10,
                              child: IconButton(
                                  onPressed: () async {
                                    // uploadImage();
                                    await Showmodel();
                                    final storageRef = FirebaseStorage.instance
                                        .ref("Patient-images/$imgName");
                                    await storageRef.putFile(imgPath!);
                                    String url =
                                        await storageRef.getDownloadURL();
                                    users.doc(credential!.uid).update({
                                      "photo": url,
                                    });
                                  },
                                  icon: const Icon(Icons.add_a_photo))),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.only(right: 42),
                      width: double.infinity,
                      child: Text(
                        "الاسم الاول",
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
                      padding: EdgeInsets.only(left: 18, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(109, 174, 177, 181)),
                      width: 320,
                      height: 46,
                      child: TextField(
                        readOnly: true,
                        // textAlign :TextAlign.start,
                        controller: Edit_FirstNameController,
                        // textAlignVertical:TextAlignVertical.center,
                        keyboardType: TextInputType.name,
                        decoration: decorationTextfield.copyWith(
                          hintText: "${data['first_name']}",
                          // hintText: Edit_GenderController.text,
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
                      height: 0,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 42),
                      width: double.infinity,
                      child: Text(
                        "اسم العائلة",
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
                      padding: EdgeInsets.only(left: 18, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(109, 174, 177, 181)),
                      width: 320,
                      height: 46,
                      child: TextField(
                        readOnly: true,
                        controller: Edit_LastNameController,
                        keyboardType: TextInputType.text,
                        decoration: decorationTextfield.copyWith(
                          hintText: "${data['last_name']}",
                          // hintText: "LastName:${data['lastName']}",
                          suffixIcon: Icon(
                            Icons.family_restroom_sharp,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 19),
                        ),
                      ),
                    )),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 42),
                      width: double.infinity,
                      child: Text(
                        "الكود",
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
                      padding: EdgeInsets.only(left: 18, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color.fromARGB(109, 174, 177, 181),
                      ),
                      width: 320,
                      height: 46,
                      child: TextField(
                        readOnly: true,
                        // controller: Edit_LastNameController,
                        keyboardType: TextInputType.text,
                        decoration: decorationTextfield.copyWith(
                          hintText: "${data['code']}",
                          suffixIcon: Icon(
                            Icons.code_sharp,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 19),
                        ),
                      ),
                    )),
                    Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.only(right: 42),
                      width: double.infinity,
                      child: Text(
                        "رقم الموبيل",
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
                      padding: EdgeInsets.only(left: 18, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white30),
                      width: 320,
                      height: 46,
                      child: TextField(
                        controller: Edit_PhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: decorationTextfield.copyWith(
                          hintText: "${data['phone_number']}",
                          suffixIcon: Icon(
                            Icons.phone_in_talk,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 19),
                        ),
                      ),
                    )),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 42),
                      width: double.infinity,
                      child: Text(
                        "السن",
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
                      padding: EdgeInsets.only(left: 18, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(109, 174, 177, 181)),
                      width: 320,
                      height: 46,
                      child: TextField(
                        readOnly: true,
                        obscureText: false,
                        controller: Edit_DateController,
                        keyboardType: TextInputType.datetime,
                        decoration: decorationTextfield.copyWith(
                          hintText: "${data['age']}",
                          suffixIcon: Icon(
                            Icons.apps_outage,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 19),
                        ),
                      ),
                    )),
                    Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.only(right: 42),
                      width: double.infinity,
                      child: Text(
                        "البريد الالكتروني",
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
                      padding: EdgeInsets.only(left: 18, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(109, 174, 177, 181)),
                      width: 320,
                      height: 46,
                      child: TextField(
                        readOnly: true,
                        controller: Edit_EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: decorationTextfield.copyWith(
                          hintText: "${data['email']}",
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 19),
                        ),
                      ),
                    )),
                    SizedBox(
                      height: 0,
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(right: 42),
                    //   width: double.infinity,
                    //   child: Text(
                    //     "كلمة السر",
                    //     style: TextStyle(
                    //       fontSize: 25,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //     textAlign: TextAlign.right,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 0,
                    // ),
                    // Center(
                    //     child: Container(
                    //   padding: EdgeInsets.only(left: 18, right: 10),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(40),
                    //       color: Color.fromARGB(109, 174, 177, 181)),
                    //   width: 320,
                    //   height: 46,
                    //   child: TextField(
                    //     readOnly: true,
                    //     // obscureText:,
                    //     controller: Edit_PasswordController,
                    //     keyboardType: TextInputType.text,
                    //     decoration: decorationTextfield.copyWith(
                    //       hintText: "${data['password']}",
                    //       suffixIcon: Icon(
                    //         Icons.visibility,
                    //         color: Colors.blue,
                    //       ),
                    //       border: InputBorder.none,
                    //       hintStyle: TextStyle(fontSize: 19),
                    //     ),
                    //   ),
                    // )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 42),
                      width: double.infinity,
                      child: Text(
                        "يمكنك تحميل الروشتة من هنا",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white38),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(55))),
                          ),
                          child: Text(
                            "Choose File",
                            style: TextStyle(fontSize: 19, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          child: Text('Upload Image'),
                          onPressed: _imageFile == null ? null : _uploadImage,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        users.doc(credential!.uid);
                        // users.doc(credential!.uid).update(
                        //     {"firstName": Edit_FirstNameController.text});
                        // users
                        //     .doc(credential!.uid)
                        //     .update({"lastName": Edit_LastNameController.text});
                        users.doc(credential!.uid).update(
                            {"phone_number": Edit_PhoneController.text});
                        // users
                        //     .doc(credential!.uid)
                        //     .update({"date": Edit_DateController.text});
                        // users
                        //     .doc(credential!.uid)
                        //     .update({"age": Edit_DateController.text});

                        users.doc(credential!.uid).update({
                          "photo": url,
                        });

                        // // img
                        // final storageRef =
                        //     FirebaseStorage.instance.ref(imgName);
                        // await storageRef.putFile(imgPath!);
                        // String url = await storageRef.getDownloadURL();
                        // users
                        //     .doc(credential!.uid)
                        //     .update({"email": Edit_EmailController.text});
                        // users
                        //     .doc(credential!.uid)
                        //     .update({"password": Edit_PasswordController.text});
                        setState(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 90, 154, 249)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 140, vertical: 7)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(66))),
                      ),
                      child: Text(
                        "تعديل",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          );
        }
        return Center(child: Text("loading"));
      },
    );
  }
}



// DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");//now
// DateTime dt2 = DateTime.parse("2018-09-12 10:57:00");//anydate
// Duration diff = dt1.difference(dt2);
// print(diff.inDays); //output (in days): 1198
// print(diff.inHours); //output (in hours): 28752
// print(diff.inMinutes); //output (in minutes): 1725170
// print(diff.inSeconds); //output (in seconds): 103510200