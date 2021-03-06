import 'package:flutter/material.dart';

//Widget for option for MCQ question
class Option extends StatelessWidget {
  final String option;
  final bool selected;
  Option({this.option, this.selected});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    selected ? Colors.green[600] : Colors.grey.withOpacity(0.8),
                width: selected ? 3 : 1),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              size: 30,
              color:
                  selected ? Colors.green[600] : Colors.grey.withOpacity(0.8),
            ),
          ],
        ));
  }
}
