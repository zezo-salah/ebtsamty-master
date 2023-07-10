// ignore_for_file: must_be_immutable

import 'package:ebtsamty/shared/Gender_Selection_Controllar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderSelection extends StatelessWidget {
  GenderSelection({super.key, required TextEditingController controller});
  GenderSelectionControllar genderSelectionControllar =
      Get.put(GenderSelectionControllar());
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      padding: const EdgeInsets.only(right: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() => Radio(
              value: "أنثي",
              groupValue: genderSelectionControllar.selectedGender.value,
              onChanged: (value) {
                genderSelectionControllar.onChangedGender(value);
              },
              activeColor: Colors.blue,
              fillColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 3, 87, 155)))),
          Text(
            "أنثي",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Obx(() => Radio(
                value: "ذكر",
                groupValue: genderSelectionControllar.selectedGender.value,
                onChanged: (value) {
                  genderSelectionControllar.onChangedGender(value);
                },
                activeColor: Colors.blue,
                fillColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 3, 87, 155)),
              )),
          Text(
            "ذكر",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
