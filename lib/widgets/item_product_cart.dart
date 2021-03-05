import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_example/bloc/shopping/bloc_order.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/texts_stype.dart';
import 'package:structure_example/utils/val_format.dart';

class ItemProductCart extends StatefulWidget {
  final Product product;

  const ItemProductCart({Key key, this.product}) : super(key: key);
  @override
  _ItemProductCartState createState() => _ItemProductCartState();
}

class _ItemProductCartState extends State<ItemProductCart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: size.width / 5,
                width: size.width / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(widget.product.avatar ?? "-", fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.product.name ?? "NO NAME",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextsStyle.title,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: RaisedButton(
                                  onPressed: () {
                                    context.read<BlocOrder>().reduction(widget.product);
                                  },
                                  child: Icon(Icons.remove, color: ColorsData.primary),
                                  padding: EdgeInsets.all(0),
                                  visualDensity: VisualDensity.standard,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(widget.product.amount.toString(), style: TextsStyle.title.copyWith(color: Colors.grey)),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                child: RaisedButton(
                                  onPressed: () {
                                    context.read<BlocOrder>().increase(widget.product);
                                  },
                                  child: Icon(Icons.add, color: ColorsData.primary),
                                  padding: EdgeInsets.all(0),
                                  visualDensity: VisualDensity.standard,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: moneyFormat(widget.product.price), style: TextsStyle.title.copyWith(color: ColorsData.primary)),
                                TextSpan(text: " VNĐ    ", style: TextsStyle.subTitle),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<BlocOrder>().remove(widget.product);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: EdgeInsets.only(bottom: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
            ),
            child: Icon(Icons.delete, color: Colors.red[700]),
          ),
        ),
      ],
    );
  }
}
