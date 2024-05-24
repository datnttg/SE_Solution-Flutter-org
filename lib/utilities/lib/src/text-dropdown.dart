import 'package:dropdown_plus_plus/dropdown_plus_plus.dart';
import 'package:flutter/material.dart';

/// Simple dorpdown whith plain text as a dropdown items.
class TextDropdownFormField extends StatelessWidget {
  final List<String> options;
  final InputDecoration? decoration;
  final DropdownEditingController<String>? controller;
  final void Function(String item)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool Function(String item, String str)? filterFn;
  final Future<List<String>> Function(String str)? findFn;
  final double? dropdownHeight;
  final Color? cursorColor;
  final TextStyle? searchTextStyle;
  final Color? dropdownColor;
  final Color? dropdownItemColor;
  final Color? dropdownItemSelectedColor;
  final Widget? dropdownItemSeparator;

  const TextDropdownFormField({
    super.key,
    required this.options,
    this.decoration,
    this.onSaved,
    this.controller,
    this.onChanged,
    this.validator,
    this.findFn,
    this.filterFn,
    this.dropdownHeight,
    this.cursorColor,
    this.searchTextStyle,
    this.dropdownItemColor,
    this.dropdownItemSelectedColor,
    this.dropdownColor,
    this.dropdownItemSeparator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFormField<String>(
      dropdownColor: dropdownColor,
      dropdownItemSeparator: dropdownItemSeparator,
      searchTextStyle: searchTextStyle,
      cursorColor: cursorColor,
      decoration: decoration,
      onSaved: onSaved,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      dropdownHeight: dropdownHeight,
      displayItemFn: (dynamic str) => Text(
        str ?? '',
        style: const TextStyle(fontSize: 16),
      ),
      findFn: findFn ?? (dynamic str) async => options,
      filterFn: filterFn ??
          (dynamic item, str) =>
              item.toLowerCase().indexOf(str.toLowerCase()) >= 0,
      dropdownItemFn: (dynamic item, position, focused, selected, onTap) =>
          ListTile(
        title: Text(
          item,
          style: TextStyle(
            color: selected
                ? (dropdownItemSelectedColor ?? Colors.blue)
                : (dropdownItemColor ?? Colors.black87),
          ),
        ),
        tileColor: focused ? const Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
        onTap: onTap,
      ),
    );
  }
}
