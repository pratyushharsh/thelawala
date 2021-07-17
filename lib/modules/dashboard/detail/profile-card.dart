import 'package:flutter/material.dart';
import 'package:thelawala/constants/Constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.more_vert))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 12, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Delhi | Jaipur | Patna",
                            style: TextStyle(color: Colors.black87),
                          ),
                          Row(
                            children: [
                              Text(
                                "Chef Bob's Lobstah Trap",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.green,
                              )
                            ],
                          ),
                          Text(
                            "A Moments of Loving Food.",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 15,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                Constants.DUMMY_IMAGE_BANNER,
              ),
            ),
          )
        ],
      ),
    );
  }
}