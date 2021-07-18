import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingSchedules extends StatelessWidget {
  const UpcomingSchedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      // width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        elevation: 0,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Schedules",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
              Container(
                height: 130,
                padding: EdgeInsets.only(bottom: 15),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ScheduleCard(),
                    ScheduleCard(),
                    ScheduleCard(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm a EEEE\nMMMM d, yyyy').format(now);

    return Container(
      width: 200,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.location_pin)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Event Name", style: TextStyle(fontWeight: FontWeight.w700),),
              SizedBox(height: 8,),
              Text(formattedDate),
              SizedBox(height: 3,),
              Text("Starting in 5 hours", style: TextStyle(color: Color(0xFF228C22), fontWeight: FontWeight.bold),)
            ],
          ),
        ],
      ),
    );
  }
}