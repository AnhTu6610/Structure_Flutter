import 'package:flutter/material.dart';
import 'package:structure_example/models/arguments_model/arg_news.dart';
import 'package:structure_example/models/response_model/list_news_hightlight_res.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/texts_stype.dart';
import 'package:structure_example/utils/convert_date.dart';

class ItemNewsHorizontal extends StatefulWidget {
  final NewsHightLightRes hightLightRes;

  const ItemNewsHorizontal({Key key, this.hightLightRes}) : super(key: key);
  @override
  _ItemProductVertiaclState createState() => _ItemProductVertiaclState();
}

class _ItemProductVertiaclState extends State<ItemNewsHorizontal> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/handbooknewsdetail",
            arguments: ArgNews(img: widget.hightLightRes.img, title: widget.hightLightRes.title, createdAt: widget.hightLightRes.createdAt, sId: widget.hightLightRes.sId));
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
                  height: constraints.constrainHeight(),
                  decoration:
                      BoxDecoration(color: Color(0xFFEDFCC7), borderRadius: BorderRadius.circular(15), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.hightLightRes.img))),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [ColorsData.primary.withOpacity(0.7), ColorsData.primary.withOpacity(0.1)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.hightLightRes.title,
                              style: TextStyle(height: 1.5, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              ConvertDate(widget.hightLightRes.createdAt).convertISOToDateTime(),
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.white54,
                                // fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
