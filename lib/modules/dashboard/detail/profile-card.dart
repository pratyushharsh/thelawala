import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/core/home/screen/bloc/home_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  Widget loadingWidget() {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25),
            width: double.infinity,
            child: Card(
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  // height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Container(
                          color: Colors.black38,
                          height: 15,
                          width: 180,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Container(
                          color: Colors.black38,
                          height: 15,
                          width: 220,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Container(
                          color: Colors.black38,
                          height: 15,
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 15,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CircleAvatar(
                radius: 30
              ),
            ),
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (DashboardStatus.LOADING == state.status) {
        return loadingWidget();
      }
      if (DashboardStatus.PROFILE_SUCCESSFULLY_LOADED == state.status) {
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
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(GetUserProfile());
                                },
                                icon: Icon(Icons.more_vert))
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
                                    '${state.userDetail?.name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
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

      return Container();
    });
  }
}
