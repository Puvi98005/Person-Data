import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper{

  //create account 
  static Future<String> createAccountWithEmail( String email, String password) async{
  
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return "Account Created Succesfully!";
  }
  on FirebaseAuthException catch(e){
    return   e.message.toString();
  }
  catch(e){
    return  e.toString();
  }
  }
//login

static Future<String> loginwithEmail(String email, String password) async{
  
try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  return "Login Successfully!";

}
on FirebaseAuthException catch(e){
  return  e.message.toString();
}
catch(e){
  return e.toString();
}
}

//logout

static Future logout() async{

try{
  await FirebaseAuth.instance.signOut();
  return "Logout Successful!";
}
on FirebaseAuthException catch(e) {
  return e.message.toString();
}
catch(e){
  return e.toString();
}
}

//check user

static Future<bool> checkuser() async{

  var currenuser = FirebaseAuth.instance.currentUser;

  return currenuser !=null ? true : false;
}
}
