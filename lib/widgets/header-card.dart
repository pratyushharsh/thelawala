import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const HeaderCard({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      padding: EdgeInsets.only(left: 12, right: 12, top: 25),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(subtitle, style: TextStyle(fontStyle: FontStyle.italic),)
        ],
      ),
    );
  }
}