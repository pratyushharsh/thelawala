import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/models/pojo/menu_modal.dart';
import 'package:thelawala/models/response/menu-item-response.dart';
import 'package:thelawala/widgets/custom_switch.dart';
import 'package:thelawala/widgets/custom_text_field.dart';
import 'package:thelawala/widgets/header-card.dart';

import 'bloc/new_menu_bloc.dart';
import '../../../utils/extension/input-string-extension.dart';

class AddMenuItemScreen extends StatelessWidget {
  final String categoryId;
  final bool isUpdate;
  final MenuItemResponse? item;
  const AddMenuItemScreen(
      {Key? key, required this.categoryId, this.isUpdate = false, this.item})
      : assert(isUpdate ? item != null : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (ctx) => NewMenuBloc(RepositoryProvider.of(ctx), categoryId,
          existingItem: item),
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
          title: Text(isUpdate ? "Update Product" : "Add New Product"),
          actions: [
            Container(
              padding: EdgeInsets.all(8),
              child: BlocBuilder<NewMenuBloc, NewMenuState>(
                  builder: (context, state) {
                return isUpdate
                    ? OutlinedButton(
                        onPressed: state.isValid ? () {} : null,
                        child: Text('Update'),
                      )
                    : OutlinedButton(
                        onPressed: state.isValid
                            ? () {
                                BlocProvider.of<NewMenuBloc>(context)
                                    .add(OnCreateNewMenuItem());
                              }
                            : null,
                        child: Text('Save'),
                      );
              }),
            )
          ],
        ),
        body: BlocListener<NewMenuBloc, NewMenuState>(
          listener: (BuildContext context, state) {
            if (NewMenuStatus.LOADING == state.status) {
              Dialog errorDialog = Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0)), //this right here
                child: Container(
                  height: 200.0,
                  width: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => errorDialog);
            } else if (NewMenuStatus.SUCCESS == state.status) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          },
          child: SingleChildScrollView(
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
                  subtitle: "Add few tags so people can search using tags.",
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
        child:
            BlocBuilder<NewMenuBloc, NewMenuState>(builder: (context, state) {
          return Column(
            children: [
              CustomTextField(
                initialValue: state.name,
                label: "Item Name",
                errorText: state.name.validate(required: true),
                helperText:
                    "Item Name Which You Would Like Your Customer To See",
                onValueChange: (val) {
                  BlocProvider.of<NewMenuBloc>(context)
                      .add(OnItemNameChange(val));
                },
              ),
              CustomTextField(
                initialValue: double.tryParse(state.price) != null
                    ? double.parse(state.price).toStringAsFixed(2)
                    : state.price,
                label: "Price",
                errorText: state.price.toString().validate(required: true),
                icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(child: FaIcon(CupertinoIcons.money_dollar))),
                textInputType: TextInputType.number,
                onValueChange: (val) {
                  BlocProvider.of<NewMenuBloc>(context).add(OnPriceChange(val));
                },
              ),
              CustomTextField(
                initialValue: state.description,
                label: "Description",
                helperText: "More About ingredients in food.",
                errorText: state.description.validate(required: true),
                minLines: 4,
                maxLines: 6,
                onValueChange: (val) {
                  BlocProvider.of<NewMenuBloc>(context)
                      .add(OnDescriptionChange(val));
                },
              ),
              CustomSwitch(
                  value: state.active,
                  label: "Active",
                  onChange: (val) {
                    BlocProvider.of<NewMenuBloc>(context)
                        .add(OnActiveChange(val));
                  }),
            ],
          );
        }),
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
        child:
            BlocBuilder<NewMenuBloc, NewMenuState>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...state.modifier.map((e) => ModifierGroup(modifier: e)).toList(),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouteConfig.NEW_ITEM_MODIFIER)
                      .then((value) => {
                            if (value != null && value is List)
                              {
                                BlocProvider.of<NewMenuBloc>(context)
                                    .add(AddNewModifier(value[0]))
                              }
                          });
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
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class ModifierGroup extends StatelessWidget {
  final MenuItemModifier modifier;
  const ModifierGroup({Key? key, required this.modifier}) : super(key: key);

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
            "${modifier.groupName}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
          ),
          Divider(),
          ...modifier.items
              .map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${e.name}"),
                      Text(
                        "₹ ${e.price}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ))
              .toList(),
        ],
      ),
    );
  }
}
