import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traintravelers/widgets/custom_btn.dart';
import 'package:traintravelers/widgets/custom_input.dart';
import 'constants.dart';

class RegisterPage extends StatefulWidget {


  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {




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
 //Create a new user account
  Future<String?> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _registerEmail, password:_registerPassword);
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
      _registerFormLoading=true;
    });

    //run the create account method
    String? _createAccountFeedback = await  _createAccount();

    //if the string is not null, we got error while create account
    if(_createAccountFeedback != null){
      _alertDialogBuilder(_createAccountFeedback);
      //set the form to the reguler state
      setState(() {
        _registerFormLoading = false;
      });
    }else{
      Navigator.pop(context);
    }

  }
    //Default for loading state
    bool _registerFormLoading = false;

    //form input field values

    String _registerEmail = "";
    String _registerPassword = "";

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
      var _registerFormLoading;
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image:DecorationImage(
                image: AssetImage("assets/ui.jpg"),
                fit: BoxFit.cover,
              )
          ),

          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Text(
                    "Create A New Account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,

                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "E mail..",
                      onChanged: (value) {
                        _registerEmail = value;

                      },
                      onSubmitted:(value){
                        _passwordFocusNode.requestFocus();

                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password..",
                      onChanged: (value) {
                        _registerPassword = value;
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
                      text: "Create New Account",
                      onPressed: () {
                        _submitform();

                      },
                      isLoading: _registerFormLoading,


                    )

                  ],

                ),


                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: CustomBtn(text: "Back to Login",
                    onPressed: () {
                    Navigator.pop(context);
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


