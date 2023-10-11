import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';

class paysDetailsPage extends StatefulWidget {
  String keyword = "";

  paysDetailsPage(this.keyword);

  @override
  State<paysDetailsPage> createState() => _paysDetailsPageState();
}

class _paysDetailsPageState extends State<paysDetailsPage> {
//  int currentPage = 1;
//  int size = 10;
 // int totalPages = 100;
 // ScrollController _scrollController = new ScrollController();
  //List<dynamic> hits = [];
  var paysData;

  /*void initState() {
    super.initState();
    getPaysData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getPaysData(widget.keyword);
        }
      }
    });
  }*/
  void initState() {
    super.initState();
    getPaysData(widget.keyword);
  }

  void getPaysData(String keyword) {
    print("details de la pays " + keyword);
    String url = "https://restcountries.com/v2/name/${keyword}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.paysData = json.decode(utf8.decode(resp.bodyBytes));
        print(this.paysData);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: paysData == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: (paysData == null ? 0 : paysData.length),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 30, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child:
                      Image.network(paysData[index]['flags']['png'])),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      Text(
                        paysData[index]['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        paysData[index]['nativeName'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '\nAdministration',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Text(
                          'Capitale :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paysData[index]['capital'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 3),
                      Row(children: [
                        const Text(
                          'Language(s) :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${paysData[index]['languages'][0]['name']},${paysData[index]['languages'][0]['nativeName']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '\nGéographie',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Text(
                          'Région :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paysData[index]['region'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 3),
                      Row(children: [
                        const Text(
                          'Superficie :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paysData[index]['area'].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 3),
                      Row(children: [
                        const Text(
                          'Fuseau Horaire :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paysData[index]['timezones'][0].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '\nDémographie',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Text(
                          'Population :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paysData[index]['population'].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),

                    ],
                  ),
                ],
              ),
            );
          },
        ),
        appBar: AppBar(title: Text('Page Pays Details ${widget.keyword}')),);
  }
}
