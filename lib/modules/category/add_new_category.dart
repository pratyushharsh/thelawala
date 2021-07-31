import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/widgets/custom_text_field.dart';
import 'package:thelawala/widgets/header-card.dart';

import 'bloc/new_category_bloc.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => NewCategoryBloc(RepositoryProvider.of(context)),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: tAppBarToolbarHeight,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.close),
          ),
          title: Text("New Category"),
          actions: [
            BlocBuilder<NewCategoryBloc, NewCategoryState>(
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: OutlinedButton(
                    onPressed: state.isValid ? () {
                      BlocProvider.of<NewCategoryBloc>(context)
                          .add(SubmitCategory());
                    } : null,
                    child: Text("Save"),
                  ),
                );
              }
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderCard(
                title: "Category",
                subtitle: "Create a new category for the group.",
              ),
              SizedBox(
                height: 20,
              ),
              NewCategoryInputFields()
            ],
          ),
        ),
      ),
    );
  }
}

class NewCategoryInputFields extends StatelessWidget {
  const NewCategoryInputFields({Key? key}) : super(key: key);

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
          top: 12,
          left: 12,
          right: 12,
        ),
        child: BlocBuilder<NewCategoryBloc, NewCategoryState>(
          builder: (context, state) {
            return Column(
              children: [
                CustomTextField(
                  initialValue: state.category,
                  label: "Group Id",
                  onValueChange: (val) {
                    BlocProvider.of<NewCategoryBloc>(context)
                        .add(OnGroupIdChange(val));
                  },
                ),
                CustomTextField(
                  initialValue: state.name,
                  label: "Group Name",
                  onValueChange: (val) {
                    BlocProvider.of<NewCategoryBloc>(context)
                        .add(OnGroupNameChange(val));
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
