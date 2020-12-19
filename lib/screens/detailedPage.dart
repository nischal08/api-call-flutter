import 'package:flutter/material.dart';
import 'package:network/models/jsonPlaceholderModel.dart';

class DetailPage extends StatelessWidget {
  // JsonPlaceholderModel model;
  // DetailPage({this.model});

  @override
  Widget build(BuildContext context) {
    JsonPlaceholderModel model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(model.body),
      ),
    );
  }
}
