import 'package:flutter/material.dart';
import '../pages/main_page.dart';
import '../pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_pfa/firebase_options.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.buttonName,
    required this.email,
    required this.password,
  }) : super(key: key);

  final String buttonName;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
      child: TextButton(
        onPressed: () async{
          final _email= email.text;
          final _password= password.text;
          try{
          UserCredential uc=await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _email,
              password: _password
          );

          var sessionManager = SessionManager();
          await sessionManager.set("email", uc.user?.email);


          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage()));

          }on FirebaseAuthException catch (e){
            if(e.code =='user-not-found'){
              await showDialog(context: context, builder: (context) => AlertDialog(
                title: Text('Erreur  '),
                content: Text('Utilisateur introuvable'),
                actions: [TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text('Ok'))], // TextButton
              )); // AlertDialog
            }
            else if(e.code=='wrong-password'){
              await showDialog(context: context, builder: (context) => AlertDialog(
                title: Text('Erreur'),
                content: Text('le mot de passe est incorrect'),
                actions: [TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text('Ok'))], // TextButton
              )); // AlertDialog

            }
          }
        },
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
