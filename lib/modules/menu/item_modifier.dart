import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/models/pojo/menu_modal.dart';
import 'package:thelawala/widgets/custom_switch.dart';
import 'package:thelawala/widgets/custom_text_field.dart';
import 'package:thelawala/widgets/header-card.dart';

import 'bloc/item_modifier_bloc.dart';

class NewItemModifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => ItemModifierBloc(),
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
          title: Text("New Item modifier"),
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
              ModifierGroupName(),
              HeaderCard(
                title: "Item List",
                subtitle: "Add or Remove Item Modifier.",
              ),
              ModifierItemList(),
              HeaderCard(
                title: "Rules",
                subtitle:
                    "Set Rules to control how consuler select items in the modifier group.",
              ),
              RulesCard()
            ],
          ),
        ),
      ),
    );
  }
}

class ModifierGroupName extends StatelessWidget {
  const ModifierGroupName({Key? key}) : super(key: key);

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
        child: BlocBuilder<ItemModifierBloc, ItemModifierState>(
            builder: (context, state) {
          return CustomTextField(
            initialValue: state.groupName,
            label: "Modifier Group Name",
            onValueChange: (val) {
              BlocProvider.of<ItemModifierBloc>(context)
                  .add(OnGroupNameChange(val));
            },
          );
        }),
      ),
    );
  }
}

class ModifierItemList extends StatelessWidget {
  Widget buildItem(ModifierItem e) {
    return Column(children: [
      ExistingModifierList(
        item: e,
      ),
      Divider(),
    ]);
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
          child: BlocBuilder<ItemModifierBloc, ItemModifierState>(
              builder: (context, state) {
            return Column(
              children: [
                ...state.items.map((e) => buildItem(e)).toList(),
                NewModifierItemList()
              ],
            );
          }),
        ));
  }
}

class ExistingModifierList extends StatelessWidget {
  final ModifierItem item;
  const ExistingModifierList({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text("${item.name}"),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("\$ ${item.price}"),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              BlocProvider.of<ItemModifierBloc>(context)
                  .add(DeleteItemModifier(item));
            },
            child: SizedBox(
              height: 35,
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class NewModifierItemList extends StatefulWidget {
  const NewModifierItemList({Key? key}) : super(key: key);

  @override
  _NewModifierItemListState createState() => _NewModifierItemListState();
}

class _NewModifierItemListState extends State<NewModifierItemList> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
  }

  bool isValid() {
    return _nameController.text.isNotEmpty && _priceController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void onChange(String val) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: CustomTextField(
            controller: _nameController,
            label: "Modifier Name",
            onValueChange: onChange,
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomTextField(
              controller: _priceController,
              onValueChange: onChange,
              prefixIconConstraint: BoxConstraints(minWidth: 30, minHeight: 40),
              textInputType: TextInputType.number,
              label: "Price",
              icon: Icon(CupertinoIcons.money_dollar),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: isValid() ? Colors.green : Colors.grey,
            ),
            onPressed: isValid()
                ? () {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<ItemModifierBloc>(context).add(
                        AddNewItemModifier(
                            name: _nameController.text,
                            price: double.parse(_priceController.text)));
                    _nameController.clear();
                    _priceController.clear();
                  }
                : null,
          ),
        )
      ],
    );
  }
}

class RulesCard extends StatelessWidget {
  const RulesCard({Key? key}) : super(key: key);

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
      child: BlocBuilder<ItemModifierBloc, ItemModifierState>(
          builder: (context, state) {
        return Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: Column(
              children: [
                CustomSwitch(
                  label: "Must Select",
                  value: state.mustSelect,
                  onChange: (val) {
                    BlocProvider.of<ItemModifierBloc>(context).add(OnMustSelectChange(val));
                  },
                ),
                CustomSwitch(
                  label: "Allow Multiple Selections",
                  value: state.multipleSelectionAllowed,
                  onChange: (val) {
                    BlocProvider.of<ItemModifierBloc>(context).add(OnAllowMultiSelectChange(val));
                  },
                ),
              ],
            ));
      }),
    );
  }
}
