class DataItem {
  double data = 0.0;
  String zb = "";
  String reg= "";
  String sj= "";
  String code= "";
  int sort = 0;

  DataItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data']['data'];
    zb = json['wds'][0]['valuecode'];
    reg = json['wds'][1]['valuecode'];
    sj = json['wds'][2]['valuecode'];
  }
}