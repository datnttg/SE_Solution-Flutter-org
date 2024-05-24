import 'package:dropdown_plus_plus/dropdown_plus_plus.dart';
import 'package:flutter/material.dart';
import 'shared_preferences.dart';
import 'ui_styles.dart';

/// CUSTOM SCAFFOLD
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
              preferredSize: const Size.fromHeight(defaultTextSize * 3.5),
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
      /// ORIGINAL DECLARATION
      // return LayoutBuilder(
      //     builder: (BuildContext context, BoxConstraints constraints) {
      //   return DropdownMenu(
      //     width: constraints.maxWidth,
      //     label: newLabel,
      //     controller: controller,
      //     enabled: enabled!,
      //     enableSearch: false,
      //     enableFilter: false,
      //     hintText: hintText,
      //     dropdownMenuEntries: dropdownMenuEntries,
      //     initialSelection: initialSelection,
      //     onSelected: onSelected,
      //     menuHeight: menuHeight,
      //     inputDecorationTheme: const InputDecorationTheme(),
      //   );
      // });
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
          style: const TextStyle(fontSize: defaultTextSize * 1.3),
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
          maxHeight: defaultTextSize * 1.5,
          maxWidth: defaultTextSize * 1.5,
        ));
  }
}

/// CUSTOM FUTURE DROPDOWN MENU
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
  final Widget? suffix, suffixIcon;
  final String? labelText, hintText, initialValue;
  final BoxConstraints? suffixIconConstraints;
  final bool? required, autoFocus, enabled, readOnly, labelAsHint;
  final int? maxLines;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.labelAsHint,
    this.validator,
    this.hintText,
    this.initialValue,
    this.suffix,
    this.suffixIcon,
    this.enabled,
    this.required,
    this.autoFocus,
    this.readOnly,
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

    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        // labelText: labelText,
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: defaultFocusedBorder,
        hintText: labelAsHint == true ? labelText : hintText,
        prefix: labelAsHint == true ? null : Text('$labelText'),
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

class KTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? label, suffix, suffixIcon;
  final String? hintText, initialValue;
  final BoxConstraints? suffixIconConstraints;
  final bool? required, autoFocus, enabled, readOnly;
  final int? maxLines;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const KTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.label,
    this.hintText,
    this.initialValue,
    this.suffix,
    this.suffixIcon,
    this.enabled,
    this.required,
    this.autoFocus,
    this.readOnly,
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
        border: defaultBorder,
        focusedBorder: defaultFocusedBorder,
        hintText: hintText,
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
      size: size ?? defaultTextSize * 1.5,
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
