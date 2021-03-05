import 'package:flutter/material.dart';
import 'package:structure_example/models/arguments_model/arg_news.dart';
import 'package:structure_example/models/response_model/list_news_res.dart';
import 'package:structure_example/resource/texts_stype.dart';
import 'package:structure_example/utils/val_format.dart';

class ItemHandbookVertical extends StatefulWidget {
  final NewsRes newsRes;

  const ItemHandbookVertical({Key key, this.newsRes}) : super(key: key);
  @override
  _ItemHandbookVerticalState createState() => _ItemHandbookVerticalState();
}

class _ItemHandbookVerticalState extends State<ItemHandbookVertical> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          "/handbooknewsdetail",
          arguments: ArgNews(
            title: widget.newsRes.title,
            sId: widget.newsRes.sId,
            img: widget.newsRes.img,
            createdAt: widget.newsRes.createdAt,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: size.width / 2.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: size.width / 2,
                child: Image.network(widget.newsRes?.img ?? "-", fit: BoxFit.cover),
              ),
              Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.newsRes.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextsStyle.title.copyWith(color: Colors.white),
                    ),
                    Text("${dateTimeFormatByString(widget.newsRes.createdAt)}", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
