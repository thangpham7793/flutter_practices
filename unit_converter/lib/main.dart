import 'package:flutter/material.dart';

void main() => runApp(App());

class AppState extends State<App> {
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds',
    'ounces'
  ];

  final Map<String, int> _measureMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert(double value, String from, String to) {
    int nFrom = _measureMap[from];
    int nTo = _measureMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = (value * multiplier);
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasure are ${result.toStringAsFixed(3)} $_convertedMeasure';
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  String _startMeasure;
  String _convertedMeasure;
  String _resultMessage;
  double _numberFrom;

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );

    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );

    var _appTitle = 'Top Measures Converter';
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(title: Text(_appTitle)),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              Text('Value', style: labelStyle),
              Spacer(),
              TextField(
                style: inputStyle,
                decoration: InputDecoration(hintText: "Insert Measure"),
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberFrom = rv;
                    });
                    return;
                  }
                  setState(() {
                    _numberFrom = null;
                  });
                },
              ),
              Spacer(
                flex: 2,
              ),
              Text('From', style: labelStyle),
              Spacer(flex: 2),
              Text(
                  (_numberFrom == null)
                      ? 'Please Enter a Valid Number'
                      : _numberFrom.toString(),
                  style: inputStyle),
              Spacer(
                flex: 2,
              ),
              DropdownButton(
                  value: _startMeasure,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            value,
                            style: inputStyle,
                          ),
                        ));
                  }).toList(),
                  onChanged: (vl) {
                    setState(() {
                      _startMeasure = vl;
                    });
                  }),
              Spacer(
                flex: 2,
              ),
              Text(
                'To',
                style: labelStyle,
              ),
              Spacer(
                flex: 2,
              ),
              DropdownButton(
                  value: _convertedMeasure,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            value,
                            style: inputStyle,
                          ),
                        ));
                  }).toList(),
                  onChanged: (vl) {
                    setState(() {
                      _convertedMeasure = vl;
                    });
                  }),
              Spacer(flex: 2),
              RaisedButton(
                child: Text('Convert', style: inputStyle),
                onPressed: () {
                  if (_startMeasure.isEmpty ||
                      _convertedMeasure.isEmpty ||
                      _numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom, _startMeasure, _convertedMeasure);
                  }
                },
              ),
              Spacer(flex: 2),
              Text((_resultMessage == null) ? '' : _resultMessage,
                  style: inputStyle),
              Spacer(
                flex: 8,
              ),
              RaisedButton(
                  child: Text('Reset', style: labelStyle),
                  onPressed: () {
                    setState(() {
                      _convertedMeasure = null;
                      _startMeasure = null;
                      _resultMessage = null;
                      _numberFrom = 0;
                    });
                  }),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}
