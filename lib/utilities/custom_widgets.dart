import 'dart:math';

import 'package:dropdown_plus_plus/dropdown_plus_plus.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'classes/custom_widget_models.dart';
import 'shared_preferences.dart';
import 'ui_styles.dart';

/// CUSTOM SCAFFOLD
class CScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body, drawer, bottomNavigationBar;

  const CScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.drawer,
      this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(mediumTextSize * 3.5),
              child: appBar!,
            ),
      drawer: drawer,
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.blue.shade200, // Set your desired background color
        ),
        child: body ?? Container(),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class KScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body, drawer, bottomNavigationBar;

  const KScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.drawer,
      this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(mediumTextSize * 3.5),
              child: appBar!,
            ),
      drawer: drawer,
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.blue.shade200, // Set your desired background color
        ),
        child: body ?? Container(),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// CUSTOM DROPDOWN MENU
class CDropdownMenu extends StatelessWidget {
  final String? labelText;
  final List<CDropdownMenuEntry> dropdownMenuEntries;
  final List<CDropdownMenuEntry>? selectedMenuEntries;
  final List<CDropdownMenuEntry>? disabledMenuEntries;
  final bool? multiSelect,
      wrap,
      enabled,
      readOnly,
      enableSearch,
      required,
      showDivider,
      showClearIcon,
      labelTextAsHint;
  final MultiSelectController<dynamic>? controller;
  final String? hintText;
  final double? width, menuHeight;
  final Function(List<CDropdownMenuEntry<dynamic>>)? onSelected;

  const CDropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    this.selectedMenuEntries,
    this.disabledMenuEntries,
    this.labelText,
    this.labelTextAsHint = false,
    this.controller,
    this.onSelected,
    this.hintText,
    this.multiSelect = false,
    this.wrap,
    this.enabled = true,
    this.readOnly = false,
    this.enableSearch = false,
    this.required = false,
    this.showDivider = true,
    this.showClearIcon = false,
    this.width,
    this.menuHeight = 240,
  });

  List<ValueItem> convertToValueItem(List<CDropdownMenuEntry>? values) {
    if (values?.isEmpty ?? true) return [];
    return values!
        .map<ValueItem>(
            (e) => ValueItem(label: e.labelText ?? '', value: e.value))
        .toList();
  }

  void newOnSelected(List<ValueItem<dynamic>> entries) {
    final List<CDropdownMenuEntry<dynamic>> valueItems = entries
        .map((e) =>
            CDropdownMenuEntry<dynamic>(value: e.value, labelText: e.label))
        .toList();
    onSelected?.call(valueItems);
  }

  @override
  Widget build(BuildContext context) {
    var dropdownEntries = convertToValueItem(dropdownMenuEntries);
    var selectedEntries = convertToValueItem(selectedMenuEntries);
    var disabledEntries = convertToValueItem(disabledMenuEntries);

    var requireSign = required == true
        ? const Text(
            '*',
            style: TextStyle(color: Colors.red),
          )
        : const SizedBox();
    var newHintText = hintText;
    if (newHintText == null && multiSelect == false) {
      newHintText = sharedPrefs.translate('Choose one');
    } else if (newHintText == null && multiSelect == true) {
      newHintText = sharedPrefs.translate('Choose many');
    }

    var newMenuHeight = min(dropdownMenuEntries.length * 50, 240).toDouble();
    if (readOnly == true) {
      newMenuHeight = 0;
    }

    var dropdownMenu = MultiSelectDropDown(
      dropdownMargin: 1,
      animateSuffixIcon: newMenuHeight == 0 ? false : true,
      clearIcon: showClearIcon == true
          ? const Icon(Icons.close_outlined, size: 20)
          : null,
      options: dropdownEntries,
      selectedOptions: selectedEntries,
      disabledOptions: disabledEntries,
      dropdownHeight: newMenuHeight,
      chipConfig: ChipConfig(
          backgroundColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.black87),
          deleteIconColor: Colors.black54,
          deleteIcon: newMenuHeight == 0
              ? const Icon(Icons.close_outlined, size: 0)
              : null),
      onOptionSelected: newOnSelected,
      searchEnabled: enableSearch!,
      hint: newHintText ?? sharedPrefs.translate('Select'),
      searchLabel: sharedPrefs.translate('Search'),
      selectionType:
          multiSelect == true ? SelectionType.multi : SelectionType.single,
      inputDecoration: const BoxDecoration(),
      optionTextStyle: const TextStyle(fontSize: mediumTextSize),
      singleSelectItemStyle: const TextStyle(fontSize: mediumTextSize),
      hintStyle: const TextStyle(fontSize: mediumTextSize),
    );

    return Container(
      padding:
          const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
      decoration: showDivider == true
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: kBorderColor)))
          : null,
      child: wrap == true
          ? Column(children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  labelTextAsHint == true
                      ? const SizedBox()
                      : Text(
                          '$labelText',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .fontSize),
                        ),
                  labelTextAsHint == true ? const SizedBox() : requireSign,
                  labelTextAsHint == true
                      ? const SizedBox()
                      : const SizedBox(width: defaultPadding),
                ],
              ),
              dropdownMenu,
            ])
          : Row(
              children: [
                labelTextAsHint == true
                    ? const SizedBox()
                    : Text(
                        '$labelText',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize),
                      ),
                labelTextAsHint == true ? const SizedBox() : requireSign,
                labelTextAsHint == true
                    ? const SizedBox()
                    : const SizedBox(width: defaultPadding),
                Expanded(
                  child: dropdownMenu,
                )
              ],
            ),
    );
  }
}

class KDropdownMenu extends StatelessWidget {
  final Widget? label;
  final String? labelText;
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final dynamic initialSelection;
  final bool? enabled, enableFilter, required;
  final TextEditingController? controller;
  final String? hintText;
  final double? width, menuHeight;
  final Function(dynamic)? onSelected;

  const KDropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    this.label,
    this.labelText,
    this.initialSelection,
    this.controller,
    this.onSelected,
    this.hintText,
    this.enabled,
    this.enableFilter = false,
    this.required,
    this.width,
    this.menuHeight = 280,
  });

  @override
  Widget build(BuildContext context) {
    Widget? newLabel = label ?? (labelText == null ? null : Text(labelText!));
    if (labelText != null && label == null && required == true) {
      newLabel = Row(
        children: [
          Text(
            labelText!,
            style: const TextStyle(overflow: TextOverflow.clip),
          ),
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      );
    }
    if (label != null && required == true) {
      newLabel = Row(
        children: [
          label!,
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      );
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return DropdownMenu(
        width: constraints.maxWidth,
        controller: controller,
        enabled: enabled ?? true,
        label: newLabel,
        enableSearch: false,
        enableFilter: enableFilter!,
        hintText: hintText,
        dropdownMenuEntries: dropdownMenuEntries,
        initialSelection: initialSelection,
        onSelected: onSelected,
        menuHeight: menuHeight,
        inputDecorationTheme: const InputDecorationTheme(),
      );
    });
  }
}

/// CUSTOM DROPDOWN SEARCH
// class CDropdownSearch extends StatelessWidget {
//   final String? labelText;
//   final List<DropdownMenuEntry> dropdownMenuEntries;
//   final dynamic initialSelection;
//   final bool? enabled, required, autoFocus, addNew, showDivider;
//   final DropdownEditingController<Map<String, dynamic>>? controller;
//   final String? hintText;
//   final double? width, menuHeight;
//   final Function(dynamic)? onSelected;
//
//   const CDropdownSearch({
//     super.key,
//     required this.dropdownMenuEntries,
//     this.labelText,
//     this.initialSelection,
//     this.controller,
//     this.onSelected,
//     this.hintText,
//     this.autoFocus = false,
//     this.enabled = true,
//     this.required = false,
//     this.showDivider = true,
//     this.addNew = false,
//     this.width,
//     this.menuHeight = 280,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (enabled == false) {
//       return CDropdownMenu(
//         labelText: labelText,
//         dropdownMenuEntries: dropdownMenuEntries,
//         initialSelection: initialSelection,
//         hintText: hintText,
//         enabled: enabled,
//       );
//     } else {
//       final items = dropdownMenuEntries
//           .map((e) => {"value": e.value, "label": e.label})
//           .toList();
//
//       if (initialSelection != null && initialSelection != '') {
//         controller?.value =
//             items.firstWhere((element) => element['value'] == initialSelection);
//       } else {
//         controller?.value = items[0];
//       }
//
//       return Container(
//         padding:
//             const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
//         decoration: showDivider == true
//             ? const BoxDecoration(
//                 border:
//                     Border(bottom: BorderSide(width: 1, color: kBorderColor)))
//             : null,
//         child: Row(
//           children: [
//             Text('$labelText'),
//             required == true
//                 ? const Text(
//                     '*',
//                     style: TextStyle(color: Colors.red),
//                   )
//                 : const SizedBox(),
//             Container(width: defaultPadding),
//             Expanded(
//               child: DropdownFormField<Map<String, dynamic>>(
//                 controller: controller,
//                 emptyText: sharedPrefs.translate('No matching found!'),
//                 emptyActionText:
//                     addNew == true ? sharedPrefs.translate('Create new') : '',
//                 // onEmptyActionPressed: (String str) async {},
//                 // dropdownItemSeparator: const Divider(
//                 //   color: Colors.grey,
//                 //   height: 1,
//                 // ),
//                 autoFocus: autoFocus!,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   disabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                 ),
//                 dropdownHeight: menuHeight,
//                 onSaved: (dynamic str) {},
//                 onChanged: (dynamic str) {
//                   onSelected?.call(str['value']);
//                 },
//                 validator: (dynamic str) {
//                   return null;
//                 },
//                 displayItemFn: (dynamic item) => Text(
//                   (item ?? {})['label'] ?? '',
//                   style: const TextStyle(fontSize: mediumTextSize * 1.3),
//                 ),
//                 findFn: (dynamic str) async => items,
//                 selectedFn: (dynamic item1, dynamic item2) {
//                   if (item1 != null && item2 != null) {
//                     return item1['value'] == item2['value'];
//                   }
//                   return false;
//                 },
//                 filterFn: (dynamic item, str) =>
//                     item['value'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
//                 dropdownItemFn: (dynamic item, int position, bool focused,
//                     bool selected, Function() onTap) {
//                   return ListTile(
//                     title: Text(item['label']),
//                     tileColor: focused ? Colors.blue.shade200 : kBgColorRow1,
//                     onTap: onTap,
//                   );
//                 },
//               ),
//             ),
//             const Icon(Icons.arrow_drop_down_sharp),
//           ],
//         ),
//       );
//     }
//   }
// }

class KDropdownSearch extends StatelessWidget {
  final Widget? label;
  final String? labelText;
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final dynamic initialSelection;
  final bool? enabled, required, autoFocus;
  final DropdownEditingController<Map<String, dynamic>>? controller;
  final String? hintText;
  final double? width, menuHeight;
  final Function(dynamic)? onSelected;

  const KDropdownSearch({
    super.key,
    required this.dropdownMenuEntries,
    this.label,
    this.labelText,
    this.initialSelection,
    this.controller,
    this.onSelected,
    this.hintText,
    this.autoFocus = false,
    this.enabled = true,
    this.required = false,
    this.width,
    this.menuHeight = 280,
  });

  @override
  Widget build(BuildContext context) {
    Widget? newLabel = label ?? (labelText == null ? null : Text(labelText!));
    if (labelText != null && label == null && required == true) {
      newLabel = Row(
        children: [
          Text(
            labelText!,
            style: const TextStyle(overflow: TextOverflow.clip),
          ),
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      );
    }
    if (label != null && required == true) {
      newLabel = Row(
        children: [
          label!,
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      );
    }

    if (enabled == false) {
      return KDropdownMenu(
        label: newLabel,
        dropdownMenuEntries: dropdownMenuEntries,
        initialSelection: initialSelection,
        hintText: hintText,
      );
    } else {
      final items = dropdownMenuEntries
          .map((e) => {"value": e.value, "label": e.label})
          .toList();

      if (initialSelection != null && initialSelection != '') {
        controller?.value =
            items.firstWhere((element) => element['value'] == initialSelection);
      } else {
        controller?.value = items[0];
      }
      return DropdownFormField<Map<String, dynamic>>(
        controller: controller,
        emptyText: sharedPrefs.translate('No matching found!'),
        // emptyActionText: sharedPrefs.translate('Create new'),
        // onEmptyActionPressed: (String str) async {},
        // dropdownItemSeparator: const Divider(
        //   color: Colors.grey,
        //   height: 1,
        // ),
        autoFocus: autoFocus!,
        decoration: InputDecoration(
          // suffixIcon: const Icon(Icons.arrow_drop_down),
          suffix: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.arrow_drop_down),
          ),
          label: newLabel,
        ),
        dropdownHeight: menuHeight,
        onSaved: (dynamic str) {},
        onChanged: (dynamic str) {
          onSelected?.call(str['value']);
        },
        validator: (dynamic str) {
          return null;
        },
        displayItemFn: (dynamic item) => Text(
          (item ?? {})['label'] ?? '',
          style: const TextStyle(fontSize: mediumTextSize * 1.3),
        ),
        findFn: (dynamic str) async => items,
        selectedFn: (dynamic item1, dynamic item2) {
          if (item1 != null && item2 != null) {
            return item1['value'] == item2['value'];
          }
          return false;
        },
        filterFn: (dynamic item, str) =>
            item['value'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
        dropdownItemFn: (dynamic item, int position, bool focused,
            bool selected, Function() onTap) {
          return ListTile(
            title: Text(item['label']),
            tileColor: focused ? Colors.blue.shade200 : kBgColorRow1,
            onTap: onTap,
          );
        },
      );
    }
  }
}

/// CUSTOM LOADING DROPDOWN MENU
class COnLoadingDropdownMenu extends StatelessWidget {
  final String? labelText;
  final bool? required;

  const COnLoadingDropdownMenu({super.key, this.labelText, this.required});

  @override
  Widget build(BuildContext context) {
    return CTextFormField(
      labelText: labelText,
      hintText: sharedPrefs.translate('Loading...'),
      readOnly: true,
      required: required,
      suffix: const CircularProgressIndicator(),
      suffixIconConstraints: const BoxConstraints(
        maxHeight: mediumTextSize * 1.5,
        maxWidth: mediumTextSize * 1.5,
      ),
    );
  }
}

class KOnLoadingDropdownMenu extends StatelessWidget {
  final Widget? label;
  final bool? required;

  const KOnLoadingDropdownMenu({super.key, this.label, this.required});

  @override
  Widget build(BuildContext context) {
    Widget? newLabel = label;
    if (label != null && required == true) {
      newLabel = Row(
        children: [
          label!,
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      );
    }

    return KTextFormField(
        label: newLabel,
        hintText: sharedPrefs.translate('Loading...'),
        readOnly: true,
        suffixIcon: const CircularProgressIndicator(),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: mediumTextSize * 1.5,
          maxWidth: mediumTextSize * 1.5,
        ));
  }
}

/// CUSTOM FUTURE DROPDOWN MENU
class CFutureDropdownMenu extends StatelessWidget {
  final String? labelText;
  final Future<List<CDropdownMenuEntry>> dropdownMenuEntries;
  final List<CDropdownMenuEntry>? selectedMenuEntries;
  final List<CDropdownMenuEntry>? disabledMenuEntries;
  final bool? enabled, enableSearch, enableFilter, required, showDivider;
  final MultiSelectController<dynamic>? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(dynamic)? onSelected;

  const CFutureDropdownMenu(
      {super.key,
      required this.dropdownMenuEntries,
      this.selectedMenuEntries,
      this.disabledMenuEntries,
      this.labelText,
      this.controller,
      this.onSelected,
      this.hintText,
      this.enableSearch = false,
      this.enableFilter = true,
      this.enabled = true,
      this.required = false,
      this.showDivider = true,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dropdownMenuEntries,
      builder: (context, snapshot) {
        Widget child = Container();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return COnLoadingDropdownMenu(
            required: required,
            labelText: labelText,
          );
        }
        if (snapshot.hasData) {
          // child = LayoutBuilder(
          //     builder: (BuildContext context, BoxConstraints constraints) {
          //       var parentWidth = constraints.maxWidth;
          //       return DropdownMenu(
          //         width: parentWidth,
          //         controller: controller,
          //         enabled: enabled ?? true,
          //         enableSearch: enableSearch ?? true,
          //         enableFilter: enableFilter ?? false,
          //         hintText: hintText,
          //         dropdownMenuEntries: snapshot.data != null ? snapshot.data! : [],
          //         initialSelection: initialSelection,
          //         onSelected: onSelected,
          //         menuHeight: 400,
          //         inputDecorationTheme: const InputDecorationTheme(),
          //       );
          //     });

          child = CDropdownMenu(
            dropdownMenuEntries: snapshot.data ?? [],
            selectedMenuEntries: selectedMenuEntries ?? [],
            disabledMenuEntries: disabledMenuEntries ?? [],
            controller: controller,
            enabled: enabled ?? true,
            enableSearch: enableSearch ?? true,
            hintText: hintText,
            onSelected: onSelected,
          );
        }
        return Container(
          child: child,
        );
      },
    );
  }
}

class KFutureDropdownMenu extends StatelessWidget {
  final Widget? label;
  final Future<List<DropdownMenuEntry>> dropdownMenuEntries;
  final Object? initialSelection;
  final bool? enabled, enableSearch, enableFilter, required;
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(dynamic)? onSelected;

  const KFutureDropdownMenu(
      {super.key,
      required this.dropdownMenuEntries,
      this.label,
      this.initialSelection,
      this.controller,
      this.onSelected,
      this.hintText,
      this.enableSearch,
      this.enableFilter,
      this.enabled,
      this.required,
      this.validator});

  @override
  Widget build(BuildContext context) {
    Widget? newLabel = label;
    if (label != null && required == true) {
      newLabel = Row(
        children: [
          label!,
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      );
    }

    return FutureBuilder(
      future: dropdownMenuEntries,
      builder: (context, snapshot) {
        Widget child = Container();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return KOnLoadingDropdownMenu(
            required: required,
            label: label,
          );
        }
        if (snapshot.hasData) {
          child = LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            var parentWidth = constraints.maxWidth;
            return DropdownMenu(
              width: parentWidth,
              controller: controller,
              enabled: enabled ?? true,
              label: newLabel,
              enableSearch: enableSearch ?? true,
              enableFilter: enableFilter ?? false,
              hintText: hintText,
              dropdownMenuEntries: snapshot.data != null ? snapshot.data! : [],
              initialSelection: initialSelection,
              onSelected: onSelected,
              menuHeight: 400,
              inputDecorationTheme: const InputDecorationTheme(),
            );
          });
        }
        return Container(
          child: child,
        );
      },
    );
  }
}

/// CUSTOM ELEVATED BUTTON
class CElevatedButton extends StatelessWidget {
  final String? labelText;
  final Widget? child;
  final dynamic buttonType;
  final WidgetStateProperty<Color?>? msBackgroundColor;
  final Color? textColor,
      backgroundColor,
      hoveredBgColor,
      pressedBgColor,
      borderColor;
  final void Function()? onPressed;

  const CElevatedButton({
    super.key,
    this.child,
    this.labelText,
    this.buttonType = ButtonType.normal,
    this.textColor = cButtonTextColor,
    this.backgroundColor = cButtonBgColor,
    this.hoveredBgColor = cButtonBgHoverColor,
    this.pressedBgColor = cButtonBgHoverColor,
    this.borderColor = cButtonBorderColor,
    this.msBackgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var definedTextColor = textColor;
    var definedBgColor = backgroundColor;
    var defineBgHoverColor = hoveredBgColor;
    var definedPressedBgColor = pressedBgColor;
    var definedBorColor = borderColor;

    if (buttonType == ButtonType.success) {
      definedTextColor = Colors.white;
      definedBgColor = Colors.green;
      defineBgHoverColor = const Color(0xFF009A0A);
      definedPressedBgColor = const Color(0xFF00770A);
      definedBorColor = const Color(0xFF01720B);
    } else if (buttonType == ButtonType.danger) {
      definedTextColor = Colors.white;
      definedBgColor = Colors.red;
      defineBgHoverColor = Colors.redAccent;
      definedPressedBgColor = Colors.redAccent;
      definedBorColor = borderColor;
    } else if (buttonType == ButtonType.warning) {
      definedTextColor = Colors.white;
      definedBgColor = Colors.orangeAccent;
      defineBgHoverColor = Colors.orange;
      definedPressedBgColor = Colors.deepOrangeAccent;
      definedBorColor = Colors.deepOrange;
    } else if (buttonType == ButtonType.discard) {
      definedTextColor = Colors.white;
      definedBgColor = Colors.grey;
      defineBgHoverColor = const Color(0xFF4D4C4C);
      definedPressedBgColor = Colors.blueGrey;
      definedBorColor = Colors.black38;
    }

    return ElevatedButton(
      style: ButtonStyle(
        // padding:
        //     WidgetStateProperty.all(const EdgeInsets.only(left: 10, right: 10)),
        backgroundColor: msBackgroundColor ??
            WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return definedPressedBgColor;
              } else if (states.contains(WidgetState.hovered)) {
                return defineBgHoverColor;
              }
              return definedBgColor;
            }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: definedBorColor!),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      onPressed: onPressed,
      child: Text(
        '$labelText',
        style: TextStyle(color: definedTextColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class KElevatedButton extends StatelessWidget {
  final Widget child;
  final WidgetStateProperty<Color?>? msBackgroundColor;
  final Color? backgroundColor, hoveredBgColor, pressedBgColor, borderColor;
  final void Function()? onPressed;

  const KElevatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.msBackgroundColor,
    this.backgroundColor,
    this.hoveredBgColor,
    this.pressedBgColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var newBgColor = backgroundColor ?? kPrimaryColor;
    return ElevatedButton(
      style: ButtonStyle(
        // backgroundColor: backgroundColor,
        backgroundColor: msBackgroundColor ??
            WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return hoveredBgColor ?? kSecondaryColor;
              } else if (states.contains(WidgetState.pressed)) {
                return newBgColor;
              }
              return newBgColor;
            }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10000),
            side: BorderSide(color: newBgColor),
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

/// CUSTOM TEXT FORM FIELD

class CTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText, hintText, initialValue;
  final bool? required,
      autoFocus,
      enabled,
      readOnly,
      labelTextAsHint,
      wrap,
      boldText,
      showDivider;
  final int? maxLines;
  final Widget? suffix;
  final BoxConstraints? suffixIconConstraints;
  final TextAlign? textAlign;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.labelTextAsHint = false,
    this.textAlign,
    this.boldText = false,
    this.hintText,
    this.suffix,
    this.suffixIconConstraints,
    this.initialValue,
    this.enabled = true,
    this.required = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.wrap = false,
    this.showDivider = true,
    this.maxLines = 1,
    this.validator,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (initialValue != null && controller != null) {
      controller!.text = initialValue!;
    }

    var newHintText = labelTextAsHint == true ? labelText : hintText;
    var textFormField = TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        isDense: wrap,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: newHintText != null && required == true
            ? '$newHintText*'
            : newHintText,
        hintStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
        suffix: Container(
          width: 36,
          alignment: Alignment.center,
        ),
        suffixStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
      ),
      initialValue: controller != null ? null : initialValue,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      enabled: enabled,
      autofocus: autoFocus ?? false,
      maxLines: maxLines,
      style: boldText == true
          ? TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize)
          : TextStyle(
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
      // textAlign: textAlign != null
      //     ? textAlign!
      //     : wrap == true || labelTextAsHint == true
      //         ? TextAlign.start
      //         : Responsive.isSmallWidth(context)
      //             ? TextAlign.end
      //             : TextAlign.start,
    );
    var requireSign = required == true
        ? const Text(
            '*',
            style: TextStyle(color: Colors.red),
          )
        : const SizedBox();

    return Container(
      padding: const EdgeInsets.only(left: defaultPadding),
      decoration: showDivider == true
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: kBorderColor)))
          : null,
      child: wrap == true
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: defaultPadding * 2),
                Row(
                  children: [
                    Text(
                      '$labelText',
                      // style: const TextStyle(fontSize: mediumTextSize),
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize),
                    ),
                    requireSign,
                  ],
                ),
                textFormField,
                SizedBox(
                  width: suffixIconConstraints?.maxWidth,
                  height: suffixIconConstraints?.maxHeight,
                  // padding: const EdgeInsets.all(3),
                  child: suffix,
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  children: [
                    labelTextAsHint == true
                        ? const SizedBox()
                        : Text(
                            '$labelText',
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontSize),
                          ),
                    labelTextAsHint == true ? const SizedBox() : requireSign,
                    labelTextAsHint == true
                        ? const SizedBox()
                        : const SizedBox(width: defaultPadding * 4),
                    Expanded(child: textFormField),
                    Container(
                      width: suffixIconConstraints?.maxWidth,
                      height: suffixIconConstraints?.maxHeight,
                      padding: const EdgeInsets.only(right: defaultPadding),
                      child: suffix,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
    );
  }
}

class KTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? label, prefix, prefixIcon, suffix, suffixIcon;
  final String? labelText, hintText, initialValue;
  final BoxConstraints? suffixIconConstraints;
  final bool? required, autoFocus, enabled, readOnly, labelTextAsHint;
  final int? maxLines;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const KTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.label,
    this.prefix,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.suffix,
    this.suffixIcon,
    this.enabled,
    this.required,
    this.autoFocus,
    this.readOnly,
    this.labelTextAsHint,
    this.maxLines = 1,
    this.suffixIconConstraints,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (initialValue != null && controller != null) {
      controller!.text = initialValue!;
    }

    Widget? newLabel = label ?? Text('$labelText');
    if (label != null && required == true) {
      newLabel = Row(
        children: [
          label!,
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      );
    }
    return TextFormField(
      controller: controller,
      validator: validator
      // ?? (required == true
      //     ? (value) {
      //         if (value == null || value.isEmpty) {
      //           return sharedPrefs.translate('This field is required!');
      //         }
      //         return null;
      //       }
      //     : null)
      ,
      decoration: InputDecoration(
        label: newLabel,
        labelText: labelText,
        border: kBorder,
        enabledBorder: kBorder,
        disabledBorder: kDisabledBorder,
        focusedBorder: kFocusedBorder,
        hintText: hintText,
        prefix: prefix,
        prefixIcon: prefixIcon,
        suffix: suffix,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
      ),
      initialValue: controller != null ? null : initialValue,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      enabled: enabled,
      autofocus: autoFocus ?? false,
      maxLines: maxLines,
    );
  }
}

/// CUSTOM TEXT
class CText extends StatelessWidget {
  const CText(
    this.data, {
    super.key,
    this.warpText,
    this.style,
  });

  final String data;
  final bool? warpText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var dataWidget = Text(
      data,
      style: style,
      overflow: TextOverflow.clip,
    );
    if (warpText == true) {
      return Flexible(child: dataWidget);
    } else {
      return dataWidget;
    }
  }
}

class KText extends StatelessWidget {
  const KText(
    this.data, {
    super.key,
    this.warpText,
    this.style,
  });

  final String data;
  final bool? warpText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var dataWidget = Text(
      data,
      style: style,
      overflow: TextOverflow.clip,
    );
    if (warpText == true) {
      return Flexible(child: dataWidget);
    } else {
      return dataWidget;
    }
  }
}

/// CUSTOM SELECTABLE TEXT
class CSelectableText extends StatelessWidget {
  const CSelectableText(
    this.data, {
    super.key,
    this.style,
    this.warpText = false,
  });

  final String data;
  final bool? warpText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var dataWidget = SelectableText(
      data,
      style: style ??
          const TextStyle(
            overflow: TextOverflow.clip,
          ),
    );
    if (warpText == true) {
      return Flexible(child: dataWidget);
    } else {
      return dataWidget;
    }
  }
}

class KSelectableText extends StatelessWidget {
  const KSelectableText(
    this.data, {
    super.key,
    this.style,
    this.warpText = false,
  });

  final String data;
  final bool? warpText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var dataWidget = SelectableText(
      data,
      style: style ??
          const TextStyle(
            overflow: TextOverflow.clip,
          ),
    );
    if (warpText == true) {
      return Flexible(child: dataWidget);
    } else {
      return dataWidget;
    }
  }
}

/// CUSTOM ICON
class CIcon extends StatelessWidget {
  const CIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
  });

  final IconData? icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? mediumTextSize * 1.5,
      color: color,
    );
  }
}

class KIcon extends StatelessWidget {
  const KIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
  });

  final IconData? icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? mediumTextSize * 1.5,
      color: color,
    );
  }
}

// class CustomDatePicker extends StatefulWidget {
//   final Widget? label;
//   final TextEditingController? controller;
//   final DateTime? initialDate, firstDate, lastDate;
//   final String? hintText;
//   final bool? readOnly;

//   const CustomDatePicker(
//       {super.key,
//       this.controller,
//       this.label,
//       this.initialDate,
//       this.firstDate,
//       this.lastDate,
//       this.hintText,
//       this.readOnly});

//   @override
//   State<CustomDatePicker> createState() => _CustomDatePickerState();
// }

// class _CustomDatePickerState extends State<CustomDatePicker> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.initialDate != null) {
//       widget.controller!.text = df1.format(widget.initialDate!).toString();
//     }
//     return CustomTextFormField(
//       label: widget.label,
//       hintText: widget.hintText,
//       controller: widget.controller,
//       readOnly: widget.readOnly,
//       suffix: InkWell(
//         child: const Icon(Icons.calendar_month),
//         onTap: () async {
//           DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialEntryMode: DatePickerEntryMode.calendarOnly,
//             firstDate: widget.firstDate ?? DateTime(1900),
//             lastDate: widget.lastDate ?? DateTime(2100),
//             initialDate: widget.initialDate,
//           );

//           if (pickedDate != null && widget.controller != null) {
//             String formattedDate = df1.format(pickedDate);
//             setState(() {
//               widget.controller!.text = formattedDate;
//             });
//           }
//         },
//       ),
//     );
//   }
// }

// class CustomDateTimePicker extends StatefulWidget {
//   final Widget? label;
//   final TextEditingController? controller;
//   final DateTime? initialDate, firstDate, lastDate;
//   final String? hintText;
//   final bool? readOnly;

//   const CustomDateTimePicker(
//       {super.key,
//       this.controller,
//       this.label,
//       this.initialDate,
//       this.firstDate,
//       this.lastDate,
//       this.hintText,
//       this.readOnly});

//   @override
//   State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
// }

// class _CustomDateTimePickerState extends State<CustomDateTimePicker>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.initialDate != null) {
//       widget.controller!.text = df2.format(widget.initialDate!).toString();
//     }
//     return CustomTextFormField(
//       label: widget.label,
//       hintText: widget.hintText,
//       controller: widget.controller,
//       readOnly: widget.readOnly,
//       suffix: InkWell(
//         child: const Icon(Icons.calendar_month),
//         onTap: () async {
//           DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialEntryMode: DatePickerEntryMode.calendarOnly,
//             firstDate: widget.firstDate ?? DateTime(1900),
//             lastDate: widget.lastDate ?? DateTime(2100),
//             initialDate: widget.initialDate,
//           );

//           if (pickedDate != null && widget.controller != null) {
//             String formattedDate = df2.format(
//                 DateTime(pickedDate.year, pickedDate.month, pickedDate.day)
//                     .add(const Duration(days: 1) - const Duration(seconds: 1)));
//             setState(() {
//               widget.controller!.text = formattedDate;
//             });
//           }
//         },
//       ),
//     );
//   }
// }

// /// CustomMultiDropdownMenu
// class CustomMultiselectDropDown extends StatefulWidget {
//   final Function(List<String>) selectedList;
//   final List<String> listOfStrings;

//   const CustomMultiselectDropDown(
//       {super.key, required this.selectedList, required this.listOfStrings});

//   @override
//   createState() {
//     return _CustomMultiselectDropDownState();
//   }
// }

// class _CustomMultiselectDropDownState extends State<CustomMultiselectDropDown> {
//   List<String> listOFSelectedItem = [];
//   String selectedText = "";

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10.0),
//       decoration: null,
//       child: ExpansionTile(
//         iconColor: null,
//         title: Text(
//           listOFSelectedItem.isEmpty ? "Select" : listOFSelectedItem[0],
//         ),
//         children: <Widget>[
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.listOfStrings.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8.0),
//                 child: _ViewItem(
//                     item: widget.listOfStrings[index],
//                     selected: (val) {
//                       selectedText = val;
//                       if (listOFSelectedItem.contains(val)) {
//                         listOFSelectedItem.remove(val);
//                       } else {
//                         listOFSelectedItem.add(val);
//                       }
//                       widget.selectedList(listOFSelectedItem);
//                       setState(() {});
//                     },
//                     itemSelected: listOFSelectedItem
//                         .contains(widget.listOfStrings[index])),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ViewItem extends StatelessWidget {
//   String item;
//   bool itemSelected;
//   final Function(String) selected;

//   _ViewItem(
//       {required this.item, required this.itemSelected, required this.selected});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Padding(
//       padding:
//           EdgeInsets.only(left: size.width * .032, right: size.width * .098),
//       child: Row(
//         children: [
//           SizedBox(
//             height: 24.0,
//             width: 24.0,
//             child: Checkbox(
//               value: itemSelected,
//               onChanged: (val) {
//                 selected(item);
//               },
//               activeColor: Colors.blue,
//             ),
//           ),
//           SizedBox(
//             width: size.width * .025,
//           ),
//           Text(
//             item,
//           ),
//         ],
//       ),
//     );
//   }
// }
