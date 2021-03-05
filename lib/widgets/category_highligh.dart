import 'package:flutter/material.dart';
import 'package:structure_example/models/arguments_model/arg_cat_product.dart';
import 'package:structure_example/models/response_model/product_category_res.dart';
import 'package:structure_example/resource/texts_stype.dart';

class CategoryHighlightWidget extends StatefulWidget {
  @required
  final double widthItem;
  @required
  final List<CategoryProduct> listCat;

  const CategoryHighlightWidget({Key key, this.widthItem, this.listCat}) : super(key: key);
  @override
  _CategoryHighlightWidgetState createState() => _CategoryHighlightWidgetState();
}

class _CategoryHighlightWidgetState extends State<CategoryHighlightWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.listCat.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/cat-product", arguments: ArgCatProduct(idCat: widget.listCat[index].sId, listCat: widget.listCat));
          },
          child: Container(
            margin: EdgeInsets.only(right: 15),
            width: widget.widthItem,
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: constraints.constrainHeight() * 2 / 3,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDFCC7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text("${widget.listCat[index].name}", style: TextsStyle.title),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: constraints.constrainHeight() * 2 / 3,
                      width: constraints.constrainHeight() * 2 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            "${widget.listCat[index].img}",
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
      },
    );
  }
}
