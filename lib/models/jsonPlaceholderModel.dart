import 'package:flutter/cupertino.dart';

class JsonPlaceholderModel {
  int id, userId;
  String title, body;
  JsonPlaceholderModel({
    @required this.title,
    @required this.body,
    this.id,
    this.userId,
  });
}
