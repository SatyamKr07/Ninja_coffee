import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tnn_ff/models/brew.dart';
import 'package:tnn_ff/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  //const BrewList({Key key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    //print(brews.documents);
    // for (var docs in brews.documents) {
    //   print(docs.data);
    // }
    // brews.forEach((element) {
    //   print(element.name);
    //   //print(element.sugars);
    //   print(element.strength);
    // });

    //final brews1 = Provider.of<List<Brew>>(context)??[];
    return ListView.builder(
      //itemCount: brews1.length,
      //use above itemCount if u r using brews1 so that u don't get null error
      itemCount: brews?.length ?? 0,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
