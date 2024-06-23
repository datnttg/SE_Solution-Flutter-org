class ProductFilterParameters {
  String? code;
  String? name;
  String? statusCode;
  List<String>? typeCodes;
  List<String>? categoryCodes;

  ProductFilterParameters({
    this.code,
    this.name,
    this.statusCode,
    this.typeCodes,
    this.categoryCodes,
  });

  factory ProductFilterParameters.fromJson(Map<String, dynamic> json) {
    return ProductFilterParameters(
      code: json['code'],
      name: json['name'],
      typeCodes: json['types'],
      categoryCodes: json['categoryCodes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'types': typeCodes,
      'categoryCodes': categoryCodes,
    };
  }
}
