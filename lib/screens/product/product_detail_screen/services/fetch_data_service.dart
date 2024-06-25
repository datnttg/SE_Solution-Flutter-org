import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/shared_preferences.dart';
import '../models/product_detail_model.dart';

var hostAddress = constants.hostAddress;

Future<ProductDetailModel> fetchProductDetail(String productId) async {
  var params = {"id": productId};
  var data = await fetchData(Uri.parse('$hostAddress/Product/Detail'),
      parameters: params);
  var detail = data['responseData']
      .map<ProductDetailModel>((e) => ProductDetailModel.fromJson(e));
  return detail;
}

Future<List<CDropdownMenuEntry>> fetchProductCategory(
    {String? categoryProperty}) async {
  var params = {"categoryProperty": categoryProperty};
  var data = await fetchData(Uri.parse('$hostAddress/Product/ListCategory'),
      parameters: params);
  var listEntries = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['code'],
            labelText: e[sharedPrefs.getLocale().languageCode],
          ))
      .toList();
  return listEntries;
}

Future postProductDetail(ProductDetailModel params) async {
  var response = await fetchDataUI(Uri.parse('$hostAddress/Product/Update'),
      parameters: params.toMap());
  if (response['success'] == true) {
    kShowToast(
      title: sharedPrefs.translate('Success'),
      content: response['responseMessage'],
      style: 'success',
    );
  }
}
