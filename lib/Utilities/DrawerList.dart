import'package:flutter/material.dart';


class drawerListView extends StatelessWidget {
  final String title;
  final Icon iconName;
  final Function Progress;
  drawerListView({this.title, this.iconName, this.Progress});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconName,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 17.0  ,
            color: Colors.white38
        ),
      ),
      onTap: () {
        Progress();
      },
    );
  }
}