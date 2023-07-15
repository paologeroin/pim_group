import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Class that implement a custom-made [ListTile] to manage textboxes containing strings in a [Form].
class FormTextTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormTextTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 194, 138, 243)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) => value == "" ? 'Must not be empty.' : null,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: labelText,
                focusColor: Color.fromARGB(255, 194, 138, 243),
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormTextTile

///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
class FormNumberTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormNumberTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 194, 138, 243)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern =
                    r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value!)) ret = 'Must be a number.';
                return ret;
              },
              keyboardType: TextInputType.numberWithOptions(signed: true),
              decoration: InputDecoration(
                labelText: labelText,
                focusColor: Color.fromARGB(255, 194, 138, 243),
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormTextTile

///Class that implement a custom-made [ListTile] to manage dropdown menus containing numbers in a [Form].
class DropdownButtonTileNumber extends ListTile {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  DropdownButtonTileNumber(
      {this.icon, this.value, this.items, this.labelText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 194, 138, 243)),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<int>(
          isExpanded: false,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('${value.toString()}'),
            );
          }).toList(),
        ),
      ),
    );
  } // build
} // DropdownButtonTileNumber

///Class that implement a custom-made [ListTile] to manage dropdown menus containing strings in a [Form].
class DropdownButtonTileString extends ListTile {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  DropdownButtonTileString(
      {this.icon, this.value, this.items, this.labelText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 194, 138, 243)),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<String>(
          isExpanded: false,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
        ),
      ),
    );
  } // build
} // DropdownButtonTileString
