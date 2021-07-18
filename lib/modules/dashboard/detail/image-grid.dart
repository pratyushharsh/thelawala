import 'package:flutter/material.dart';
import 'package:thelawala/constants/Constants.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key}) : super(key: key);

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
                      "Photos",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: Constants.DUMMY_PHOTO_IMAGES
                      .map(
                        (e) => DisplayImage(
                          imageUrl: e,
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final String imageUrl;
  const DisplayImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ));
  }
}
