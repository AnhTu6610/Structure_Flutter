import 'package:flutter/material.dart';
import 'package:structure_example/resource/images_data.dart';
import 'package:structure_example/resource/texts_stype.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  @required
  final double height;
  final String title;
  final Widget leading;
  final bool titleCenter;
  final List<Widget> actions;

  const CommonAppbar({Key key, this.height, this.title, this.leading, this.titleCenter = false, this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(ImagesData.img_common_appbar, fit: BoxFit.fill),
        ),
        Row(
          children: [
            leading != null
                ? leading
                : IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.navigate_before),
                    color: Colors.white,
                    iconSize: 30,
                  ),
            Expanded(
              child: Text(
                "$title",
                style: TextsStyle.titleAppBar,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: titleCenter ? TextAlign.center : TextAlign.left,
              ),
            ),
            actions == null
                ? SizedBox(width: 56)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(actions.length, (index) => actions[index]),
                  ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
