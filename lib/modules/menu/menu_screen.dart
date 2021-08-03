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
      create: (ctx) => MenuBloc(RepositoryProvider.of(context))
        ..add(LoadMenuItemOfCategory(category.category)),
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
        body: BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
          if (state.status == MenuStatus.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: ListView(
              children: [
                ...state.menuItems
                    .map((e) => ProductCard(
                          menuItem: e,
                        ))
                    .toList(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteConfig.ADD_NEW_PRODUCT,
                        arguments: category.category);
                  },
                  child: Text("Add New Item"),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final MenuItemResponse menuItem;
  const ProductCard({Key? key, required this.menuItem}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _open = false;

  void toggle() {
    setState(() {
      _open = !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteConfig.UPDATE_PRODUCT, arguments: widget.menuItem);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          child: Column(
            children: [
              Row(
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
                          Text(
                            "${widget.menuItem.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.menuItem.description.length > 90
                                ? '${widget.menuItem.description.substring(0, 90)}...'
                                : widget.menuItem.description,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "₹ ${widget.menuItem.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (widget.menuItem.modifiers.length > 0)
                    IconButton(
                      onPressed: toggle,
                      icon: _open
                          ? Icon(Icons.arrow_drop_up)
                          : Icon(Icons.arrow_drop_down),
                    )
                ],
              ),
              if (_open)
                AnimatedContainer(
                  duration: Duration(seconds: 2),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Modifiers", style: TextStyle(fontWeight: FontWeight.bold),),
                      ...widget.menuItem.modifiers
                          .map(
                            (e) => MenuItemModifierGroup(
                              modifier: e,
                            ),
                          )
                          .toList()
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemModifierGroup extends StatelessWidget {
  final ResponseModifiers modifier;
  const MenuItemModifierGroup({Key? key, required this.modifier})
      : super(key: key);

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
          ...modifier.modifierItems
              .map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${e.itemName}"),
                      Text(
                        "₹ ${e.price.toStringAsFixed(2)}",
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
