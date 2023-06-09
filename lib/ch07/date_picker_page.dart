import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({Key? key}) : super(key: key);

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日期选择'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAndroidDatePick();
              },
              child: const Text('安卓风格日期选择'),
            ),
            ElevatedButton(
              onPressed: () {
                _showIosDatePick();
              },
              child: const Text('苹果风格日期选择'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAndroidDatePick() async {
    var date = DateTime.now();
    var result = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(
        const Duration(days: 30),
      ),
    );
    debugPrint("===> result = $result");
  }

  void _showIosDatePick() async {
    var date = DateTime.now();
    var result = date;
    await showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return Container(
          height: 200,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              const Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              debugPrint("===> onDateTimeChanged. value = $value");
              result = value;
            },
          ),
        );
      },
    );
    debugPrint("===> result = $result");
  }
}
