import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _outputHistory = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _outputHistory = "";
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.parse(_output);
      operand = buttonText;
      _outputHistory = _output + " " + operand;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      }
      _output = _output + buttonText;
    } else if (buttonText == "=") {
      num2 = double.parse(_output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        if (num2 != 0) {
          _output = (num1 / num2).toString();
        } else {
          _output = "Erro";
        }
      }

      // Limpa os zeros finais (.0)
      if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }

      _outputHistory = ""; // Limpa histórico após o resultado
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      if (_output == "0" || _output == "Erro") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      // Atualiza o visor
    });
  }

  // Widget para criar os botões
  Widget buildButton(String buttonText, Color color, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          // Visor de Histórico
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Text(
              _outputHistory,
              style: const TextStyle(fontSize: 24.0, color: Colors.grey),
            ),
          ),
          // Visor Principal
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          // Linhas de Botões
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("CLEAR", Colors.red),
                  buildButton("÷", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("7", Colors.blueGrey),
                  buildButton("8", Colors.blueGrey),
                  buildButton("9", Colors.blueGrey),
                  buildButton("×", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("4", Colors.blueGrey),
                  buildButton("5", Colors.blueGrey),
                  buildButton("6", Colors.blueGrey),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("1", Colors.blueGrey),
                  buildButton("2", Colors.blueGrey),
                  buildButton("3", Colors.blueGrey),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton(".", Colors.blueGrey),
                  buildButton("0", Colors.blueGrey),
                  buildButton("=", Colors.green, flex: 2),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}