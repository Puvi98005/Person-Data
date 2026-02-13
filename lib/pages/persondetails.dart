import 'package:demo_test/fluttertoast.dart';
import 'package:demo_test/service/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class PersonDetails extends StatefulWidget{
  PersonDetails({super.key});
  @override
  State<StatefulWidget> createState() => _PersonDetails();
}

class _PersonDetails extends State<PersonDetails>{
  TextEditingController username = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController imageurl = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(centerTitle: true,title: const Text("Personal Data", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 85, 1, 134)),),),
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Username" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20,),
        
              Text("Phone Number" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: phonenumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your Phone number",
                  prefixIcon: Icon(Icons.phone_android),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20,),
        
              Text("Email" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20,),
        
              Text("Image Url" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: imageurl,
                decoration: InputDecoration(
                  hintText: "Enter your image url",
                  prefixIcon: Icon(Icons.image_rounded),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              
              SizedBox(height: 20,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                   ElevatedButton(onPressed: (){
                 Navigator.of(context).pop();
                }, child: const Text("Cancel")),

                
                  ElevatedButton(onPressed: () async{
                  
                  String id = randomAlphaNumeric(10);
                        
                  var enterdphonenumber = phonenumber.text.trim();
                        
                  RegExp phoneRegex = RegExp(r'^[0-9]+$');
                  
                
                        
                 if(!phoneRegex.hasMatch(enterdphonenumber)){
                  Message.show(message: "Phone number must contain only digits");
                        
                  phonenumber.clear();
                  return;
                 }
                
                 
                String enteredEmail = email.text.trim().toLowerCase();
                
                if(!enteredEmail.endsWith("@gmail.com")){
                
                  Message.show(message: "gmail must end with @gmail.com");
                
                  email.clear();
                
                  return ;
                }
                        
                  Map<String, dynamic> addData = {
                     "Username" : username.text,
                    "Phone Number" : phonenumber.text,
                    "Email Id" : email.text,
                    "Image URL" : imageurl.text,
                     "Id " : id,
                  };
                        
                  await DatabaseHelper().addbooksdetails(id, addData).then((value){
                  if(value=="Data Added Succesfully!"){

                    Message.show(message: "Book has been added");
                    Navigator.pushNamed(context,  "/home");

                  }
                  });
                        
                }, child: const Text("Add Data")),

               
                ],
              ),
        
            ],
          ),
        ),
      ),
    ),
   );
  }

}