// ignore: file_names
class ServiceModel {
  String? id;
  String? title;
  String? category;
  String? image;
  String? price;
  String? description;

  ServiceModel(
      {this.id,
      this.title,
      this.category,
      this.description,
      this.image,
      this.price});

  ServiceModel.fromJson(map) {
    if (map == null) return;
    id = map['id'];
    title = map['title'];
    image = map['image'];
    price = map['price'];
    category = map['category'];
    description = map['Description'];
  }

  // Function To convert data To json
  toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'category': category,
      'Description': description
    };
  }
}
