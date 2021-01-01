import 'package:flutter/material.dart';
import '../Constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home_Screen.dart';
import 'package:email_validator/email_validator.dart';
import '../Decorations.dart';
import '../Utilities/HelperFunctions.dart';
import '../Providers/FavouritesMovies.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const ID = 'RegisterScreen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String UserName;
  String EmailAddress;
  String Password;
  var _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  int RadioButtonValue = 0;
  void CheckedRadioButton(int val) {
    setState(() {
      RadioButtonValue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listOfFav = Provider.of<FavouriteMovies>(context);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: AssetImage('images/5012766d5d9e5ab8094ffbc088916b29.jpg'),
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.black54,
          body: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 150),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 50),
                    TweenAnimationBuilder(
                        curve: Curves.bounceOut,
                        tween: Tween<double>(begin: 70, end: 0),
                        duration: Duration(seconds: 1),
                        builder : (BuildContext context , double positoin , _)
                        {
                          return  Container(
                            margin: EdgeInsets.only(top:positoin),
                            child:TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'UserName Must Not Be Empty.';
                                else
                                  return null;
                              },
                              decoration: KInputDecoration('UserName'),
                              onChanged: (value) {
                                UserName = value;
                              },
                            ),
                          );
                        }
                    ) ,
                    SizedBox(height: 30),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: KInputDecoration('Email Address'),
                      validator: (value) {
                        if (value.isEmpty) return 'Email Must Not Be Empty.';
                        else if (!EmailValidator.validate(value)) {
                          return 'Email Not In Email Format';
                        } else
                          return null;
                      },

                      onChanged: (value) {
                        EmailAddress = value;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: KInputDecoration('Password'),
                      onChanged: (value) {
                        Password = value;
                      },
                        validator: (value) {
                            if (value.isEmpty) return 'Password Must Not Be Empty.';
                            if (value.length <= 5)
                              return 'Password Must Greater Than 5 Characters.';
                            else
                              return null;
                          },
                    ),
                    SizedBox(height: 30),
                    FlatButton(

                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                      color: Colors.redAccent,
                      padding: EdgeInsets.all(15),
                      onPressed: () async {
                        if (_formKey.currentState.validate())
                          {
                            try {
                              Firebase.initializeApp();
                              final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: EmailAddress, password: Password);
                              if (newUser != Null) {

                                User LoggedUserName = await GetCurrentUser();
                                await listOfFav.loadData(LoggedUserName.uid);
                                Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute(
                                        builder: (BuildContext ontext) {
                                          return homePage(
                                            LoggedUserName: LoggedUserName,
                                          );
                                        }));
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
