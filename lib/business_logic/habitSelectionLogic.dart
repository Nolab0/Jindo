import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/models/user_data.dart';

//Load the list of habits from a Json file
Future<List<Habit>> loadHabits() async {
  String json = await rootBundle.loadString("assets/data/habits.json");
  List<dynamic> jsonDecoded = jsonDecode(json);
  return jsonDecoded.map((jsonDecoded) => Habit.fromJson(jsonDecoded)).toList();
}

//Recommend some habits: TODO: add the system for real recommendation
void recommendedHabits(List<Habit> habits) {
  int count = 0;
  for (int i = 0; i < habits.length; i++) {
    if (count < 3) {
      habits[i].recommended = true;
      count++;
    }
  }
}

//Return the number of selected habit
int countSelected(List<Habit> habits) {
  int count = 0;
  for (int i = 0; i < habits.length; i++) {
    if (habits[i].selected) count++;
  }
  return count;
}

//Select the habit at the correct index
int selectHabit(List<Habit> habits, int index, int nbSelected) {
  if (nbSelected == 3 && !habits[index].selected) {
    //if there is more than 3habits selected, deselect the first
    bool find = false;
    for (int i = 0; i < habits.length && !find; i++) {
      if (habits[i].selected) {
        find = true;
        if (index != i) habits[i].select();
      }
    }
  }
  habits[index].select();
  return countSelected(habits);
}

//Add the selected habits to the database and quit the screen
//Add the habits by merging the current to one to the new ones
void addSelectedHabits(BuildContext context, List<Habit> currentHabits,
    List<Habit> selectedHabits, CustUser user) {
  for (int i = 0; i < selectedHabits.length; i++) {
    currentHabits.add(selectedHabits[i]);
  }
  DatabaseService(uid: user.uid).updateUserHabits(currentHabits);
  Navigator.pop(context);
}
