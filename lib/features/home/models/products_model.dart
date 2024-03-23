class ProductsModel {
  ProductsModel({
    required this.id,
    required this.errorDescription,
    required this.name,
    required this.sku,
    required this.image,
    required this.color,
  });

  final int? id;
  final String? errorDescription;
  final String? name;
  final String? sku;
  final String? image;
  final dynamic color;

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
