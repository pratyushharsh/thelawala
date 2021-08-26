import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/models/response/order-search-response.dart';

import 'bloc/order_search_bloc.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<OrderSearchBloc>(context);
    if (bloc.state.status == OrderSearchStatus.INITIAL) {
      bloc.add(LoadUserOrders());
    }
    return Scaffold(
      body: BlocBuilder<OrderSearchBloc, OrderSearchState>(
        builder: (context, state) {
          if (state.status == OrderSearchStatus.LOADING) {
            return CircularProgressIndicator();
          }
          return RefreshIndicator(
            onRefresh: () async {
              bloc.add(LoadUserOrders());
            },
            child: ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (ctx, idx) => OrderSearchCard(
                order: state.orders[idx],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderSearchCard extends StatelessWidget {
  final OrderSearchResponse order;
  const OrderSearchCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String orderDate =
        DateFormat('MMMM d, yyyy').format(order.orderDate);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteConfig.ORDER_DETAIL_PAGE, arguments: order.orderId);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Id: ${order.orderId}"),
                  Text("Total: ${order.total}"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Date: $orderDate"),
                  Text("Status: ${order.status}"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
