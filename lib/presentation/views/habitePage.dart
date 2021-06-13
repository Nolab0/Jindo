import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/business_logic/habitSelectionLogic.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/partialViews/habitCard.dart';
import 'package:greennindo/presentation/utilities/color.dart';
import 'package:greennindo/presentation/utilities/gradientButton.dart';
import 'package:greennindo/presentation/views/loading.dart';
import 'package:provider/provider.dart';

class HabitSelection extends StatefulWidget {
  final List<Habit> currentHabits;
  HabitSelection({this.currentHabits});
  @override
  _HabitSelectionState createState() => _HabitSelectionState();
}

class _HabitSelectionState extends State<HabitSelection> {
  List<Habit> habits;
  List<Habit> selectedHabits = [];
  int nbSelectedHabits = 0; //number of selected habit
  int maxSelectedHabits = 0; //number of possible selecatble habits
  bool init = false; //true if the list of habit has been initialized

  //Load the habits
  Future<List<Habit>> loadData() async {
    return await loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustUser>(context);
    maxSelectedHabits = 3 - widget.currentHabits.length;
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!init) {
            //init the habit list
            habits = snapshot.data;
            init = true;
          }
          recommendedHabits(habits);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey[100],
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),
                        Text("Habit selection",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          child: Text("You can select up to 3 habits",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6))),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Recommended:",
                                style: TextStyle(fontSize: 18))),
                        SizedBox(
                          height: 410,
                          //Display the recommended habits
                          child: ListView.builder(
                              itemCount: habits.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (habits[index].recommended) {
                                  return GestureDetector(
                                    child: HabitCardAdd(
                                      habit: habits[index],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        nbSelectedHabits = selectHabit(
                                            habits, index, nbSelectedHabits);
                                        selectedHabits.add(habits[index]);
                                      });
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Others : ",
                                style: TextStyle(fontSize: 18))),
                        SizedBox(
                          width: 500,
                          height: 150,
                          //Display the not recommended habits
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: habits.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (!habits[index].recommended) {
                                  return GestureDetector(
                                    child: HabitCardAdd(
                                      habit: habits[index],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        nbSelectedHabits = selectHabit(
                                            habits, index, nbSelectedHabits);
                                        selectedHabits.add(habits[index]);
                                      });
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        child: GradientButton(
                          text: Text(
                            "Add " +
                                nbSelectedHabits.toString() +
                                " new habits",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          border: false,
                          gradient: nbSelectedHabits == 0
                              ? lightgradient()
                              : gradient(),
                          width: 200,
                          height: 50,
                        ),
                        onTap: () {
                          if (nbSelectedHabits > 0) {
                            addSelectedHabits(context, widget.currentHabits,
                                selectedHabits, user);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
