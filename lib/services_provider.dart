import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesProvider extends ChangeNotifier {
  reloadUi() {
    notifyListeners();
  }

  int serviceType = 0;
  String? selectedRegion;
  String? selectedCountry;
  String? selectedDegree;

  RangeValues rangeValues = const RangeValues(200000, 3000000);

  DateTime? selectedDate;
  String? selectedTime;

  TextEditingController appointerNameController = TextEditingController();
  TextEditingController appointerPhoneController = TextEditingController();
  TextEditingController appointerEmailController = TextEditingController();
  TextEditingController appointerNoteController = TextEditingController();

  TextEditingController promoCodeController = TextEditingController();

  List<String> availableWeekdays = [
    'Monday',
    'Wednesday',
    'Friday',
    'Sunday',
  ];

  bool checkWeekDayExists(DateTime date) {
    return availableWeekdays.contains(DateFormat('EEEE').format(date));
  }
}
