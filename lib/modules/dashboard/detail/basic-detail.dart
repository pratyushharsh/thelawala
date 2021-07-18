import 'package:flutter/material.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/constants/Constants.dart';

class BasicDetailCard extends StatelessWidget {
  const BasicDetailCard({Key? key}) : super(key: key);

  Widget buildDetailRow(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(text)
        ],
      ),
    );
  }

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
                      "Basic Information",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(onPressed: () {
                    Navigator.of(context).pushNamed(RouteConfig.UPDATE_USER_PROFILE);
                  }, icon: Icon(Icons.more_vert))
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow(Icons.phone, "+91 9430123120"),
                    buildDetailRow(Icons.language, "www.ph7.dev"),
                    buildDetailRow(Icons.facebook, "pratyush.harsh"),
                    buildDetailRow(Icons.youtube_searched_for, "www.ph7.dev"),
                    buildDetailRow(Icons.facebook, "+91 9430123120"),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Text(
                        "Introduction",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(Constants.LOREM_IPSUM)
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
