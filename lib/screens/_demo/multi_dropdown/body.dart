import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class MultiDropdownBody extends StatefulWidget {
  const MultiDropdownBody({super.key});

  @override
  State<MultiDropdownBody> createState() => _MultiDropdownBodyState();
}

class _MultiDropdownBodyState extends State<MultiDropdownBody> {
  final _formKey = GlobalKey<FormState>();
  final controller = MultiSelectController<User>();

  @override
  Widget build(BuildContext context) {
    var items = [
      DropdownItem(label: 'Nepal', value: User(name: 'Nepal', id: 1)),
      DropdownItem(label: 'Australia', value: User(name: 'Australia', id: 6)),
      DropdownItem(label: 'India', value: User(name: 'India', id: 2)),
      DropdownItem(label: 'China', value: User(name: 'China', id: 3)),
      DropdownItem(label: 'USA', value: User(name: 'USA', id: 4)),
      DropdownItem(label: 'UK', value: User(name: 'UK', id: 5)),
      DropdownItem(label: 'Germany', value: User(name: 'Germany', id: 7)),
      DropdownItem(label: 'France', value: User(name: 'France', id: 8)),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            MultiDropdown<User>(
              items: items,
              controller: controller,
              enabled: true,
              searchEnabled: true,
              chipDecoration: const ChipDecoration(
                backgroundColor: Colors.yellow,
                wrap: true,
                runSpacing: 2,
                spacing: 10,
              ),
              fieldDecoration: FieldDecoration(
                hintText: 'Countries',
                hintStyle: const TextStyle(color: Colors.black87),
                prefixIcon: const Icon(Icons.flag),
                showClearIcon: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black87,
                  ),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                marginTop: 2,
                maxHeight: 500,
                header: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Select countries from the list',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              dropdownItemDecoration: DropdownItemDecoration(
                selectedIcon: const Icon(Icons.check_box, color: Colors.green),
                disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a country';
                }
                return null;
              },
              onSelectionChange: (selectedItems) {
                debugPrint("OnSelectionChange: $selectedItems");
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final selectedItems = controller.selectedItems;

                      debugPrint(selectedItems.toString());
                    }
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.selectAll();
                  },
                  child: const Text('Select All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.clearAll();
                  },
                  child: const Text('Unselect All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.addItems([
                      DropdownItem(
                          label: 'France', value: User(name: 'France', id: 8)),
                    ]);
                  },
                  child: const Text('Add Items'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.selectWhere((element) =>
                        element.value.id == 1 ||
                        element.value.id == 2 ||
                        element.value.id == 3);
                  },
                  child: const Text('Select Where'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.selectAtIndex(0);
                  },
                  child: const Text('Select At Index'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.openDropdown();
                  },
                  child: const Text('Open/Close dropdown'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final int id;

  User({required this.name, required this.id});

  @override
  String toString() {
    return 'User(name: $name, id: $id)';
  }
}
