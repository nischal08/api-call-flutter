import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network/models/jsonPlaceholderModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _loadingWidget = LinearProgressIndicator();

  Widget _disabledLoadingWidget = SizedBox();

  bool _isLoading = false;
  List<Widget> _listItems = List();
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Json placeholder"),
        backgroundColor: Colors.purpleAccent,
        actions: [_refreshButton()],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            _isLoading ? _loadingWidget : _disabledLoadingWidget,
            _myList(),
          ],
        ),
      ),
    );
  }

  Widget _refreshButton() {
    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          _fetch();
        });
  }

  void _fetch() async {
    _enableLoading();
    String url = "https://jsonplaceholder.typicode.com/posts";
    Response res = await get(url);
    //print(res.body);
    _responseDecoder(res.body);
    _disableLoading();
  }

  _enableLoading() {
    // _loadingWidget = LinearProgressIndicator();

    _isLoading = true;
    setState(() {});
  }

  _disableLoading() {
    _isLoading = false;
    // _loadingWidget = SizedBox();
    setState(() {});
  }

  _responseDecoder(String body) {
    List list = jsonDecode(body);
    // print(list.length);
    // print(list[0]);
    List<Widget> tempList = List();
    for (int i = 0; i < list.length; i++) {
      Map eachElement = list[i];
      JsonPlaceholderModel model = JsonPlaceholderModel(
        title: eachElement['title'],
        body: eachElement["body"],
        userId: eachElement["userId"],
        id: eachElement["id"],
      );
      // print(model.id);
      // String title = eachElement['title'];
      // Widget titleCard = _card(title);
      Widget titleCard = _card(model);
      tempList.add(titleCard);
    }
    _listItems = tempList;
    setState(() {});
  }

  Widget _myList() {
    return SizedBox(
      height: height * .84,
      width: width,
      child: ListView(
        children: _listItems,
      ),
    );
  }

  Widget _card(JsonPlaceholderModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: model);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.title),
        ),
      ),
    );
  }
}
