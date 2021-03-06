import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ! Information about the class:
// ~ This class just shows spinning loading widget
// ! Use of the class:
// ~ Whenever we wait for some response from Firebase or Firestore, we use this widget

// ! TODOs
// all done

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        // ~ Another spinners can be selected here https://pub.dev/packages/flutter_spinkit
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}
