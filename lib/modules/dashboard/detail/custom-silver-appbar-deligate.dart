import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/core/home/screen/bloc/home_bloc.dart';
import 'package:thelawala/models/response/get-user-profile.dart';
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

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            buildBackground(shrinkOffset),
            buildAppBar(shrinkOffset, state.userDetail),
            Positioned(
              top: top,
              left: 6,
              right: 6,
              child: buildFloating(shrinkOffset),
            ),
          ],
        );
      }
    );
  }

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          child: ProfileCard(),
          width: double.infinity,
        ),
      );

  Widget buildAppBar(double shrinkOffset, UserProfileResponse? user) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          toolbarHeight: tAppBarToolbarHeight,
          title: Row(
            children: [
              Hero(
                tag: "profile-logo",
                child: CircleAvatar(
                  // radius: 20,
                  backgroundImage: user != null ? NetworkImage(
                    user.logo.large,
                  ) : NetworkImage(
                    Constants.DUMMY_IMAGE_BANNER,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text("${user?.name}")
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
  double get minExtent => tAppBarToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
