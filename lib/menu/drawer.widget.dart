

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.white,Colors.red])
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/P_image.jpg"),
                radius: 80,
              ),
            ),
          ),
          //parcourir les différents éléments du menu
          ...(GlobalParams.menus as List).map((item){
            return ListTile(
              title: Text('${item['title']}',style: TextStyle(fontSize: 22),),
              leading: item['icon'],
              trailing: Icon(Icons.arrow_right,color: Colors.red,),
              onTap: () async{
                if('${item['title']}' != "Déconnexion"){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, "${item['route']}");
                }
                else
                  {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/authentification', (Route<dynamic> route) => false);
                  }
              },
            );
          }),

        ],
      ),
    );
  }

}