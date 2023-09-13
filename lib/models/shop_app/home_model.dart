class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersData> banners = [];
  List<ProductsData> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersData.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsData.fromJson(element));
    });
  }
}

class BannersData {
  late int id;
  late String image;

  BannersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsData {
  late int id;
  dynamic price = 0;
  dynamic oldPrice = 0;
  dynamic discount = 0;
  String image = '';
  String name = '';
  late bool inFavorites;
  late bool inCart;

  ProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
