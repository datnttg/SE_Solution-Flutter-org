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

  ProductFilterParameters copyWith({
    String? code,
    String? name,
    String? statusCode,
    List<String>? typeCodes,
    List<String>? categoryCodes,
  }) {
    return ProductFilterParameters(
      code: code ?? this.code,
      name: name ?? this.name,
      statusCode: statusCode ?? this.statusCode,
      typeCodes: typeCodes ?? this.typeCodes,
      categoryCodes: categoryCodes ?? this.categoryCodes,
    );
  }

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
