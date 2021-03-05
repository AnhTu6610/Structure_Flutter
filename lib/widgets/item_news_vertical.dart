import 'package:flutter/material.dart';
import 'package:structure_example/models/arguments_model/arg_news.dart';
import 'package:structure_example/models/response_model/list_news_res.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/texts_stype.dart';
import 'package:structure_example/utils/convert_date.dart';

class ItemNewsVertical extends StatefulWidget {
  final NewsRes news;

  const ItemNewsVertical({Key key, this.news}) : super(key: key);
  @override
  _ItemProductHorizontalState createState() => _ItemProductHorizontalState();
}

class _ItemProductHorizontalState extends State<ItemNewsVertical> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/handbooknewsdetail", arguments: ArgNews(img: widget.news.img, title: widget.news.title, createdAt: widget.news.createdAt, sId: widget.news.sId));
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
                        widget.news.img,
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
                        widget.news.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextsStyle.title,
                      ),
                      SizedBox(height: 15),
                      Text(
                        ConvertDate(widget.news.createdAt).convertISOToDateTime(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextsStyle.subTitle,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // String convertDate(String date){
  //   return "abc";
  // }
}
