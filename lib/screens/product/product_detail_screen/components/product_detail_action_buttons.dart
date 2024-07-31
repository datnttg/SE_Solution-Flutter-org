import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution/screens/product/product_detail_screen/bloc/product_detail_states.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';

class SaveProductButton extends StatelessWidget {
  const SaveProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.edit) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPrefs.translate('Save'),
              onPressed: () async {},
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class UpdateProductButton extends StatelessWidget {
  const UpdateProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPrefs.translate('Update'),
              onPressed: () {
                // bloc.eventController.add(ChangeScreenMode(ScreenModeEnum.edit));
                context
                    .read<ProductDetailBloc>()
                    .add(ChangeScreenMode(ScreenModeEnum.edit));
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class DiscardProductButton extends StatelessWidget {
  const DiscardProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: CElevatedButton(
          labelText: sharedPrefs.translate('Discard'),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
