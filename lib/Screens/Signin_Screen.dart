import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/Home_Screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';
import '../Decorations.dart';
import '../Providers/FavouritesMovies.dart';
import '../Utilities/HelperFunctions.dart';

class SigninScreen extends StatefulWidget {
  static const ID = 'SignInScreen';
  @override
  _SigninScreenState createState() => _SigninScreenState();
}
class _SigninScreenState extends State<SigninScreen> {
  String EmailAddress;
  String Password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  var _formKey = new GlobalKey<FormState>();
  User LoggedUserName;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
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
          height: double.infinity,
      child: Scaffold(
          backgroundColor: Colors.black54,
          body: ModalProgressHUD(
           inAsyncCall: showSpinner,

            child: Form(
            key: _formKey,
              child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 200.0, right: 30.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Text(
                        'Sign',
                        style: TextStyle(
                          color:Colors.redAccent,
                          fontSize: 60.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),

                        child:Text(
                          'In',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TweenAnimationBuilder(
                        curve: Curves.bounceOut,
                        tween: Tween<double>(begin: 70, end: 0),
                        duration: Duration(seconds: 2),
                        builder : (BuildContext context , double positoin , _)
                        {
                          return Container(
                            margin: EdgeInsets.only(top:positoin),
                            child: TextFormField(
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
                          );
                        }
                    ) ,
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: KInputDecoration('Password'),
                      onChanged: (value) {
                        Password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Password Must Not Be Empty.';
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FlatButton(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        color:Colors.redAccent,
                        padding: EdgeInsets.all(15),
                        onPressed: () async {
                          if (_formKey.currentState.validate())
                            {
                              try
                              {
                                final signInUser =
                                    await _auth.signInWithEmailAndPassword(
                                        email: EmailAddress, password: Password);

                                if (signInUser != null) {
                                  setState(() {
                                    showSpinner = true;
                                  });

                                  LoggedUserName = await GetCurrentUser();
                                  await listOfFav.loadData(LoggedUserName.uid);
                                  Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute(
                                          builder: (BuildContext ontext) {
                                    return homePage(
                                      LoggedUserName: this.LoggedUserName,
                                    );
                                  }));
                                }

                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Invalide Email Or Password' , style:TextStyle(fontSize:17)) ,
                                            Icon(Icons.close_rounded , size: 30,color:Colors.redAccent)
                                          ],
                                        ))) ;
                              }
                            }
                        },
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('don’t have an account?' , style: TextStyle(color: Colors.white38),),

                        FlatButton(
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.pushNamed(
                                      context, 'RegisterScreen');
                                });
                              }),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
