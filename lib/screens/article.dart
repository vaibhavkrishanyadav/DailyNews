import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget {

  final String url;
  Article({this.url});

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {


  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async{
    setState(() {
      _loading = false;
    });
  }

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Daily',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 35.0,
              ),
            ),
            Text(
              'NEWS',
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 35.0,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.mood),
            ),
          )
        ],
        elevation: 0.0,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
