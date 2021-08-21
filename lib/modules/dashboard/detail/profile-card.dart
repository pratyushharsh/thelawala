import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/core/home/screen/bloc/home_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';
import 'package:http/http.dart' as http;

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
                      SizedBox(
                        height: 30,
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
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
              child: CircleAvatar(radius: 30),
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
                  child: state.userDetail!.logo != null
                      ? Logo(
                          url: state.userDetail!.logo!.large,
                        )
                      : Logo(url: Constants.DUMMY_IMAGE))
            ],
          ),
        );
      }

      return Container();
    });
  }
}

class Logo extends StatefulWidget {
  final String url;
  const Logo({Key? key, required this.url}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  late RestApiBuilder api;
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  onLogoTap() async {
    ImageSource? src = await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: buildButton(
                      onTap: () {
                        Navigator.of(ctx).pop(ImageSource.camera);
                      },
                      icon: Icons.camera_alt,
                      title: "Camera"),
                ),
                Expanded(
                  child: buildButton(
                      onTap: () {
                        Navigator.of(ctx).pop(ImageSource.gallery);
                      },
                      icon: Icons.file_copy_outlined,
                      title: "Gallery"),
                ),
              ],
            ));
      },
    );
    if (src != null) {
      XFile? _image =
      await _picker.pickImage(source: src, imageQuality: 30);
      setState(() {
        image = _image;
        uploadImage();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    api = RepositoryProvider.of(context);
  }

  Widget buildButton(
      {required GestureTapCallback? onTap,
        required String title,
        required IconData icon}) {
    return Container(
      margin: EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "$title",
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }

  void uploadImage() async {
    if (image == null) return;
    RestOptions option = RestOptions(path: "/logo");
    try {
      var rawResponse = await api.get(restOptions: option);
      var resp = api.parsedResponse(rawResponse);
      var _uploadUrl = resp['uploadURL'];
      var _fileName = resp['filename'];
      print(_fileName);
      File _tmpFile = File(image!.path);
      var uploadResponse = await http.put(Uri.parse(_uploadUrl),
          body: _tmpFile.readAsBytesSync());
      print(uploadResponse.body);
    } catch (e) {
      print('**********Error**********');
      print(e);
      print('**********Error**********');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onLogoTap,
      child: image == null
          ? CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                widget.url,
              ),
            )
          : CircleAvatar(
              radius: 30,
              backgroundImage: FileImage(File(image!.path)),
            ),
    );
  }
}
