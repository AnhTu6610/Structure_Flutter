import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_example/app_localizations.dart';
import 'package:structure_example/bloc/shopping/bloc_order.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/texts_stype.dart';
import 'package:structure_example/utils/val_format.dart';

class ItemProductHorizontal extends StatefulWidget {
  final Product product;

  const ItemProductHorizontal({Key key, this.product}) : super(key: key);
  @override
  _ItemProductHorizontalState createState() => _ItemProductHorizontalState();
}

class _ItemProductHorizontalState extends State<ItemProductHorizontal> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/product", arguments: widget.product);
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
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
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        widget.product.avatar ?? "-",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null
                              ? child
                              : Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    value: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes,
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.product.name ?? "__",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextsStyle.title,
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.product.sub_content ?? "-",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextsStyle.subTitle,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "${moneyFormat(widget.product.price)}", style: TextsStyle.title.copyWith(color: ColorsData.primary)),
                                TextSpan(text: " VNĐ    ", style: TextsStyle.subTitle),
                              ],
                            ),
                          ),
                          Text("${moneyFormat(widget.product.priceDiscount)}", style: TextsStyle.subTitle.copyWith(decoration: TextDecoration.lineThrough))
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
              context.read<BlocOrder>().addToCart(widget.product);
              Flushbar(
                title: "${translate(context, "notiATCBefor")} ${widget.product.name} ${translate(context, "notiATCAppter")}",
                message: " ${moneyFormat(widget.product.price)} VNĐ",
                duration: Duration(seconds: 2),
                backgroundColor: ColorsData.primary,
                flushbarStyle: FlushbarStyle.FLOATING,
                flushbarPosition: FlushbarPosition.TOP,
                icon: Icon(Icons.add_shopping_cart, size: 30, color: Colors.white),
                onTap: (flushbar) => Navigator.of(context).pushNamed("/cart"),
              )..show(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: ColorsData.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
