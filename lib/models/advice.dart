class Advice {
  //attribute
  String name;
  int currentTimes;
  int objectiveTimes;
  int points; //the amount of points of the advice
  bool doneToday;
  bool finished;
  DateTime limit; //objective should be realize before this date

  //constructor
  Advice(this.name, this.currentTimes, this.objectiveTimes, this.points,
      this.doneToday, this.finished, this.limit);
}
