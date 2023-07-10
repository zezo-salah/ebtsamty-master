import 'package:ebtsamty/Pages/Profile_Patient.dart';
import 'package:ebtsamty/shared/custom_textfiled.dart';
import 'package:flutter/material.dart';

class HealthstatementPage extends StatefulWidget {
  const HealthstatementPage({super.key});

  @override
  State<HealthstatementPage> createState() => _HealthstatementPageState();
}

class _HealthstatementPageState extends State<HealthstatementPage> {
  List dropDown = [
    {"title": "أمراض القلب والأوعية الدموية", "value": "1"},
    {"title": "أمراض الجهاز التنفسي", "value": "2"},
    {"title": "السرطان", "value": "3"},
    {"title": "الصرع والنوبات", "value": "4"},
    {"title": "مشاكل صحة الفم", "value": "5"},
    {"title": "الجلوكوما", "value": "6"},
    {"title": "التصلب اللويجي", "value": "7"},
    {"title": "مرض باراكنسون", "value": "8"},
    {"title": "سيولة الدم", "value": "9"},
    {"title": "أمراض الجهاز الهضمي", "value": "10"},
  ];
  String _value = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.transparent, Colors.transparent],
          ).createShader(rect),
          blendMode: BlendMode.exclusion,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/copy-space-heart-shape-stethoscope_1920x1280.jpeg"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.transparent, BlendMode.exclusion)),
            ),
          ),
        ),
        Scaffold(
          // backgroundColor: Color.fromARGB(206, 243, 253, 255),
          // backgroundColor: Color.fromARGB(162, 211, 231, 241),
          backgroundColor: Color.fromARGB(146, 255, 255, 255),
          body: Stack(
            children: [
              Container(
                // color: Colors.amber,
                height: 60,
                padding: const EdgeInsets.only(left: 320),
                child: Image.asset(
                  "assets/icons/Logo2.png",
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // _globalKey.currentState?.openDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePatient()),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 35,
                      ),
                      child: Stack(
                        children: [
                          CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(232, 243, 248, 255),
                              radius: 65,
                              backgroundImage:
                                  AssetImage("assets/avatar/avatar1.png")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "احمد حسين",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 25, 58, 114)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "سنة ",
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 25, 58, 114)),
                      ),
                      Text(
                        "30 ",
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 25, 58, 114)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        Row(
                          children: [
                        Icon(Icons.library_add,color: Colors.blue,),
                        SizedBox(width: 100,),
                            Container(
                              child: Text(
                                "الأمراض المزمنة",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                    child: ListView(
                      children: [
                        InputDecorator(
                          // textAlign: TextAlign.center,
                          decoration: decorationTextfield .copyWith(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                dropdownColor:
                                    Color.fromARGB(255, 132, 184, 227),
                                isDense: true,
                                value: _value,
                                isExpanded: true,
                                // menuMaxHeight: 350,
                                items: [
                                  DropdownMenuItem(
                                    alignment: AlignmentDirectional.centerEnd,
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
                                  ...dropDown
                                      .map<DropdownMenuItem<String>>((date) {
                                    return DropdownMenuItem(
                                       alignment: Alignment.topRight,
                                      child: Text(
                                        date["title"],
                                      ),
                                      value: date["value"],
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
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
