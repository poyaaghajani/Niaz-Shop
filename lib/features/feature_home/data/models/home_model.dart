class HomeModel {
  HomeModel({
    this.data,
  });

  HomeModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? data;
}

class Data {
  Data({
    this.sliders,
    this.banners,
    this.categories,
    this.suggestionProducts,
  });

  Data.fromJson(dynamic json) {
    if (json['sliders'] != null) {
      sliders = [];
      json['sliders'].forEach((slider) {
        sliders?.add(Sliders.fromJson(slider));
      });
    }

    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners?.add(Banners.fromJson(v));
      });
    }

    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((category) {
        categories?.add(Categories.fromJson(category));
      });
    }

    if (json['suggestionProducts'] != null) {
      suggestionProducts = [];
      json['suggestionProducts'].forEach((suggestionProduct) {
        suggestionProducts?.add(SuggestionProducts.fromJson(suggestionProduct));
      });
    }
  }

  List<Sliders>? sliders;
  List<Banners>? banners;
  List<Categories>? categories;
  List<SuggestionProducts>? suggestionProducts;
}

class Sliders {
  Sliders({
    this.img,
  });

  Sliders.fromJson(dynamic json) {
    img = json['img'];
  }

  String? img;
}

class Banners {
  Banners({
    this.image,
  });

  Banners.fromJson(dynamic json) {
    image = json['image'];
  }
  String? image;
}

class Categories {
  Categories({
    this.title,
    this.img,
    this.icon,
  });

  Categories.fromJson(dynamic json) {
    title = json['title'];
    img = json['img'];
    icon = json['icon'];
  }

  String? title;
  String? img;
  String? icon;
}

class SuggestionProducts {
  SuggestionProducts({
    this.items,
  });

  SuggestionProducts.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((item) {
        items?.add(Items.fromJson(item));
      });
    }
  }

  List<Items>? items;
}

class Items {
  Items({
    this.id,
    this.image,
    this.name,
    this.price,
    this.priceBeforDiscount,
    this.discount,
    this.specialDiscount,
    this.star,
    this.category,
  });

  Items.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    priceBeforDiscount = json['priceBeforDiscount'];
    discount = json['discount'];
    specialDiscount = json['specialDiscount'];
    star = json['star'];
    category = json['category'];
  }
  int? id;
  String? image;
  String? name;
  String? price;
  String? priceBeforDiscount;
  int? discount;
  int? specialDiscount;
  int? star;
  String? category;
}
