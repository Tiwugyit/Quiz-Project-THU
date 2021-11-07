import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

// ! This widget is responsible for outputting different brews on the page
class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // ~ We access the brews. It's updated when some changes to the database occur
    final brews = Provider.of<QuerySnapshot?>(context);
    //print(brews?.docs.toString());
    if(brews?.docs != null ){
      for(var doc in brews!.docs){
        print(doc.data());
      }
    }

    return Container();
  }
}