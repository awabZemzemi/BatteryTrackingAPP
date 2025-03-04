import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PeriodPicker extends StatefulWidget {
  @override
  createState() => _SegmentedControlDemoState();
}

class _SegmentedControlDemoState extends State<PeriodPicker> {
  int _selectedSegment = 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<int>(
      children: const {
        0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Day'),
        ),
        1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Month'),
        ),
        2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Year'),
        ),
        3: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('All'),
        ),
      },
      groupValue: _selectedSegment,
      onValueChanged: (int newValue) {
        setState(() {
          _selectedSegment = newValue;
        });
      },
      unselectedColor: Colors.lightGreen,
      selectedColor: Colors.yellow,
      borderColor: const Color.fromARGB(255, 222, 222, 222),
    );
  }
}
