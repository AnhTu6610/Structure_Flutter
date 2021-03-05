import 'dart:convert';

import 'package:flutter/services.dart';

class AddressOffline {
  int id;
  String name;

  AddressOffline();
}

class LocationOffline {
  Future<List<City>> getCitys() async {
    String strJson = await rootBundle.loadString("assets/config/location.json", cache: true);
    List<dynamic> json = jsonDecode(strJson) as List;
    List<City> listCity = [];
    json.forEach((element) {
      listCity.add(City.fromJson(element));
    });
    return listCity;
  }
}

class City {
  int id;
  String name;
  List<District> huyen;

  City({this.id, this.name, this.huyen});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['huyen'] != null) {
      huyen = new List<District>();
      json['huyen'].forEach((v) {
        huyen.add(new District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.huyen != null) {
      data['huyen'] = this.huyen.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  int id;
  String name;
  List<Ward> xa;

  District({this.id, this.name, this.xa});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['xa'] != null) {
      xa = new List<Ward>();
      json['xa'].forEach((v) {
        xa.add(new Ward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.xa != null) {
      data['xa'] = this.xa.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ward {
  int id;
  String name;
  int huyenId;

  Ward({this.id, this.name, this.huyenId});

  Ward.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    huyenId = json['huyen_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['huyen_id'] = this.huyenId;
    return data;
  }
}
