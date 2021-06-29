import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/views/loading.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatelessWidget {
  final UserData user;
  LeaderBoard({@required this.user});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustUser>(context);
    return StreamBuilder<List<UserData>>(
      stream: DatabaseService(uid: user.uid).allUserData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UserData> allData = snapshot.data;
          allData.sort((a, b) => b.score.compareTo(a.score));
          return SafeArea(
              child: Scaffold(
            backgroundColor: Colors.grey[100],
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Leader Board", style: TextStyle(fontSize: 25)),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: allData.length,
                              itemBuilder: (BuildContext context, int index) {
                                UserData current = allData[index];
                                bool isYou = false;
                                if (current.uid == user.uid) {
                                  isYou = true;
                                }
                                return IndividualRow(
                                  index: index,
                                  data: current,
                                  isYou: isYou,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        } else {
          return Loading();
        }
      },
    );
  }
}

class IndividualRow extends StatelessWidget {
  final int index;
  final UserData data;
  final bool isYou; //true if this is the user of the app
  IndividualRow({this.index, this.data, this.isYou});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            index.toString(),
            style: TextStyle(fontSize: 18),
          ),
          isYou
              ? Text(data.name + " (you)", style: TextStyle(fontSize: 20))
              : Text(data.name, style: TextStyle(fontSize: 20)),
          Text(data.score.toString() + " pts.", style: TextStyle(fontSize: 18)),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == 0
              ? Colors.amber[600].withOpacity(0.5)
              : index == 1
                  ? Colors.blue.withOpacity(0.5)
                  : index == 2
                      ? Colors.green.withOpacity(0.5)
                      : isYou
                          ? Colors.red.withOpacity(0.5)
                          : Colors.white),
    );
  }
}

//class for removing the glow from the scrolling part
class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
