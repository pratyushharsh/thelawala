import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/validation/input-text-validator.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thelawala/core/home/screen/bloc/home_bloc.dart';
import 'package:thelawala/widgets/custom_text_field.dart';
import 'package:thelawala/widgets/header-card.dart';

import 'bloc/update_profile_bloc.dart';
import '../../../utils/extension/input-string-extension.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (ctx) => UpdateProfileBloc(RepositoryProvider.of(ctx),
            profile: BlocProvider.of<HomeBloc>(context).state.userDetail!),
        child: UpdateUserProfileForm());
  }
}

class UpdateUserProfileForm extends StatelessWidget {
  const UpdateUserProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (UpdateProfileStatus.AWAITING_CONFIRMATION == state.status) {
          Dialog errorDialog = Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container(
              height: 200.0,
              width: 100.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
          showDialog(
              context: context, builder: (BuildContext context) => errorDialog);
        } else if (UpdateProfileStatus.SUCCESS == state.status) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: tScaffoldColor,
        appBar: AppBar(
          toolbarHeight: tAppBarToolbarHeight,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.close),
          ),
          title: Text("Update Profile"),
          actions: [
            BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(8),
                child: OutlinedButton(
                  onPressed: state.isValid()
                      ? () {
                          BlocProvider.of<UpdateProfileBloc>(context)
                              .add(UpdateProfileDetailEvent());
                        }
                      : null,
                  child: Text('Save'),
                ),
              );
            }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 6,
              ),
              BasicDetailUpdate(),
              HeaderCard(
                title: "Brag Yourself",
                subtitle:
                "Brag your customer about the way you cook.",
              ),
              Introduction(),
              HeaderCard(
                title: "Contact Information",
                subtitle:
                "Let Your customer reach you through the phone if required.",
              ),
              ContactDetail(),
              HeaderCard(
                title: "Social Media",
                subtitle:
                    "Let Your customer know you through the social media.",
              ),
              SocialInfoUpdate(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BasicDetailUpdate extends StatelessWidget {
  const BasicDetailUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
        builder: (context, state) {
      return Card(
        elevation: tCardElevation,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
          child: Column(
            children: [
              CustomTextField(
                label: "Name",
                helperText: "Name Which You Want People To See",
                initialValue: state.name,
                errorText: state.name.validate(required: true),
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnNameChange(val));
                },
              ),
              CustomTextField(
                label: "Cities",
              ),
              CustomTextField(
                label: "Dishes",
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SocialInfoUpdate extends StatelessWidget {
  const SocialInfoUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
        builder: (context, state) {
      return Card(
        elevation: tCardElevation,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
          child: Column(
            children: [
              CustomTextField(
                label: "Facebook",
                icon: Icon(Icons.facebook),
                initialValue: state.facebook,
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnFacebookChange(val));
                },
              ),
              CustomTextField(
                label: "Instagram",
                icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(child: FaIcon(FontAwesomeIcons.instagram))),
                initialValue: state.instagram,
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnInstagramChange(val));
                },
              ),
              CustomTextField(
                label: "Youtube",
                icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(child: FaIcon(FontAwesomeIcons.youtube))),
                initialValue: state.youtube,
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnYoutubeChange(val));
                },
              ),
              CustomTextField(
                label: "Twitter",
                icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(child: FaIcon(FontAwesomeIcons.twitter))),
                initialValue: state.twitter,
                onValueChange: (val) {},
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
        builder: (context, state) {
      return Card(
        elevation: tCardElevation,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
          child: Column(
            children: [
              CustomTextField(
                label: "Introduction",
                helperText: "Should Intro About Your Food Truck",
                minLines: 8,
                maxLines: 20,
                initialValue: state.introduction,
                errorText: state.introduction.validate(required: true),
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnIntroductionChange(val));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ContactDetail extends StatelessWidget {
  const ContactDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
        builder: (context, state) {
      return Card(
        elevation: tCardElevation,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
          child: Column(
            children: [
              CustomTextField(
                label: "Phone",
                icon: Icon(Icons.phone),
                initialValue: state.phone,
                errorText: state.phone.validate(
                    required: true, regex: InputValidator.phoneValidator),
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnPhoneChange(val));
                },
              ),
              CustomTextField(
                label: "Email",
                icon: Icon(Icons.email),
                initialValue: state.email,
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnEmailChange(val));
                },
              ),
              CustomTextField(
                label: "Website",
                icon: Icon(Icons.language),
                initialValue: state.website,
                errorText: state.website
                    .validate(regex: InputValidator.websiteValidator),
                onValueChange: (val) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(OnWebsiteChange(val));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
