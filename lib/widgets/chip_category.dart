import 'package:flutter/material.dart';
import 'package:structure_example/app_localizations.dart';
import 'package:structure_example/models/arguments_model/arg_cat_product.dart';
import 'package:structure_example/models/response_model/product_category_res.dart';
import 'package:structure_example/resource/colors_data.dart';

class Chipcategory extends StatefulWidget {
  final List<CategoryProduct> liscat;

  const Chipcategory({Key key, this.liscat}) : super(key: key);
  @override
  _ChipcategoryState createState() => _ChipcategoryState();
}

class _ChipcategoryState extends State<Chipcategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.liscat.length + 1,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: index == 0
                  ? OutlineButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/cat-product", arguments: ArgCatProduct(idCat: null, listCat: widget.liscat));
                      },
                      child: Text(translate(context, "all")),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      textColor: ColorsData.primary,
                      borderSide: BorderSide(color: ColorsData.primary),
                    )
                  : OutlineButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/cat-product", arguments: ArgCatProduct(idCat: widget.liscat[index - 1].sId, listCat: widget.liscat));
                      },
                      child: Text(widget.liscat[index - 1].name),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      textColor: ColorsData.primary,
                      borderSide: BorderSide(color: ColorsData.primary),
                    ),
            ),
          );
        },
      ),
    );
  }
}
