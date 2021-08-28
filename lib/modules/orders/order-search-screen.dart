import 'dart:async';

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

  Color getColor(String status) {
    switch (status) {
      case 'OPEN':
        return Colors.yellow;
      case 'CONFIRM':
        return Colors.blueAccent;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    String orderDate = DateFormat('MMMM d, yyyy').format(order.orderDate);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteConfig.ORDER_DETAIL_PAGE, arguments: order.orderId);
      },
      child: Card(
        shape:
            Border(left: BorderSide(color: getColor(order.status), width: 8)),
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'ORDER',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('$orderDate'),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: CountDown(time: order.orderDate),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('${order.status}'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${order.orderId}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                      Text(
                        '\$${order.total.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 30),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CountDown extends StatefulWidget {
  final DateTime time;
  const CountDown({Key? key, required this.time}) : super(key: key);

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late DateTime now;
  final NumberFormat formatter = NumberFormat("00");
  Timer? _timer;

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
     _timer = new Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = now.difference(widget.time);
    int seconds = duration.inSeconds;
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;
    return Text(
      '$minutes:${formatter.format(sec)}',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
