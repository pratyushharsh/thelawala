import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/models/response/category-response.dart';
import 'package:thelawala/models/response/menu-item-response.dart';
import 'package:thelawala/modules/menu/bloc/menu_bloc.dart';

class MenuScreen extends StatelessWidget {
  final CategoryResponse category;
  const MenuScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (ctx) => MenuBloc(RepositoryProvider.of(context))..add(LoadMenuItemOfCategory(category.category)),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: tAppBarToolbarHeight,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.close),
          ),
          title: Text("Menu In ${category.name}"),
        ),
        body: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {

            if (state.status == MenuStatus.LOADING) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: Column(
                children: [
                  ...state.menuItems.map((e) => ProductCard(menuItem: e,)).toList(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteConfig.ADD_NEW_PRODUCT, arguments: category.category);
                    },
                    child: Text("Add New Item"),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final MenuItemResponse menuItem;
  const ProductCard({Key? key,required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.network(
                Constants.DUMMY_IMAGE,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${menuItem.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 10,),
                    Text(menuItem.description.length > 90 ? '${menuItem.description.substring(0, 90)}...' : menuItem.description, style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
                    SizedBox(height: 10,),
                    Text("₹ ${menuItem.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
