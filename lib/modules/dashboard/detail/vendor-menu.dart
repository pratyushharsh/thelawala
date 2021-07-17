import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      // width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        elevation: 0,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
              Container(
                height: 200,
                padding: EdgeInsets.only(bottom: 15),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    MenuItemCard(),
                    MenuItemCard(),
                    MenuItemCard(),
                    MenuItemCard(),
                    MenuItemCard(),
                    MenuItemCard(),
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

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [Text("Tandoori ₹5.00")],
      ),
    );
  }
}
