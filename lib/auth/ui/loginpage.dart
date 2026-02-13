import 'package:demo_test/fluttertoast.dart';
import 'package:demo_test/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loginpage extends StatefulWidget{
  Loginpage({super.key});
  @override
  State<StatefulWidget> createState()  => _LoginPage();
}

class _LoginPage extends State<StatefulWidget> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isPasswordVisible = false;
     
     return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Login", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 2, 47, 84)),),
              SizedBox(height: 20,),
              TextFormField(
                controller: email,
            
                decoration: InputDecoration(
                   hintText: "Enter your Email ",
                   prefixIcon: Icon(Icons.email),
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: password,
                 obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Icon(Icons.password),
                  hintText: "Enter your password ",
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off
                    ),
                 onPressed: (){
                     setState((){isPasswordVisible =!isPasswordVisible;});
                  }, )
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(onPressed: () async{
                          
                
                          
                  String enteredEmail = email.text.trim().toLowerCase();
                          
                  if(!enteredEmail.endsWith("@gmail.com")){
                          
                    Message.show(message: "gmail must end with @gmail.com");
                          
                    email.clear();
                          
                    return ;
                  }
                          
                   await AuthenticationHelper.loginwithEmail(enteredEmail, password.text).then((value){
                          
                    if(value == "Login Successfully!"){
                      Message.show(message: "Login Successfully!");
                      Navigator.pushNamed(context,  "/home");
                    }
                    else{
                      Message.show(message: "Wrong username and password");
                    }
                   });
                }, child: const Text("Login", style: TextStyle(fontSize: 20, ),)),
              ),
              SizedBox(height: 20,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Need an account ?" , style: TextStyle(fontSize: 18),),
                  TextButton(onPressed: (){
                       Navigator.pushReplacementNamed(context, "/signup");
                  }, child: const Text("Sign Up"))
          
                ],
              )
            ],
          ),
        ),
      ),
     );

  }

}