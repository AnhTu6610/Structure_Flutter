import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_example/bloc/shopping/bloc_order.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';
import 'package:structure_example/resource/colors_data.dart';

class FloatingShoppingCart extends StatefulWidget {
  @override
  _FloatingShoppingCartState createState() => _FloatingShoppingCartState();
}

class _FloatingShoppingCartState extends State<FloatingShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: context.read<BlocOrder>().listProductCartStream,
        initialData: context.read<BlocOrder>().listProductCart,
        builder: (context, snapshot) {
          if (snapshot.data.length == 0) return SizedBox();
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(1),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/cart");
                  },
                  child: Icon(Icons.shopping_cart),
                  backgroundColor: ColorsData.primary,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FittedBox(child: Text(snapshot.data.length.toString(), style: TextStyle(color: Colors.white))),
              ),
            ],
          );
        });
  }
}
