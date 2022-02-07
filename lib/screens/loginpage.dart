import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traintravelers/screens/constants.dart';
import 'package:traintravelers/screens/Dashboard.dart';
import 'package:traintravelers/screens/register_page.dart';
import 'package:traintravelers/screens/ticketbooking.dart';
import 'package:traintravelers/widgets/custom_btn.dart';
import 'package:traintravelers/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  Future<String?> _LoginPage() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _loginemail, password:_loginpasswsord);
      return null;
    }on FirebaseAuthException catch (e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return'The account already exists for that email.';
      }
      return e.message;

    }catch(e){
      return e.toString();

    }

  }

  void _submitform() async {

    //set the form loading state
    setState(() {
      _LoginFormloading=true;
    });

    //run the create account method
    String? _loginFeedback = await  _LoginPage();

    //if the string is not null, we got error while create account
    if(_loginFeedback != null){
      _alertDialogBuilder(_loginFeedback);
      //set the form to the reguler state
      setState(() {
        _LoginFormloading = false;
      });
    }else{
      Navigator.pop(context);
    }

  }
  //Default for loading state
  bool _LoginFormloading = false;

  //form input field values

  String _loginemail = "";
  String _loginpasswsord = "";

  //focus node for input fields

  late FocusNode _passwordFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(



        child:Container(

        decoration: const BoxDecoration(
        image:DecorationImage(
        image: AssetImage("assets/qw.jpg"),
         fit: BoxFit.cover,
    )
    ),


          width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 24.0,
              ),
              child: Text(
                "Welcome user, \n Login to your account",
              textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: "E mail..",
                  onChanged: (value) {
                    _loginemail = value;

                  },
                  onSubmitted:(value){
                    _passwordFocusNode.requestFocus();

                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  hintText: "Password..",
                  onChanged: (value) {
                    _loginpasswsord = value;
                  },
                  focusNode: _passwordFocusNode,
                  isPasswordField: true,
                  onSubmitted: (value){
                    _submitform();
                  },
                ),
                CustomInput(
                  hintText: "Confirmpassword..",
                ),
                CustomBtn(
                  text: "Login",
                  onPressed: () {
                    _submitform();

                  },
                  isLoading: _LoginFormloading,


                )

              ],

            ),


            Padding(
              padding: const EdgeInsets.only(
               bottom: 16.0,
              ),
              child: CustomBtn(
                text: "Create a  New Account",
                onPressed: (){
                Navigator.push(
                 context,
               MaterialPageRoute(builder: (context) =>  RegisterPage()),
               );
              },

              ),
            ),


          ],

        ),
      ),
      ),
    );
  }
}


