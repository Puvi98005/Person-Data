import 'package:demo_test/fluttertoast.dart';
import 'package:demo_test/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget{
  
  SignUpPage({super.key});
  @override
  State<StatefulWidget> createState()  => _SignUpPage();
}

class _SignUpPage extends State<StatefulWidget> {
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
     
     return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign Up", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 2, 47, 84)),),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ 
                  ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, "/login");
                  }, child: const Text("Cancel")),

                  ElevatedButton(onPressed: () async{
                            
                  
                            
                    String enteredEmail = email.text.trim().toLowerCase();
                            
                    if(!enteredEmail.endsWith("@gmail.com")){
                            
                      Message.show(message: "gmail must end with @gmail.com");
                            
                      email.clear();
                            
                      return ;
                    }
                            
                     await AuthenticationHelper.createAccountWithEmail(enteredEmail, password.text).then((value){
                            
                      if(value == "Account Created Succesfully!"){
                        Message.show(message: "Account Created Succesfully!");
                        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                        
                      }
                            
                     });
                  }, child: const Text("SignUp",)),
                ],
              ),
              SizedBox(height: 20,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?" , style: TextStyle(fontSize: 18),),
                  TextButton(onPressed: (){
                   Navigator.pushReplacementNamed(context, "/login");
                  }, child: const Text("Login"))
          
                ],
              )
            ],
          ),
        ),
      ),
     );

  }

}