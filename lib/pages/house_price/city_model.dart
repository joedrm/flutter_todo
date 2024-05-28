import 'package:flutter/cupertino.dart';

class CityModel {
  String name = "";
  String code = "";

  CityModel(this.name, this.code);

  CityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }
}
