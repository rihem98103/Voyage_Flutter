import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inscription/pages/paysDetails.page.dart';

import '../menu/drawer.widget.dart';


class PaysPage extends StatelessWidget{
  TextEditingController txt_pays=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pays')),
      body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_pays,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.photo_library),
                    hintText: "keyword",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10)

                    )
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(

                    onPressed: () {_onGetpaysDetails(context);
                    },
                    child: Text('chercher', style: TextStyle(fontSize: 22)

                    )
                )

            ),
          ]
      ),
    );
  }

  void _onGetpaysDetails(BuildContext context) {
    String keyword=txt_pays.text;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  paysDetailsPage(keyword))
    );

  }

}