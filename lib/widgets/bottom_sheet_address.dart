import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:structure_example/data_source/local_data/location_offline.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/fonts_name.dart';
import 'package:structure_example/resource/fonts_size.dart';

enum OptionLocationOffline { CITY, DISTRICT, WARD }

class BottomSheetAddress extends StatefulWidget {
  final List<City> citys;
  final OptionLocationOffline optionLocation;
  final int idCity;
  final int idDistrict;
  final int idWard;
  const BottomSheetAddress({Key key, this.citys, this.optionLocation, this.idCity, this.idDistrict, this.idWard}) : super(key: key);
  @override
  _BottomSheetAddressState createState() => _BottomSheetAddressState();
}

class _BottomSheetAddressState extends State<BottomSheetAddress> {
  List<AddressOffline> addressOffline = [];
  AddressOffline activeAddress;
  @override
  void initState() {
    super.initState();
    switch (widget.optionLocation) {
      case OptionLocationOffline.CITY:
        widget.citys.forEach((element) {
          addressOffline.add(new AddressOffline()
            ..id = element.id
            ..name = element.name);
        });
        if (widget.idCity != null) activeAddress = addressOffline.firstWhere((element) => element.id == widget.idCity);
        break;
      case OptionLocationOffline.DISTRICT:
        City city = widget.citys.firstWhere((element) {
          return element.id == widget.idCity;
        });
        city.huyen.forEach((element) {
          addressOffline.add(new AddressOffline()
            ..id = element.id
            ..name = element.name);
        });
        if (widget.idDistrict != null) activeAddress = addressOffline.firstWhere((element) => element.id == widget.idDistrict);
        break;
      default:
        City city = widget.citys.firstWhere((element) {
          return element.id == widget.idCity;
        });
        District district = city.huyen.firstWhere((element) => element.id == widget.idDistrict);
        district.xa.forEach((element) {
          addressOffline.add(new AddressOffline()
            ..id = element.id
            ..name = element.name);
        });
        if (widget.idWard != null) activeAddress = addressOffline.firstWhere((element) => element.id == widget.idWard);
    }
    if (activeAddress == null) activeAddress = addressOffline[0];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: addressOffline
          .map(
            (value) => CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  activeAddress = value;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    value.name,
                    style: TextStyle(
                      color: value.id == activeAddress.id ? ColorsData.primary : Colors.black,
                      fontFamily: FontsName.medium,
                    ),
                  ),
                  Visibility(
                    visible: value.id == activeAddress.id ? true : false,
                    child: Icon(
                      Icons.check,
                      color: ColorsData.primary,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      cancelButton: FlatButton(
        onPressed: () {
          Navigator.pop(context, activeAddress);
        },
        child: Text(
          "Tiếp tục",
          style: TextStyle(
            fontFamily: FontsName.medium,
            fontSize: FontsSize.buttom,
          ),
        ),
        textColor: ColorsData.primary,
      ),
    );
  }
}
