class ContractCreateModel {
  final String? id;
  final String? contractType;
  final String? contractCategory;
  final String? contractCode;
  final String? contractStatusCode;
  final String? subjectName;
  final String? subjectDocumentType;
  final String? subjectDocumentCode;
  final String? subjectDocumentIssuePlace;
  final String? subjectTaxCode;
  final String? subjectAddress;
  final String? subjectId;
  final String? phoneNumber;
  final String? email;
  final String? subjectBankAccount;
  final String? subjectBankName;
  final String? representativeName;
  final String? representativePosition;
  final String? representativeDocumentType;
  final String? representativeDocumentCode;
  final String? representativeAddress;
  final String? representativeDocumentIssuePlace;
  final DateTime? signedDate;
  final DateTime? effectiveDate;
  final DateTime? endDate;
  final DateTime? liquidatedDate;
  final String? contractTemplateId;
  final String? managerUserId;
  final String? note;
  final List<AnnexCreateModel>? annexes;

  ContractCreateModel({
    this.id,
    this.contractType,
    this.contractCategory,
    this.contractCode,
    this.contractStatusCode,
    this.subjectName,
    this.subjectDocumentType,
    this.subjectDocumentCode,
    this.subjectDocumentIssuePlace,
    this.subjectTaxCode,
    this.subjectAddress,
    this.subjectId,
    this.phoneNumber,
    this.email,
    this.subjectBankAccount,
    this.subjectBankName,
    this.representativeName,
    this.representativePosition,
    this.representativeDocumentType,
    this.representativeDocumentCode,
    this.representativeAddress,
    this.representativeDocumentIssuePlace,
    this.signedDate,
    this.effectiveDate,
    this.endDate,
    this.liquidatedDate,
    this.contractTemplateId,
    this.managerUserId,
    this.note,
    this.annexes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contractType': contractType,
      'contractCategory': contractCategory,
      'contractCode': contractCode,
      'contractStatusCode': contractStatusCode,
      'subjectName': subjectName,
      'subjectDocumentType': subjectDocumentType,
      'subjectDocumentCode': subjectDocumentCode,
      'subjectDocumentIssuePlace': subjectDocumentIssuePlace,
      'subjectTaxCode': subjectTaxCode,
      'subjectAddress': subjectAddress,
      'subjectId': subjectId,
      'phoneNumber': phoneNumber,
      'email': email,
      'subjectBankAccount': subjectBankAccount,
      'subjectBankName': subjectBankName,
      'representativeName': representativeName,
      'representativePosition': representativePosition,
      'representativeDocumentType': representativeDocumentType,
      'representativeDocumentCode': representativeDocumentCode,
      'representativeAddress': representativeAddress,
      'representativeDocumentIssuePlace': representativeDocumentIssuePlace,
      'signedDate': signedDate?.toIso8601String(),
      'effectiveDate': effectiveDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'liquidatedDate': liquidatedDate?.toIso8601String(),
      'contractTemplateId': contractTemplateId,
      'managerUserId': managerUserId,
      'note': note,
      'annexes': annexes?.map((x) => x.toMap()).toList(),
    };
  }

  factory ContractCreateModel.fromJson(Map<String, dynamic> json) {
    return ContractCreateModel(
      id: json['id'],
      contractType: json['contractType'],
      contractCategory: json['contractCategory'],
      contractCode: json['contractCode'],
      contractStatusCode: json['contractStatusCode'],
      subjectName: json['subjectName'],
      subjectDocumentType: json['subjectDocumentType'],
      subjectDocumentCode: json['subjectDocumentCode'],
      subjectDocumentIssuePlace: json['subjectDocumentIssuePlace'],
      subjectTaxCode: json['subjectTaxCode'],
      subjectAddress: json['subjectAddress'],
      subjectId: json['subjectId'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      subjectBankAccount: json['subjectBankAccount'],
      subjectBankName: json['subjectBankName'],
      representativeName: json['representativeName'],
      representativePosition: json['representativePosition'],
      representativeDocumentType: json['representativeDocumentType'],
      representativeDocumentCode: json['representativeDocumentCode'],
      representativeAddress: json['representativeAddress'],
      representativeDocumentIssuePlace:
          json['representativeDocumentIssuePlace'],
      signedDate: json['signedDate'] != null
          ? DateTime.parse(json['signedDate'])
          : null,
      effectiveDate: json['effectiveDate'] != null
          ? DateTime.parse(json['effectiveDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      liquidatedDate: json['liquidatedDate'] != null
          ? DateTime.parse(json['liquidatedDate'])
          : null,
      contractTemplateId: json['contractTemplateId'],
      managerUserId: json['managerUserId'],
      note: json['note'],
      annexes: json['annexes'] != null
          ? List<AnnexCreateModel>.from(
              json['annexes'].map((x) => AnnexCreateModel.fromJson(x)))
          : null,
    );
  }
}

class AnnexCreateModel {
  final String? annexType;
  final String? annexCategory;
  final String? statusCode;
  final String? annexCode;
  final DateTime? signedDate;
  final DateTime? effectiveDate;
  final DateTime? endDate;
  final DateTime? liquidatedDate;
  final String? annexTemplateId;
  final String? contractId;
  final String? referenceContractId;
  final String? parentId;
  final String? countryCode;
  final String? addressLevel1;
  final String? addressLevel2;
  final String? addressLevel3;
  final String? addressDetail;
  final String? addressFull;
  final String? contactName;
  final String? contactPhone;
  final String? note;
  final List<ProductCreateModel>? products;

  AnnexCreateModel({
    this.annexType,
    this.annexCategory,
    this.statusCode,
    this.annexCode,
    this.signedDate,
    this.effectiveDate,
    this.endDate,
    this.liquidatedDate,
    this.annexTemplateId,
    this.contractId,
    this.referenceContractId,
    this.parentId,
    this.countryCode,
    this.addressLevel1,
    this.addressLevel2,
    this.addressLevel3,
    this.addressDetail,
    this.addressFull,
    this.contactName,
    this.contactPhone,
    this.note,
    this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'annexType': annexType,
      'annexCategory': annexCategory,
      'statusCode': statusCode,
      'annexCode': annexCode,
      'signedDate': signedDate?.toIso8601String(),
      'effectiveDate': effectiveDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'liquidatedDate': liquidatedDate?.toIso8601String(),
      'annexTemplateId': annexTemplateId,
      'contractId': contractId,
      'referenceContractId': referenceContractId,
      'parentId': parentId,
      'countryCode': countryCode,
      'addressLevel1': addressLevel1,
      'addressLevel2': addressLevel2,
      'addressLevel3': addressLevel3,
      'addressDetail': addressDetail,
      'addressFull': addressFull,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'note': note,
      'products': products?.map((x) => x.toMap()).toList(),
    };
  }

  factory AnnexCreateModel.fromJson(Map<String, dynamic> json) {
    return AnnexCreateModel(
      annexType: json['annexType'],
      annexCategory: json['annexCategory'],
      statusCode: json['statusCode'],
      annexCode: json['annexCode'],
      signedDate: json['signedDate'] != null
          ? DateTime.parse(json['signedDate'])
          : null,
      effectiveDate: json['effectiveDate'] != null
          ? DateTime.parse(json['effectiveDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      liquidatedDate: json['liquidatedDate'] != null
          ? DateTime.parse(json['liquidatedDate'])
          : null,
      annexTemplateId: json['annexTemplateId'],
      contractId: json['contractId'],
      referenceContractId: json['referenceContractId'],
      parentId: json['parentId'],
      countryCode: json['countryCode'],
      addressLevel1: json['addressLevel1'],
      addressLevel2: json['addressLevel2'],
      addressLevel3: json['addressLevel3'],
      addressDetail: json['addressDetail'],
      addressFull: json['addressFull'],
      contactName: json['contactName'],
      contactPhone: json['contactPhone'],
      note: json['note'],
      products: json['products'] != null
          ? List<ProductCreateModel>.from(
              json['products'].map((x) => ProductCreateModel.fromJson(x)))
          : null,
    );
  }
}

class ProductCreateModel {
  final String? annexId;
  final String? parentId;
  final String? note;
  final String? productId;
  final String? unitCode;
  final int? quantity;
  final double? taxPercent;
  final double? unitPrice;
  final double? amountBeforeTax;
  final double? taxAmount;
  final double? amountAfterTax;
  final double? nominalValue;
  final double? depositAmount;
  final int? monthsOfPayment;
  final int? monthsOfPrepaid;
  final double? electricityPrice;
  final double? tariffAddedAmount;

  ProductCreateModel({
    this.annexId,
    this.parentId,
    this.note,
    this.productId,
    this.unitCode,
    this.quantity,
    this.taxPercent,
    this.unitPrice,
    this.amountBeforeTax,
    this.taxAmount,
    this.amountAfterTax,
    this.nominalValue,
    this.depositAmount,
    this.monthsOfPayment,
    this.monthsOfPrepaid,
    this.electricityPrice,
    this.tariffAddedAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'annexId': annexId,
      'parentId': parentId,
      'note': note,
      'productId': productId,
      'unitCode': unitCode,
      'quantity': quantity,
      'taxPercent': taxPercent,
      'unitPrice': unitPrice,
      'amountBeforeTax': amountBeforeTax,
      'taxAmount': taxAmount,
      'amountAfterTax': amountAfterTax,
      'nominalValue': nominalValue,
      'depositAmount': depositAmount,
      'monthsOfPayment': monthsOfPayment,
      'monthsOfPrepaid': monthsOfPrepaid,
      'electricityPrice': electricityPrice,
      'tariffAddedAmount': tariffAddedAmount,
    };
  }

  factory ProductCreateModel.fromJson(Map<String, dynamic> json) {
    return ProductCreateModel(
      annexId: json['annexId'],
      parentId: json['parentId'],
      note: json['note'],
      productId: json['productId'],
      unitCode: json['unitCode'],
      quantity: json['quantity'],
      taxPercent: json['taxPercent']?.toDouble(),
      unitPrice: json['unitPrice']?.toDouble(),
      amountBeforeTax: json['amountBeforeTax']?.toDouble(),
      taxAmount: json['taxAmount']?.toDouble(),
      amountAfterTax: json['amountAfterTax']?.toDouble(),
      nominalValue: json['nominalValue']?.toDouble(),
      depositAmount: json['depositAmount']?.toDouble(),
      monthsOfPayment: json['monthsOfPayment'],
      monthsOfPrepaid: json['monthsOfPrepaid'],
      electricityPrice: json['electricityPrice']?.toDouble(),
      tariffAddedAmount: json['tariffAddedAmount']?.toDouble(),
    );
  }
}
