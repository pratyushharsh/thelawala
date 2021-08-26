import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/models/response/order-response.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/order_detail_bloc.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (ctx) => OrderDetailBloc(orderId, RepositoryProvider.of(ctx))
        ..add(LoadOrderDetail()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Summary: $orderId'),
        ),
        body: OrderDetail(),
      ),
    );
  }
}

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state.status == OrderDetailStatus.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == OrderDetailStatus.FAILURE) {
          return Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        }

        if (state.status == OrderDetailStatus.SUCCESS) {
          return OrderDetailWidget(order: state.order!);
        }

        return Container();
      },
    );
  }
}

class OrderDetailWidget extends StatelessWidget {
  final OrderResponse order;
  const OrderDetailWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Order Id: ${order.orderId}'),
          Text(
              'Order Date: ${DateFormat('MMMM d, yyyy').format(order.orderDate)}'),
          Text('Order Subtotal: ${order.subtotal}'),
          Text('Order Tax: ${order.tax}'),
          Text('Order Total: ${order.total}'),
          Text(
            'Status: ${order.status}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          ...order.lineItems
              .map((e) => OrderLineItem(
                    lineItem: e,
                  ))
              .toList(),
          OrderButtons()
        ],
      ),
    );
  }
}

class OrderLineItem extends StatelessWidget {
  final LineItems lineItem;
  const OrderLineItem({Key? key, required this.lineItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              '${lineItem.imageUrl != null ? lineItem.imageUrl : Constants.DUMMY_IMAGE}',
          height: 100,
          width: 100,
        ),
        Column(
          children: [
            Text('Price: ${lineItem.price.toStringAsFixed(2)}'),
            Text('Quantity: ${lineItem.quantity}')
          ],
        )
      ],
    );
  }
}

class OrderButtons extends StatelessWidget {
  const OrderButtons({Key? key}) : super(key: key);

  Widget buildConfirmButton(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        child: Text('Confirm'),
        onPressed: () {
          BlocProvider.of<OrderDetailBloc>(context).add(UpdateOrderStatus('CONFIRM'));
        },
      ),
    ));
  }

  Widget buildCancelledButton(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(4),
      child: OutlinedButton(
        child: Text('Cancelled'),
        onPressed: () {
          BlocProvider.of<OrderDetailBloc>(context).add(UpdateOrderStatus('CANCELLED'));
        },
      ),
    ));
  }

  Widget buildReadyForPickUpButton(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        child: Text('ReadyForPickUp'),
        onPressed: () {
          BlocProvider.of<OrderDetailBloc>(context).add(UpdateOrderStatus('READY_FOR_PICK_UP'));
        },
      ),
    ));
  }

  Widget buildPickedUpButton(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        child: Text('Picked Up'),
        onPressed: () {
          BlocProvider.of<OrderDetailBloc>(context).add(UpdateOrderStatus('PICKED_UP'));
        },
      ),
    ));
  }

  List<Widget> buildButton(BuildContext context, String status) {
    List<Widget> buttons = [];
    switch (status) {
      case 'OPEN':
        buttons.add(buildCancelledButton(context));
        buttons.add(buildConfirmButton(context));
        break;
      case 'CONFIRM':
        buttons.add(buildReadyForPickUpButton(context));
        break;
      case 'READY_FOR_PICKUP':
        buttons.add(buildPickedUpButton(context));
        break;
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state.status == OrderDetailStatus.SUCCESS) {
          return Row(
            children: buildButton(context, state.order!.status.toUpperCase()),
          );
        }
        return Container();
      },
    );
  }
}
