import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Authentification'), backgroundColor: Colors.redAccent,),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,color: Colors.redAccent),
                  hintText: "Utilisateur",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: txt_password,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password,color: Colors.redAccent,),
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                _onAuthentifier(context);
              },
              child: Text('Connexion', style: TextStyle(fontSize: 22),),
            ),
          ),
          TextButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/inscription');
              },
              child: Text("Nouvel Utilisateur",
                style: TextStyle(fontSize: 22, color: Colors.redAccent),))
        ],
      ),
    );
    throw UnimplementedError();
  }
  Future<void> _onAuthentifier(BuildContext context) async {
    SnackBar snackBar=SnackBar(content: Text(""));
    if(!txt_login.text.isEmpty && !txt_password.text.isEmpty){
      try{
        final credential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email:txt_login.text,
          password:txt_password.text,
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          snackBar=SnackBar(content: Text("utilisateur existant"));
        }
        else if (e.code == 'wrong-password') {
          snackBar=SnackBar(content: Text("verifier mot de passe"));
        }
      } catch (e) {
        print (e);
      }
    }

  }
}


