class DataItemModel {
  String? title;
  String? desc;
  String? icon;
  String? readCount;
  String? createTime;

  DataItemModel({title, desc, icon, readCount, createTime});

  DataItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    icon = json['icon'];
    readCount = json['readCount'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['icon'] = icon;
    data['readCount'] = readCount;
    data['createTime'] = createTime;
    return data;
  }
}