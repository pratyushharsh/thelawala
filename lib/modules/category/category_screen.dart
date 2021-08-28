import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/models/response/category-response.dart';
import 'package:thelawala/modules/category/bloc/category_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        if (state.status == CategoryStatus.LOADING)
          return Center(
            child: SizedBox(
                height: 150, width: 150, child: CircularProgressIndicator()),
          );

        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<CategoryBloc>(context).add(LoadCategories());
          },
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              if (state.status == CategoryStatus.SUCCESS)
                ...state.categories
                    .map((e) => CategoryCard(
                          category: e,
                        ))
                    .toList(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteConfig.ADD_NEW_CATEGORY);
                },
                child: Text("Add New Category"),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryResponse category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteConfig.MENU_SCREEN, arguments: category);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Text("CT"),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${category.name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text("${category.itemCount} items")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
