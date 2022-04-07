import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_datetime_select/design_button.dart';
import 'package:conditional_datetime_select/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const Color kDefaultColor = Color(0xff006784);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conditional Date Time Select'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const DateAndTimePickerDialog());
          },
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

class DateAndTimePickerDialog extends StatelessWidget {
  const DateAndTimePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _pd = Provider.of<ServicesProvider>(context);
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5.0),
            const Text(
              'Please pick a Date',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: kDefaultColor,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              width: 300,
              child: CalendarDatePicker(
                initialDate: _pd.selectedDate ?? DateTime.now(),
                firstDate: DateTime(2015),
                lastDate: DateTime(2101),
                onDateChanged: (dt) async {
                  if (dt.isBefore(DateTime.now())) {
                    _pd.selectedDate = DateTime.now();
                    _pd.reloadUi();
                    await Fluttertoast.showToast(
                      msg: "Please select a future date",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[700],
                      textColor: Colors.white,
                      fontSize: 13.0,
                    );
                    _pd.selectedDate = DateTime.now();
                    _pd.reloadUi();
                    return;
                  } else if (_pd.checkWeekDayExists(dt)) {
                    _pd.selectedDate = dt;
                    _pd.reloadUi();
                    return;
                  } else {
                    _pd.selectedDate = DateTime.now();
                    _pd.reloadUi();
                    await Fluttertoast.showToast(
                      msg: "Consultation is not available on this day",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[700],
                      textColor: Colors.white,
                      fontSize: 13.0,
                    );
                    _pd.selectedDate = DateTime.now();
                    _pd.reloadUi();
                    return;
                  }
                },
              ),
            ),
            if (_pd.selectedDate != null)
              Text(
                '${DateFormat('EEEE').format(_pd.selectedDate!)}, ${DateFormat.yMMMMd().format(_pd.selectedDate!)}',
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: kDefaultColor,
                ),
              ),
            if (_pd.selectedDate != null) const SizedBox(height: 10.0),
            Container(
              height: 200.0,
              width: size.width * 0.95,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kDefaultColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Center(
                      child: Text(
                        'Setup Time Slot',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    height: 165.0,
                    width: size.width * 0.95,
                    child: ListView(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        15,
                        (index) => KCardTile(
                            title: '1:30 - 2:00 pm',
                            onTap: () {
                              _pd.selectedTime = '1:30 - 2:00 pm';
                              _pd.reloadUi();
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            DesignButton(
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              width: 80.0,
              height: 28.0,
              borderAngel: 8.0,
              borderColor: kDefaultColor,
              color: kDefaultColor,
              onPressed: () {
                // Navigator.pop(context);
                // showModal(
                //   context: context,
                //   builder: (context) => const AppointmentDetailsFormClient(),
                // );
              },
            ),
            const SizedBox(height: 10.0),
            const Text(
              'OR',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'Call Now: ',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  IconButton(
                    onPressed: () {},
                    icon: CachedNetworkImage(
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/552/552489.png',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(color: kDefaultColor),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error_outline),
                      width: 22.0,
                      height: 22.0,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  IconButton(
                    onPressed: () {},
                    icon: CachedNetworkImage(
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/220/220236.png',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(color: kDefaultColor),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error_outline),
                      width: 28.0,
                      height: 28.0,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}

class KCardTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const KCardTile({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
