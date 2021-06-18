class Habit {
  //attribute
  String name;
  int currentTimes;
  int objectiveTimes;
  int gainedPoints; //the amount of points of the habit
  int loosePoints; //amount of loose points if the habit is failed
  int delay; //the delay in days to take the habit
  int difficulty; //difficulty in a scale of 10 of the habit
  bool doneToday;
  bool finished;
  bool selected;
  bool recommended;
  DateTime limit; //objective should be realize before this date

  //constructor
  Habit(
      this.name,
      this.currentTimes,
      this.objectiveTimes,
      this.gainedPoints,
      this.difficulty,
      this.loosePoints,
      this.doneToday,
      this.finished,
      this.selected,
      this.delay,
      this.recommended,
      this.limit);

  //Methods
  Habit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        currentTimes = 0,
        objectiveTimes = json['objectiveTimes'],
        gainedPoints = json['gainedPoints'],
        difficulty = json['difficulty'],
        loosePoints = json['loosePoints'],
        doneToday = false,
        selected = false,
        finished = false,
        delay = json['delay'],
        recommended = false,
        limit = DateTime.now().add(Duration(days: json['delay'] + 1));

  Habit.fromFirestore(Map<String, dynamic> json)
      : name = json['name'],
        currentTimes = json['currentTimes'],
        objectiveTimes = json['objectiveTimes'],
        gainedPoints = json['gainedPoints'],
        loosePoints = json['loosePoints'],
        difficulty = json['difficulty'],
        doneToday = json['doneToday'],
        selected = json['selected'],
        finished = json['finished'],
        delay = json['delay'],
        recommended = json['recommended'],
        limit = json['limit'].toDate();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'currentTimes': currentTimes,
      'objectiveTimes': objectiveTimes,
      'gainedPoints': gainedPoints,
      'loosePoints': loosePoints,
      'difficulty': difficulty,
      'doneToday': doneToday,
      'selected': selected,
      'finished': finished,
      'delay': delay,
      'recommended': recommended,
      'limit': limit
    };
  }

  //Select or deselect an habit
  void select() {
    selected = !selected;
  }
}
