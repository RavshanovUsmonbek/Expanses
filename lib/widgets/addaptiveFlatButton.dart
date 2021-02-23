import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';


class AddaptiveFlatButton extends StatelessWidget {

  final String label;
  final Function handler;

  AddaptiveFlatButton({
    @required this.label,
    @required this.handler
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
            CupertinoButton(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () =>  handler(),
            ) :
            FlatButton(
              onPressed: () => handler(), 
              child: Text(label),
              textColor: Theme.of(context).primaryColor,
            );
  }
}