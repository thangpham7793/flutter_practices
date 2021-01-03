import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var imageUrl =
      'https://images.freeimages.com/images/large-previews/eaa/the-beach-1464354.jpg';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My First Flutter App!",
        home: Scaffold(
            appBar: AppBar(title: Text("My First Flutter App")),
            backgroundColor: Colors.white,
            body: Builder(
                builder: (context) => SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Hello World Travel Agency",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[800],
                                    ))),
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Discover the world!",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[800],
                                    ))),
                            // image has a network constructor
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.network(imageUrl, height: 350)),
                            Padding(
                                padding: EdgeInsets.all(15),
                                child: RaisedButton(
                                  child: Text('Contact Us!'),
                                  onPressed: () => contactUs(context),
                                ))
                          ],
                        )))))));
  }
}

void contactUs(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('contact us!'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic)),
            content: Text('Mail us at hello@world.com!'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Close'),
                  onPressed: () => Navigator.of(context).pop())
            ]);
      });
}
