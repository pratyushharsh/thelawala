import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thelawala/constants/Constants.dart';

class RatingsCard extends StatelessWidget {
  const RatingsCard({Key? key}) : super(key: key);

  Widget buildRating(double x, double of) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "4.9",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "OUT OF 5",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        )
      ],
    );
  }

  Widget buildRatingBar(double x, double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        StarRating(
          color: Color(0xFFFDCE2A),
          rating: 4.9,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 2),
          child: Text(
            "250 ratings",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        )
      ],
    );
  }

  Widget buildProgressIndicator(int star, double percent) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            "${star}",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          Icon(
            Icons.star,
            size: 20,
            color: Color(0xFFFDCE2A),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.black12,
                color: Colors.black87,
                value: percent / 100,
              ),
            ),
          ),
          Container(
            width: 30,
            child: Text(
              "${percent.toInt()}%",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }

  Widget buildRatingsSummary() {
    return Container(
      child: Column(
        children: [
          buildProgressIndicator(5, 67),
          buildProgressIndicator(4, 14),
          buildProgressIndicator(3, 5),
          buildProgressIndicator(2, 3),
          buildProgressIndicator(1, 1),
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
                      "Ratings",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15, left: 12, right: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildRating(4.9, 5),
                        buildRatingBar(4.5, 245),
                      ],
                    ),
                    buildRatingsSummary(),
                    SizedBox(
                      height: 10,
                    ),
                    PeopleReview()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  // final RatingChangeCallback onRatingChanged;
  final double size;
  final Color color;

  StarRating(
      {this.starCount = 5,
      this.rating = 2.5,
      required this.color,
      this.size = 24});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        size: size,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        size: size,
        color: color,
      );
    } else {
      icon = new Icon(
        Icons.star,
        size: size,
        color: color,
      );
    }
    return new InkResponse(
      // onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

class PeopleReview extends StatelessWidget {
  const PeopleReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("10 Reviews"),
          PeopleReviewCard(),
          PeopleReviewCard(),
          PeopleReviewCard(),
        ],
      ),
    );
  }
}

class PeopleReviewCard extends StatefulWidget {
  const PeopleReviewCard({Key? key}) : super(key: key);

  @override
  _PeopleReviewCardState createState() => _PeopleReviewCardState();
}

class _PeopleReviewCardState extends State<PeopleReviewCard> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d, yyyy').format(now);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              Constants.DUMMY_IMAGE_BANNER,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      "Pratyush Harsh",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  StarRating(
                    size: 16,
                    color: Color(0xFFFDCE2A),
                    rating: 4,
                  ),
                  Text(
                    '4 of 5 $formattedDate',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black38),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: showMore ? Constants.DUMMY_REVIEW : '${Constants.DUMMY_REVIEW.substring(0, 100)}...',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: !showMore ? 'Show More' : '\tShow Less',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              setState(() {
                                showMore = !showMore;
                              });
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
