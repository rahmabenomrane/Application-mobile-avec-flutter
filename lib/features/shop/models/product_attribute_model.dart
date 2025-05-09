class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  /// Json Format
  toJson() {
    return {'Name': name, 'Values': values};
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: document.containsKey('Name') ? document['Name'] : '',
      values: List<String>.from(document['Values']),
    );
  }
}