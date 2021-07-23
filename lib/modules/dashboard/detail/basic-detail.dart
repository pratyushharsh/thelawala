import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/core/home/screen/bloc/home_bloc.dart';

class BasicDetailCard extends StatelessWidget {
  const BasicDetailCard({Key? key}) : super(key: key);

  Widget buildDetailRow(Widget icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(text)
        ],
      ),
    );
  }

  Widget loadingWidget() {
    return Container(
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
                Shimmer.fromColors(
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: true,
                  child: Container(
                    color: Colors.black38,
                    height: 12,
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
                    height: 12,
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
                    height: 12,
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
                    height: 12,
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
                    height: 40,
                    width: double.infinity,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (DashboardStatus.LOADING == state.status) {
          return loadingWidget();
        }
        if (DashboardStatus.PROFILE_SUCCESSFULLY_LOADED == state.status) {
          return Container(
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
                          Navigator.of(context).pushNamed(
                              RouteConfig.UPDATE_USER_PROFILE);
                        }, icon: Icon(Icons.more_vert))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.userDetail?.contact.phone != null)
                            buildDetailRow(Icon(Icons.phone), '${state.userDetail?.contact.phone}'),

                          if (state.userDetail?.contact.website != null)
                            buildDetailRow(FaIcon(FontAwesomeIcons.globe), '${state.userDetail?.contact.website}'),

                          if (state.userDetail?.contact.email != null)
                            buildDetailRow(FaIcon(FontAwesomeIcons.envelope), '${state.userDetail?.contact.email}'),

                          if (state.userDetail?.social.facebook != null)
                            buildDetailRow(FaIcon(FontAwesomeIcons.facebook), '${state.userDetail?.social.facebook}'),

                          if (state.userDetail?.social.instagram != null)
                            buildDetailRow(FaIcon(FontAwesomeIcons.instagram), '${state.userDetail?.social.instagram}'),

                          if (state.userDetail?.social.youtube != null)
                            buildDetailRow(FaIcon(FontAwesomeIcons.youtube), '${state.userDetail?.social.youtube}'),

                          if (state.userDetail?.social.twitter != null)
                            buildDetailRow(FaIcon(FontAwesomeIcons.twitter), '${state.userDetail?.social.twitter}'),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 10),
                            child: Text(
                              "Introduction",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text('${state.userDetail?.introduction}')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      }
    );
  }
}
