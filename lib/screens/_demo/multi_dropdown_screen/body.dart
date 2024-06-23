import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MultiDropdownBody extends StatefulWidget {
  const MultiDropdownBody({super.key});

  @override
  State<MultiDropdownBody> createState() => _MultiDropdownBodyState();
}

class _MultiDropdownBodyState extends State<MultiDropdownBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            MultiSelectDropDown(
              clearIcon: null,
              hint: 'Select',
              selectionType: SelectionType.single,
              // searchEnabled: true,
              onOptionSelected: (List<ValueItem> selectedOptions) {},
              options: const <ValueItem>[
                ValueItem(label: 'Option 1', value: 1),
                ValueItem(label: 'Option 2', value: 2),
                ValueItem(label: 'Option 3', value: 3),
                ValueItem(label: 'Option 4', value: 4),
                ValueItem(label: 'Option 5', value: 5),
                ValueItem(label: 'Option 6', value: 6),
              ],
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              dropdownHeight: 300,
              selectedOptionIcon: const Icon(Icons.check_circle),
              inputDecoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black38))),
            ),
            MultiSelectDropDown(
              hint: 'Select',
              selectionType: SelectionType.multi,
              // searchEnabled: true,
              onOptionSelected: (List<ValueItem> selectedOptions) {},
              options: const <ValueItem>[
                ValueItem(label: 'Option 1', value: 1),
                ValueItem(label: 'Option 2', value: 2),
                ValueItem(label: 'Option 3', value: 3),
                ValueItem(label: 'Option 4', value: 4),
                ValueItem(label: 'Option 5', value: 5),
                ValueItem(label: 'Option 6', value: 6),
              ],
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              dropdownHeight: 300,
              selectedOptionIcon: const Icon(Icons.check_circle),
              inputDecoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black38))),
            ),
          ],
        ),
      ),
    );
  }
}
