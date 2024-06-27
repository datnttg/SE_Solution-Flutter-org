import 'package:flutter/material.dart';

import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../product_detail_screen/bloc/product_detail_bloc.dart';
import '../../product_detail_screen/bloc/product_detail_events.dart';
import '../bloc/product_filter_bloc.dart';
import '../bloc/product_filter_events.dart';

class AddProductFilterButton extends StatelessWidget {
  const AddProductFilterButton({super.key, required this.blocFilter});
  final ProductFilterBloc blocFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: CElevatedButton(
          labelText: sharedPrefs.translate('Add'),
          onPressed: () async {
            if (Responsive.isSmallWidth(context)) {
              final isReload = await Navigator.pushNamed(
                  context, customRouteMapping.productAdd);
              if (isReload == true) {
                blocFilter.loadData();
              }
            } else {
              blocFilter.eventController
                  .add(ChangeSelectedProduct(productId: ''));
            }
          },
        ));
  }
}

class SaveProductFilterButton extends StatelessWidget {
  const SaveProductFilterButton(
      {super.key, required this.blocFilter, required this.blocDetail});
  final ProductFilterBloc blocFilter;
  final ProductDetailBloc blocDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: CElevatedButton(
          labelText: sharedPrefs.translate('Save'),
          onPressed: () {
            blocDetail.eventController.add(SubmitData());
            blocFilter.eventController
                .add(ChangeSelectedProduct(productId: null));
          },
        ));
  }
}

class UpdateProductFilterButton extends StatelessWidget {
  const UpdateProductFilterButton({super.key, required this.blocDetail});
  final ProductDetailBloc blocDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: CElevatedButton(
          labelText: sharedPrefs.translate('Update'),
          onPressed: () {
            blocDetail.eventController
                .add(ChangeScreenMode(ScreenModeEnum.edit));
          },
        ));
  }
}

class BackToProductFilterButton extends StatelessWidget {
  const BackToProductFilterButton(
      {super.key, required this.blocFilter, required this.blocDetail});
  final ProductFilterBloc blocFilter;
  final ProductDetailBloc blocDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: CElevatedButton(
          labelText: sharedPrefs.translate('Discard'),
          onPressed: () {
            if (Responsive.isSmallWidth(context)) {
              Navigator.pop(context);
            } else {
              blocDetail.eventController
                  .add(ChangeScreenMode(ScreenModeEnum.view));
              blocFilter.eventController
                  .add(ChangeSelectedProduct(productId: null));
            }
            // blocDetail.eventController
            //     .add(ChangeScreenMode(ScreenModeEnum.view));
          },
        ));
  }
}
