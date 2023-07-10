import 'package:get/get.dart';

class GenderSelectionControllar extends GetxController {
  var selectedGender = "".obs;
  onChangedGender(var gender) {
    selectedGender.value = gender;
  }
}
