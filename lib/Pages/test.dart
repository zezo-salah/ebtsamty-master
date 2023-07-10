// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _imageFile;
  String? _uploadedImageUrl;
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Patient');
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<void> _uploadImage() async {
    try {
      final credential = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Patient');
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('images/${_imageFile!.path.split('/').last}');
      final UploadTask uploadTask = ref.putFile(_imageFile!);
      final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
      final String url = await downloadUrl.ref.getDownloadURL();
      setState(() {
        _uploadedImageUrl = url;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
          FirebaseFirestore.instance.collection('Patient');
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: _imageFile == null
                  ? Text('')
                  : Image.file(_imageFile!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Camera'),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                ElevatedButton(
                  child: Text('Gallery'),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
            ElevatedButton(
              child: Text('Upload Image'),
              onPressed: _imageFile == null ? null : _uploadImage,
            ),
            _uploadedImageUrl != null
                ? Image.network(
                    _uploadedImageUrl!,
                    height: 200,
                    width: 200,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class AppointmentScheduler extends StatefulWidget {
//   @override
//   _AppointmentSchedulerState createState() => _AppointmentSchedulerState();
// }

// class _AppointmentSchedulerState extends State<AppointmentScheduler> {
//   late DatabaseReference _bookedTimesRef;
//   List<String> bookedTimes = [];

//   @override
//   void initState() {
//     super.initState();
//     _bookedTimesRef =
//         FirebaseDatabase.instance.ref().child('bookedTimes');

//     // استماع إلى التغييرات في القائمة المحجوزة
//     _bookedTimesRef.onValue.listen((event) {
//       Object? bookedTimesList = event.snapshot.value;

//       if (bookedTimesList != null) {
//         setState(() {
//           bookedTimes = (bookedTimesList as List<dynamic>).cast<String>();
//         });
//       }
//     });
//   }

//   void bookAppointment(int index) {
//     final time = '${index + 5}:00 ${index + 5 > 11 ? "AM" : "PM"}';
//     if (bookedTimes.contains(time)) {
//       // التحقق مما إذا كان الوقت المحدد محجوزًا بالفعل
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('حجز مكرر'),
//             content:
//                 Text('عذرًا، هذا الوقت محجوز بالفعل. الرجاء اختيار وقت آخر.'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('حسنًا'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       setState(() {
//         bookedTimes.add(time); // إضافة الوقت المحجوز إلى القائمة
//       });
//       // تحديث البيانات في Firebase Realtime Database
//       _bookedTimesRef.set(bookedTimes);
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('حجز جديد'),
//             content: Text('تم حجز الموعد بنجاح في الوقت التالي: $time.'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('حسنًا'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مواعيد الحجز'),
//       ),
//       body: GridView.builder(
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemCount: 6,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () => bookAppointment(index),
//             child: Container(
//               margin: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: bookedTimes.contains(
//                         '${index + 5}:00 ${index + 5 > 11 ? "AM" : "PM"}')
//                     ? Colors.grey
//                     : Colors.blue,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Text(
//                   '${index + 5}:00 ${index + 5 > 11 ? "AM" : "PM"}',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
