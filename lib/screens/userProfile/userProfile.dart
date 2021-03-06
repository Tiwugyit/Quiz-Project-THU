import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/navigationBar/NavBar.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// ! Information about the class:
// ~ This class represents myProfile page
// ! Use of the class:
// ~ It shows the user specific information

// ! TODOS:
// TODO Improve loading as done in welcome and sign_in with boolean loading variable

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  // ! States
  // ~ Here states of the profile page are defined
  int userLevel = 0;
  String avatar = 'default.png';
  String username = '';
  String email = '';
  UserData? userData = null;

  @override
  Widget build(BuildContext context) {
    // ! Provider.of<AppUser?>(context):
    // ~ Here we listen to the stream, defined in services/auth.dart and provided by main.dart, which informs us about login state of the user
    final user = Provider.of<AppUser?>(context);

    // ! If user is logged in, proceed further
    if (user != null) {
      // ! StreamBuilder<UserData>
      // ~ StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream
      // ~ Information about the UserData is forwarded down the stream ONLY for this class. The stream does not go below to children elements
      // ~ If the data is changed in the DB, it is immideately reflected in the UserProfile
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            // ! If there is a data for current user in the DB, then assign it to the variables, otherwise display Loading screen
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              userLevel = userData!.level;
              avatar = userData.avatar;
              username = userData.username;
              email = userData.email;

              return Scaffold(
                // ! NavBar():
                // ~ Here we provide NavBar for property drawer. This is our navigation bar defined in navigationBar/navBar.dart
                drawer: NavBar(),
                backgroundColor: Colors.grey[900],
                appBar: AppBar(
                  title: Text('My profile'),
                  centerTitle: true,
                  backgroundColor: Colors.grey[850],
                  // ~ Elavation set to 0 removes the shadow ( which makes 3D effect )
                  elevation: 0.0,
                ),
                body: Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                  child: Column(
                    // ~ This alligns everything to the left
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ~ Make a circle image with CircleAvatar
                      Center(
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/menu_images/$avatar'),
                          backgroundColor: Colors.amberAccent[200],
                          radius: 40.0,
                        ),
                      ),
                      // ~ This is a line which literally looks like divider
                      Divider(
                        // ~ This is the height between top element and bottom, not the line itself
                        height: 90.0,
                        color: Colors.grey[800],
                      ),
                      // * Start username field
                      Text(
                        'USERNAME',
                        style: TextStyle(
                          color: Colors.grey,
                          // ~ This gives the spacing between the letters
                          letterSpacing: 2.0,
                        ),
                      ),
                      // ~ Creates an empty invisible box for us of a height and width we specify
                      // ~ we put it between the elements we want to have space in between
                      SizedBox(height: 10.0),
                      Text(
                        username,
                        style: TextStyle(
                            color: Colors.amberAccent[200],
                            letterSpacing: 2.0,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold),
                      ),
                      // * End username field
                      SizedBox(height: 30.0),
                      // * Start current level field
                      Text(
                        'CURRENT LEVEL',
                        style: TextStyle(
                          color: Colors.grey,
                          // ~ This gives the spacing between the letters
                          letterSpacing: 2.0,
                        ),
                      ),
                      // ~ Creates an empty invisible box for us of a height and width we specify
                      SizedBox(height: 10.0),
                      Text(
                        // ~ With '$' we output the contat of the data to string
                        '$userLevel',
                        style: TextStyle(
                            color: Colors.amberAccent[200],
                            letterSpacing: 2.0,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold),
                      ),
                      // * End current level field
                      SizedBox(height: 30.0),
                      // * Start e-mail field
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.email,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            email,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18.0,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      // * End e-mail field
                    ],
                  ),
                ),
              );
              // ! If the user data is still fetching from DB, return Loading screen
            } else {
              return Loading();
            }
          });
      // ! If user is not logged in or data is still fetching from DB, return Loading screen
    } else {
      return Loading();
    }
  }
}
