import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/modules/dashboard/detail/basic-detail.dart';
import 'package:thelawala/modules/dashboard/detail/ratings-card.dart';
import 'package:thelawala/modules/dashboard/detail/upcoming-schedule.dart';

import 'custom-silver-appbar-deligate.dart';
import 'image-grid.dart';

class DashboardDetail extends StatefulWidget {
  const DashboardDetail({Key? key}) : super(key: key);

  @override
  _DashboardDetailState createState() => _DashboardDetailState();
}

class _DashboardDetailState extends State<DashboardDetail> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  Widget buildImage() => SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              SizedBox(height: 40,),
              BasicDetailCard(),
              UpcomingSchedules(),
              // MenuCard(),
              ImageGrid(),
              RatingsCard()
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: CustomSilverAppBarDelegate(expandedHeight: 200),
          pinned: true,
        ),
        buildImage(),
      ],
    );
  }
}

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.network(
            Constants.DUMMY_IMAGE,
            fit: BoxFit.cover,
          ),
          height: 200,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CircleAvatar(
            child: Text("PH"),
            minRadius: 50,
          ),
        )
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String header;
  final Widget child;
  const DashboardCard({Key? key, required this.header, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      width: double.infinity,
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
                  Text("Menu",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 12, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Delhi",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "Chef Bob's Lobstah Trap",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
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
