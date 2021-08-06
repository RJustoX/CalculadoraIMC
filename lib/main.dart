import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController pesoControl = TextEditingController();
  TextEditingController alturaControl = TextEditingController();
  String _info = 'Insira seus dados';
  bool darkMode = false;
  Color primaryColor = HexColor('#f72585');
  Color backgroundColor = Colors.white;

  void changeTheme() {
    setState(() {
      darkMode = !darkMode;
      if (darkMode) {
        primaryColor = HexColor('#555b6e');
        backgroundColor = HexColor('#293241');
      } else {
        primaryColor = HexColor('#f72585');
        backgroundColor = Colors.white;
      }
    });
  }

  void refresh() {
    setState(() {
      pesoControl.text = "";
      alturaControl.text = "";
      _info = 'Insira seus dados';
      _formState = GlobalKey<FormState>();
    });
  }

  void calcula() {
    setState(() {
      double peso = double.parse(pesoControl.text);
      double altura = double.parse(alturaControl.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.5)
        _info = 'Abaixo do peso ${imc.toStringAsPrecision(3)} ';
      else if (imc >= 18.6 && imc <= 24.9)
        _info = 'Peso ideal ${imc.toStringAsPrecision(3)} ';
      else if (imc >= 25.0 && imc <= 29.9)
        _info = 'Sobrepeso ${imc.toStringAsPrecision(3)} ';
      else if (imc >= 30.0 && imc <= 34.9)
        _info = 'Obesidade Grau I ${imc.toStringAsPrecision(3)} ';
      else if (imc >= 35.0 && imc <= 39.9)
        _info = 'Obesidade Grau II ${imc.toStringAsPrecision(3)} ';
      else if (imc >= 40.0) _info = 'Obesidade Grau III ${imc.toStringAsPrecision(3)} ';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Calculadora IMC',
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () => refresh()),
          IconButton(
              icon: Icon(darkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  changeTheme();
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(
          key: _formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                color: primaryColor,
                size: 120,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (Kg):',
                  labelStyle: TextStyle(
                    color: darkMode ? Colors.white : primaryColor,
                    fontSize: 25,
                  ),
                ),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: darkMode ? Colors.white : primaryColor,
                  fontSize: 25,
                ),
                controller: pesoControl,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm):',
                  labelStyle: TextStyle(
                    color: darkMode ? Colors.white : primaryColor,
                    fontSize: 25,
                  ),
                ),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: darkMode ? Colors.white : primaryColor,
                  fontSize: 25,
                ),
                controller: alturaControl,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      if (_formState.currentState.validate()) {
                        calcula();
                      }
                    },
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                _info,
                style: TextStyle(
                  fontSize: 25,
                  color: darkMode ? Colors.white : primaryColor,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
