import 'package:flutter/material.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EBEE),
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
          Container(
            padding: EdgeInsets.all(8),
            child: OutlinedButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 6,
            ),
            BasicDetailUpdate(),
            Introduction(),
            ContactDetail(),
            SocialInfoUpdate(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class BasicDetailUpdate extends StatelessWidget {
  const BasicDetailUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}

class SocialInfoUpdate extends StatelessWidget {
  const SocialInfoUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ),
            CustomTextField(
              label: "Instagram",
              icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: Center(child: FaIcon(FontAwesomeIcons.instagram))),
            ),
            CustomTextField(
              label: "Youtube",
              icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: Center(child: FaIcon(FontAwesomeIcons.youtube))),
            ),
          ],
        ),
      ),
    );
  }
}

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  const ContactDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ),
            CustomTextField(label: "Email", icon: Icon(Icons.email)),
            CustomTextField(label: "Website", icon: Icon(Icons.language)),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? helperText;
  final int minLines;
  final int maxLines;
  final Widget? icon;
  CustomTextField(
      {Key? key,
      this.icon,
      this.helperText,
      required this.label,
      this.maxLines = 1,
      this.minLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${label}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        if (helperText != null && helperText!.length > 0)
          Text(helperText!,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black38,
                  fontSize: 12)),
        SizedBox(
          height: 5,
        ),
        TextField(
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
            prefixIcon: icon,
            contentPadding: EdgeInsets.all(12),
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
