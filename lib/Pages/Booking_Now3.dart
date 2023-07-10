// ignore_for_file: unused_element, unused_field, deprecated_member_use, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtsamty/Pages/Reservation.dart';
import 'package:ebtsamty/Pages/success_booked.dart';
import 'package:ebtsamty/shared/custom_textfiled2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage3 extends StatefulWidget {
  const BookingPage3({super.key});

  @override
  State<BookingPage3> createState() => _BookingPage3State();
}

class _BookingPage3State extends State<BookingPage3> {
  List<String> timedate = [];
  bool checkname = true;
  bool check = true;
  String url = "";
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final databaseRef = FirebaseDatabase.instance.reference();
  // final databaseRef = FirebaseDatabase.instance.reference().child("hagz");
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
  List dropDownn = [
    {"title": "أستشارة"},
    {"title": "حشو أسنان"},
    {"title": "علاج الكسور و التآكل"},
    {"title": "استخراج أسنان (خلع)"},
    {"title": "دواعم أسنان"},
    {"title": "زراعة أسنان"},
    {"title": "جراحة الفم"},
    {"title": "تقويم أسنان"},
    {"title": "تبييض أسنان"},
  ];
  String __value = "";
  String _value = "";
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String time = "";
  @override
  Widget build(BuildContext context) {
    if (checkname) {
      checkname = false;
      getiname();
    }
    print(_focusDay);
    if (check) {
      check = false;
      getAllAppointment();
    }
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ReservationPage()),
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Text(
                      "اختر التاريخ المناسب لك",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      textAlign: TextAlign.end,
                    ),
                    _tableCalendar(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "الخدمات المتاحة",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputDecorator(
                      // textAlign: TextAlign.center,
                      decoration: decorationTextfield2.copyWith(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: Color.fromARGB(255, 132, 184, 227),
                            isDense: true,
                            value: __value,
                            isExpanded: true,
                            // menuMaxHeight: 350,
                            items: [
                              DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "الخدمات",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  // textAlign: TextAlign.center,
                                  selectionColor: Colors.black,
                                ),
                                value: "",
                              ),
                              ...dropDownn
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
                                __value = value!;
                                print(dropDownn);
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "هل تعاني من أي أمراض مزمنة؟",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputDecorator(
                      // textAlign: TextAlign.center,
                      decoration: decorationTextfield2.copyWith(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: Color.fromARGB(255, 132, 184, 227),
                            isDense: true,
                            value: _value,
                            isExpanded: true,
                            // menuMaxHeight: 350,
                            items: [
                              DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "الأمراض المزمنة",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  // textAlign: TextAlign.center,
                                  selectionColor: Colors.black,
                                ),
                                value: "",
                              ),
                              ...dropDown.map<DropdownMenuItem<String>>((date) {
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
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: Center(
                        child: Text(
                          "حدد وقت الاستشارة",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _isWeekend
                  ? SliverToBoxAdapter(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        alignment: Alignment.center,
                        child: Text(
                          "Weekend is not available, please select another date",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              // when selected, update current index and set time selected to true
                              setState(() {
                                _currentIndex = index;
                                _timeSelected = true;
                              });
                            },
                            child: timedate.contains(_focusDay
                                        .toString()
                                        .split(' ')[0] +
                                    "-${index + 12}:00 ${index + 12 > 11 ? "AM" : "PM"}")
                                ? Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      "محجوز",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = index;
                                        time =
                                            "${index + 12}:00 ${index + 12 > 11 ? "AM" : "PM"}";
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _currentIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: timedate.contains(_focusDay
                                                    .toString()
                                                    .split(' ')[0] +
                                                "-${index + 12}:00 ${index + 12 > 11 ? "AM" : "PM"}")
                                            ? Colors.red
                                            : _currentIndex == index
                                                ? Colors.greenAccent
                                                : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${index + 12}:00 ${index + 12 > 11 ? "AM" : "PM"}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _currentIndex == index
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        },
                        childCount: 6,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, childAspectRatio: 1.5)),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 22),
                  child: ElevatedButton(
                    onPressed: time == ''|| __value ==''
                        ? null
                        : () {
                            FirebaseDatabase.instance.ref().child('Patient');
                            databaseRef
                                .child("K9x5vdSJSUXdOwRRQSif7G9JVKC2")
                                .push()
                                .set({
                              'health_status': _value.toString(),
                              "time": time.toString(),
                              'date_hagz': _focusDay.toString(),
                              'doctor': url.toString(),
                              "service": __value.toString(),
                            });
                            FirebaseDatabase.instance.ref().child('Patient');
                            databaseRef
                                .child(FirebaseAuth.instance.currentUser!.uid)
                                .push()
                                .set({
                              'health_status': _value.toString(),
                              "time": time.toString(),
                              'date_hagz': _focusDay.toString(),
                              'doctor': url.toString(),
                              "service": __value.toString(),
                            });
                            setState(() {
                              _tableCalendar();
                              final credential =
                                  FirebaseAuth.instance.currentUser;
                              CollectionReference users =
                                  FirebaseFirestore.instance.collection('hagz');
                              users
                                  .doc(credential!.uid)
                                  .update({
                                    'date_hagz': _focusDay,
                                    "health_status": _value,
                                    "time": time,
                                    "patient": credential.uid,
                                    "service": __value,
                                  })
                                  .then((value) => print('Date added'))
                                  .catchError((error) =>
                                      print('Failed to add date: $error'));
                            });
                            setState(() {
                              final credential =
                                  FirebaseAuth.instance.currentUser;
                              CollectionReference users = FirebaseFirestore
                                  .instance
                                  .collection('invoices');
                              users
                                  .doc(credential!.uid)
                                  .set({
                                    'created_at': _focusDay,
                                    "service": __value,
                                    "service _price": "4000",
                                    "totale": "4000",
                                  })
                                  .then((value) => print('Date added'))
                                  .catchError((error) =>
                                      print('Failed to add date: $error'));
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentBooked(),
                              ),
                            );
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 23, 2, 98)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "احجز ميعادك",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      // lastDay: DateTime(2023, 12, 31),
      lastDay: DateTime.now().add(Duration(days: 365)),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 35,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: "Month",
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          print('تم اختيار التاريخ $_currentDay');
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          // check if weekend is selected
          if (selectedDay.weekday == 5
              // || selectedDay.weekday == 6
              // selectedDay.weekday == 7
              ) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      },
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

  getAllAppointment() {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref("K9x5vdSJSUXdOwRRQSif7G9JVKC2");
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot;
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      timedate.clear();
      values?.forEach((key, value) {
        setState(() {
          timedate.add(
              "${value["date_hagz"].toString().split(' ')[0].replaceAll('}', '')}-${value['time']}");
        });
        // print(
        //     "=====${value["date_hagz"].toString().split(' ')[0].replaceAll('}', '')}");
      });
    });
  }
}
