import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impact/models/impactUser.dart';
import 'package:impact/models/user.dart';
import 'package:impact/screens/home/group.dart';
import 'package:impact/screens/home/impact.dart';
import 'package:impact/screens/home/improve.dart';
import 'package:impact/screens/home/insights.dart';
import 'package:impact/screens/home/profile.dart';

import 'package:impact/screens/shared/constants.dart';
import 'package:impact/screens/shared/loading.dart';
import 'package:impact/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 2;

  Widget showWidget() {
    switch (_index) {
      case 0:
        return Group();
      case 1:
        return Improve();
      case 2:
        return Impact();
      case 3:
        return Insights();
      case 4:
        return Profile();
        break;
      default:
        return Impact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: backgroundGradient,
              height: 800,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      showWidget(),
                    ]),
                bottomNavigationBar: CupertinoTabBar(
                    currentIndex: _index,
                    backgroundColor: Colors.transparent,
                    onTap: (val) => setState(() => _index = val),
                    activeColor: Colors.white,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.group), title: Text('Group')),
                      BottomNavigationBarItem(
                          icon: ImageIcon(AssetImage('assets/improve.png')),
                          title: Text('Improve')),
                      BottomNavigationBarItem(
                          icon:
                              ImageIcon(AssetImage('assets/impact-white.png')),
                          title: Text('Impact')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.timeline), title: Text('Insights')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), title: Text('Profile')),
                    ]),
              ),
            );
          } else {
            print('Home');
            return Loading();
          }
        });
  }
}
