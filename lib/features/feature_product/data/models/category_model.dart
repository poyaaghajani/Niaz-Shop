class CategoryModel {
  CategoryModel({
    this.data,
  });

  CategoryModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? data;
}

class Data {
  Data({
    this.id,
    this.title,
    this.img,
    this.icon,
    this.childs,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    icon = json['icon'];
    if (json['childs'] != null) {
      childs = [];
      json['childs'].forEach((v) {
        childs?.add(Childs.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  String? img;
  String? icon;
  List<Childs>? childs;
}

class Childs {
  Childs({
    this.title,
    this.img,
    this.childs,
  });

  Childs.fromJson(dynamic json) {
    title = json['title'];
    img = json['img'];
    childs = json['childs'];
  }

  String? title;
  String? img;
  dynamic childs;
}
