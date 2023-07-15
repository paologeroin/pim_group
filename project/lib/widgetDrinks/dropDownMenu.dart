import 'package:flutter/material.dart';

// DropdownMenu to select the drink
class DropdownMenu extends StatelessWidget {
  String? currentSelectedValue;

  final ValueNotifier<List<String>> _listNotifier =
      ValueNotifier<List<String>>(["Beer", "Wine", "Cocktail"]);

  String? getCurrentValue() {
    return currentSelectedValue;
  }

  Widget typeFieldWidget() {
    return ValueListenableBuilder(
      valueListenable: _listNotifier,
      builder: (BuildContext context, List<String> list, Widget? child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text("Select Drink"),
                    value: currentSelectedValue,
                    isDense: true,
                    onChanged: (newValue) {
                      currentSelectedValue = newValue;
                      _listNotifier.notifyListeners();
                    },
                    items: list.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: typeFieldWidget(),
    ));
  }
}
