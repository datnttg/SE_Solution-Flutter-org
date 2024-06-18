import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/shared_preferences.dart';
import '../bloc/product_detail_states.dart';

var hostAddress = constants.hostAddress;

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

Future postProductDetail(ProductDetailState params) async {
  var response =
      await fetchDataUI(Uri.parse(hostAddress), parameters: params.toMap());
  if (response['success'] == true) {
    kShowToast(
      title: sharedPrefs.translate('Success'),
      content: response['responseMessage'],
      style: 'success',
    );
  }
}
