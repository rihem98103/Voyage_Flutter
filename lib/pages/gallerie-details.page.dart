import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';

class GallerieDetailsPage extends StatefulWidget {
  String keyword = "";

  GallerieDetailsPage(this.keyword);

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  int totalPages = 100;
  ScrollController _scrollController = new ScrollController();
  List<dynamic> hits = [];
  var galleryData;

  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  void getGalleryData(String keyword) {
    print("Gallerie de fleurs");
    String url =
        "https://pixabay.com/api/?key=35407165-b2cd52f8b169bb0dc25dbda01&q=${keyword}&page=${currentPage}&per_page=${size}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.galleryData = json.decode(resp.body);
        print(galleryData);
        hits.addAll(galleryData['hits']);
        totalPages = (galleryData['totalHits'] / size).ceil();
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: totalPages == 0
                ? Text('pas de résultat')
                : Text("${widget.keyword}, ${currentPage}/${totalPages}")),
        body: (galleryData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                itemCount: (galleryData == null ? 0 : hits.length),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(hits[index]['tags'],
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          color: Colors.blue,
                        ),

                      ),
                      Container(
                          child: Card(
                            child: Image.network(
                              hits[index]['webformatURL'],
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10, right: 10))
                    ],
                  );
                })));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
