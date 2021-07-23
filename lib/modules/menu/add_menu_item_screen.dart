import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/widgets/custom_text_field.dart';
import 'package:thelawala/widgets/header-card.dart';

class AddMenuItemScreen extends StatelessWidget {
  const AddMenuItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tScaffoldColor,
      appBar: AppBar(
        toolbarHeight: tAppBarToolbarHeight,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.close),
        ),
        title: Text("Add New Product"),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: OutlinedButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(width: 1, style: BorderStyle.solid),
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            BasicItemDetail(),
            HeaderCard(
              title: "Tags",
              subtitle:
              "Add few tags so people can search using tags.",
            ),
            ProductTags(),
            HeaderCard(
              title: "Modifiers",
              subtitle:
                  "Let Your Customer customize their order the way they want.",
            ),
            Modifier(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class BasicItemDetail extends StatelessWidget {
  const BasicItemDetail({Key? key}) : super(key: key);

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
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
        child: Column(
          children: [
            CustomTextField(
              label: "Item Name",
              helperText: "Item Name Which You Would Like Your Customer To See",
              onValueChange: (val) {},
            ),
            CustomTextField(
              label: "Price",
              icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: Center(child: FaIcon(CupertinoIcons.money_dollar))),
              textInputType: TextInputType.number,
            ),
            CustomTextField(
              label: "Description",
              helperText: "More About ingredients in food.",
              minLines: 4,
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTags extends StatelessWidget {
  const ProductTags({Key? key}) : super(key: key);

  Widget _buildChip(String label, Color color) {
    return Chip(
      // labelPadding: EdgeInsets.all(2.0),
      // avatar: CircleAvatar(
      //   // radius: 10,
      //   backgroundColor: Colors.white70,
      //   child: Text(label[0].toUpperCase()),
      // ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: color,
      elevation: 0.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4),
    );
  }

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
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tags",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 6.0,
              // runSpacing: 6.0,
              // alignment: WrapAlignment.spaceBetween,
              children: [
                _buildChip('Gamer', Color(0xFFACDDDE)),
                _buildChip('Hacker', Color(0xFFcaf1DE)),
                _buildChip('Developer', Color(0xFFE1F8DC)),
                _buildChip('Racer', Color(0xFFF0DEFD)),
                _buildChip('Racer', Color(0xFFDEFDE0)),
                _buildChip('Racer', Color(0xFFFCF7DE)),
                _buildChip('Traveller', Color(0xFFDFFFFA)),
                _buildChip('Traveller', Color(0xFFFFF2FA)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Modifier extends StatelessWidget {
  const Modifier({Key? key}) : super(key: key);

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
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModifierGroup(),
            ModifierGroup(),
            ModifierGroup(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteConfig.NEW_ITEM_MODIFIER);
              },
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 6, bottom: 12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Text(
                    "+ Add New Modifier",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class ModifierGroup extends StatelessWidget {
  const ModifierGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Coke Modifier",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pepsi"),
              Text(
                "₹ 50.00",
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pepsi"),
              Text(
                "₹ 50.00",
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pepsi"),
              Text(
                "₹ 50.00",
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
