import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_example/app_localizations.dart';
import 'package:structure_example/bloc/shopping/bloc_order.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/texts_stype.dart';
import 'package:structure_example/utils/val_format.dart';

class ItemProductVertiacl extends StatefulWidget {
  final Product product;

  const ItemProductVertiacl({Key key, this.product}) : super(key: key);
  @override
  _ItemProductVertiaclState createState() => _ItemProductVertiaclState();
}

class _ItemProductVertiaclState extends State<ItemProductVertiacl> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/product", arguments: widget.product);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: size.width / 2.5,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: constraints.constrainHeight() * 3 / 4,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDFCC7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.product?.name ?? "__",
                            style: TextsStyle.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "${moneyFormat(widget.product.price)}", style: TextsStyle.title.copyWith(color: ColorsData.primary)),
                                TextSpan(text: " VNĐ", style: TextsStyle.subTitle),
                              ],
                            ),
                          ),
                          Text("${moneyFormat(widget.product.priceDiscount)}", style: TextsStyle.subTitle.copyWith(decoration: TextDecoration.lineThrough))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    context.read<BlocOrder>().addToCart(widget.product);
                    Flushbar(
                      title: "${translate(context, "notiATCBefor")} ${widget.product.name} ${translate(context, "notiATCAppter")}",
                      message: " ${widget.product.price.toString()} VNĐ",
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                    ),
                    child: Icon(Icons.add, color: ColorsData.primary),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: constraints.constrainHeight() * 2 / 4,
                  width: constraints.constrainHeight() * 2 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        widget.product?.avatar ?? "-",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
