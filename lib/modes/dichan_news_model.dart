import 'dart:convert';

// import 'package:leancloud_storage/leancloud.dart';

class DiChanNewsModel {
  String? sType;
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? content;
  String? source;
  String? title;
  String? author;
  String? createTime;
  String? url;
  List<String>? imgs;
  List<ContentModel> contentModels = [];
  String desc = "";

  DiChanNewsModel(
      {this.sType,
      this.className,
      this.objectId,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.source,
      this.title,
      this.author,
      this.createTime,
      this.url,
      this.imgs});

  // DiChanNewsModel.fromJson(LCObject json) {
  //   sType = json['__type'];
  //   className = json['className'];
  //   objectId = json['objectId'];
  //   createdAt = json['createdAt'];
  //   updatedAt = json['updatedAt'];
  //   content = json['content'];
  //   source = json['source'];
  //   title = json['title'];
  //   author = json['author'];
  //   createTime = json['create_time'];
  //   url = json['url'];
  //
  //   if (json["images"] != null) {
  //     imgs = json["images"].toString().split(",");
  //   } else {
  //     imgs = ["https://s2.loli.net/2022/08/24/jGxSI4897mA5NHi.jpg"];
  //   }
  //
  //   if (content != null) {
  //     var list = jsonDecode(content!) as List;
  //     List<ContentModel> models = [];
  //     for (var element in list) {
  //       var model = ContentModel.fromJson(element);
  //       models.add(model);
  //       if (desc.isEmpty && model.type == "text") {
  //         desc = (model.value ?? "").trim();
  //       }
  //     }
  //     contentModels = models;
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__type'] = sType;
    data['className'] = className;
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['content'] = content;
    data['source'] = source;
    data['title'] = title;
    data['author'] = author;
    data['create_time'] = createTime;
    data['url'] = url;
    return data;
  }
}

class ContentModel {
  String? link;
  String? type;
  String? value;

  ContentModel({this.link, this.type, this.value});

  ContentModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
