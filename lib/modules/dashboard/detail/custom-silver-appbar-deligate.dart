import 'package:flutter/material.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/modules/dashboard/detail/profile-card.dart';

class CustomSilverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  CustomSilverAppBarDelegate({required this.expandedHeight});

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 180;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
        Positioned(
          top: top,
          left: 6,
          right: 6,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          child: ProfileCard(),
          width: double.infinity,
        ),
      );

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Hero(
                tag: "profile-logo",
                child: CircleAvatar(
                  // radius: 20,
                  backgroundImage: NetworkImage(
                    Constants.DUMMY_IMAGE_BANNER,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text("Chef Bob's Lobstah Trap")
            ],
          ),
          centerTitle: true,
        ),
      );

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.network(
          Constants.DUMMY_IMAGE,
          fit: BoxFit.cover,
        ),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
