import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/models/user_data.dart';

void initHabits(List<Habit> habits, UserData data) {
  for (int i = 0; i < habits.length; i++) {
    Habit habit = habits[i];
    if (habit.doneToday) {
      if (DateTime.now().difference(habit.lastTimeDone).inDays >= 1) {
        habit.doneToday = false;
      } else {
        habit.doneToday = true;
      }
    }
  }
  DatabaseService(uid: data.uid).updateUserHabits(habits);
}

//Complete the habit from the list of user habits
void completeHabit(List<Habit> habits, Habit finished, UserData data) {
  print("DEBUG: completed " + finished.name);
  DatabaseService db = DatabaseService(uid: data.uid);
  db.updateScore(data.score + finished.gainedPoints);
  habits.remove(finished);
  db.updateUserHabits(habits);
  List<Habit> completed = data.completedHabits;
  completed.add(finished);
  db.updateUserCompletedHabits(completed);
}

//Fail the habit from the list of user habits
void failHabit(List<Habit> habits, Habit failed, UserData data) {
  DatabaseService db = DatabaseService(uid: data.uid);
  db.updateScore(data.score - failed.loosePoints);
  habits.remove(failed);
  db.updateUserHabits(habits);
}

//Complete an habit for one day
Habit completeHabitDay(List<Habit> habits, Habit habit, UserData data) {
  print("DEBUG: done for one day " + habit.name);
  int index = habits.indexOf(habit); //update directly the habit in the list
  habits[index].doneToday = true;
  habits[index].currentTimes++;
  habits[index].lastTimeDone = DateTime.now(); //set to now
  if (habits[index].currentTimes == habits[index].objectiveTimes) {
    habits[index].finished = true;
  }
  DatabaseService(uid: data.uid)
      .updateUserHabits(habits); //update in the database
  return habits[index];
}

//Return a motivation text according to the user's score
String personalizedTextMotiv(int score) {
  if (score > 60)
    return "Congratulation ! You have a really good score. It means that your are aware of the current ecological situation.";
  else if (score < 20)
    return "Not bad but you can do better. You can improve your score and become more respectfull of the environment by completing some habits";
  else
    return "Good score ! You are aware of the ecological situation. Let's complete some habits to imrpove your score !";
}
