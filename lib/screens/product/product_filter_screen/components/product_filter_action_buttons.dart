import 'package:flutter/material.dart';
import 'package:se_solution/utilities/responsive.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../product_detail_screen/bloc/product_detail_bloc.dart';
import '../../product_detail_screen/bloc/product_detail_events.dart';
import '../../product_detail_screen/bloc/product_detail_states.dart';
import '../bloc/product_filter_bloc.dart';
import '../bloc/product_filter_events.dart';

class AddProductFilterButton extends StatelessWidget {
  const AddProductFilterButton(
      {super.key, required this.blocFilter, required this.blocDetail});
  final ProductFilterBloc blocFilter;
  final ProductDetailBloc blocDetail;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isSmallWidth(context)) {
      return Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: CElevatedButton(
            labelText: sharedPrefs.translate('Add'),
            onPressed: () async {
              blocFilter.eventController
                  .add(ChangeSelectedProduct(productId: ''));
              blocDetail.uiController
                  .add(ScreenModeState(state: ScreenModeEnum.edit));
            },
          ));
    } else {
      return const SizedBox();
    }
  }
}

class SaveProductFilterButton extends StatelessWidget {
  const SaveProductFilterButton(
      {super.key, required this.blocFilter, required this.blocDetail});
  final ProductFilterBloc blocFilter;
  final ProductDetailBloc blocDetail;

  @override
  Widget build(BuildContext context) {
    if (blocDetail.screenMode.state == ScreenModeEnum.edit) {
      return Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: CElevatedButton(
            labelText: sharedPrefs.translate('Save'),
            onPressed: () async {
              blocDetail.eventController.add(SubmitData());
              blocFilter.eventController
                  .add(ChangeSelectedProduct(productId: null));
            },
          ));
    } else {
      return const SizedBox();
    }
  }
}

class UpdateProductFilterButton extends StatelessWidget {
  const UpdateProductFilterButton(
      {super.key, required this.blocFilter, required this.blocDetail});
  final ProductFilterBloc blocFilter;
  final ProductDetailBloc blocDetail;

  @override
  Widget build(BuildContext context) {
    if (blocDetail.screenMode.state == ScreenModeEnum.view) {
      return Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: CElevatedButton(
            labelText: sharedPrefs.translate('Update'),
            onPressed: () {
              blocDetail.eventController
                  .add(ChangeScreenMode(ScreenModeEnum.edit));
            },
          ));
    } else {
      return const SizedBox();
    }
  }
}

class BackToProductFilterButton extends StatelessWidget {
  const BackToProductFilterButton({super.key, required this.bloc});
  final ProductFilterBloc bloc;

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
              bloc.eventController.add(ChangeSelectedProduct(productId: null));
            }
          },
        ));
  }
}
