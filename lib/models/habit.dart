class Habit {
  //attribute
  String name;
  int currentTimes;
  int objectiveTimes;
  int gainedPoints; //the amount of points of the habit
  int loosePoints; //amount of loose points if the habit is failed
  bool doneToday;
  bool finished;
  DateTime limit; //objective should be realize before this date

  //constructor
  Habit(this.name, this.currentTimes, this.objectiveTimes, this.gainedPoints,
      this.loosePoints, this.doneToday, this.finished, this.limit);
}
