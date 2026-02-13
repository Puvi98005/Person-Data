import "package:demo_test/auth/ui/loginpage.dart";
import "package:demo_test/auth/ui/signUpPage.dart";
import "package:demo_test/firebase_options.dart";
import "package:demo_test/home.dart";
import "package:demo_test/pages/persondetails.dart";
import "package:demo_test/service/auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

void main() async
{ 
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
   
}

class MyApp extends StatelessWidget{
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Personal Data",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(221, 225, 80, 80))),
     // home:Home(),
      routes: {
        "/" : (context) => CheckuserloggedIn(),
       // "/": (context) => Home(),
        "/home" : (context) => Home(),
        "/login": (context) => Loginpage(),
        "/signup" : (context) => SignUpPage(),
        "/persondetails" : (context) => PersonDetails(),
      },

    );
  }
}



class CheckuserloggedIn extends StatefulWidget {
  CheckuserloggedIn({super.key});
  @override
  State<StatefulWidget> createState() => _CheckuserloggedIn();

}

class _CheckuserloggedIn extends State<CheckuserloggedIn>{
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUser();
    });
  }

  Future<void> checkUser() async{

    await AuthenticationHelper.checkuser().then((value){
      if (!mounted) return; 
      
          if(value){
            Navigator.pushReplacementNamed(context, "/home");
          }
          else{
            Navigator.pushReplacementNamed(context, "/login");
          }
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: const Color.fromARGB(255, 87, 243, 26),),
      ),
     );
  }

} 