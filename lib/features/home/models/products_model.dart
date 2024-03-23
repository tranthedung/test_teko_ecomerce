import 'package:get/get.dart';

class ProductsModel {
  ProductsModel({
    this.id,
    this.errorDescription,
    this.name,
    this.sku,
    this.image,
    this.color,
    this.productColor,
  });

  int? id;
  String? errorDescription;
  String? name;
  String? sku;
  String? image;
  int? color;
  String? productColor;

  final RxBool isEdited = false.obs;

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json["id"],
      errorDescription: json["errorDescription"],
      name: json["name"],
      sku: json["sku"],
      image: json["image"],
      color: json["color"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "errorDescription": errorDescription,
        "name": name,
        "sku": sku,
        "image": image,
        "color": color,
      };
}
