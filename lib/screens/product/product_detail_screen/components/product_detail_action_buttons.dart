import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../product_filter_screen/bloc/product_filter_bloc.dart';
import '../../product_filter_screen/bloc/product_filter_events.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';
import '../bloc/product_detail_states.dart';
import '../services/fetch_data_service.dart';

class AddProductFilterButton extends StatelessWidget {
  const AddProductFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Add'),
              onPressed: () async {
                if (Responsive.isSmallWidth(context)) {
                  Navigator.of(context)
                      .pushNamed(customRouteMapping.productAdd);
                } else {
                  context
                      .read<ProductFilterBloc>()
                      .add(SelectedFilterProductChanged(''));
                  context.read<ProductDetailBloc>().add(ProductIdChanged(''));
                }
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class AddProductFilterFloatingButton extends StatelessWidget {
  const AddProductFilterFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: FloatingActionButton(
              tooltip: sharedPref.translate('Add'),
              backgroundColor: cButtonTextHoverColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: cButtonBorderColor, width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () async {
                if (Responsive.isSmallWidth(context)) {
                  Navigator.of(context)
                      .pushNamed(customRouteMapping.productAdd);
                } else {
                  context
                      .read<ProductFilterBloc>()
                      .add(SelectedFilterProductChanged(''));
                  context.read<ProductDetailBloc>().add(ProductIdChanged(''));
                }
              },
              child: const Icon(Icons.add, color: kBgColorHeader, size: 30),
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

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
              labelText: sharedPref.translate('Save'),
              onPressed: () async {
                context.read<ProductDetailBloc>().add(ProductSaving());
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class EditProductButton extends StatelessWidget {
  const EditProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view &&
          state.productDetail.id != null) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Edit'),
              onPressed: () {
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
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.edit) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Discard'),
              onPressed: () {
                context
                    .read<ProductDetailBloc>()
                    .add(ChangeScreenMode(ScreenModeEnum.view));
                var productId = state.productDetail.id;
                if (Responsive.isSmallWidth(context)) {
                  if (productId == null) {
                    Navigator.pop(context);
                  } else {
                    context
                        .read<ProductDetailBloc>()
                        .add(ProductIdChanged(productId));
                  }
                } else {
                  var selectedId =
                      context.read<ProductFilterBloc>().getSelectedId();
                  if (selectedId == '') {
                    context
                        .read<ProductFilterBloc>()
                        .add(SelectedFilterProductChanged(null));
                  } else {
                    context
                        .read<ProductDetailBloc>()
                        .add(ProductIdChanged(productId));
                  }
                }
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class BackProductButton extends StatelessWidget {
  const BackProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}
