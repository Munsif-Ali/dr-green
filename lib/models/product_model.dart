class ProductModel {
  String? prodId;
  String? prodName;
  String? prodImage;
  String? prodDescription;
  String? prodCategory;
  int? prodPrice;
  List<String>? likes;

  ProductModel({
    this.prodId,
    this.prodCategory,
    this.prodDescription,
    this.prodImage,
    this.prodName,
    this.prodPrice,
    this.likes,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    prodId = json["id"];
    prodName = json["prod_name"];
    prodImage = json["prod_image"];
    prodDescription = json["prod_description"];
    prodCategory = json["prod_category"];
    prodPrice = json["prod_price"];
    if (json["likes"] != null) {
      likes = json["likes"].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = prodId;
    data["prod_name"] = prodName;
    data["prod_image"] = prodImage;
    data["prod_description"] = prodDescription;
    data["prod_category"] = prodCategory;
    data["prod_price"] = prodPrice;
    data["likes"] = likes;
    return data;
  }
}
