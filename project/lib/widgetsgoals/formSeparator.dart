import 'package:flutter/material.dart';

///Class that implements a custom [StatelessWidget] that acts as a separator in a [Form].
///It is used to separate "categories" in a [Form].
class FormSeparator extends StatelessWidget {
  final label;

  FormSeparator({this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2,
                width: 75,
                child: Container(
                  color: Color.fromARGB(255, 109, 230, 69),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ))),
              SizedBox(
                height: 2,
                width: 75,
                child: Container(
                  color: Color.fromARGB(255, 109, 230, 69),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  } // build
} // FormSeparator