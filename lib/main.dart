// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = "0";

  double firstNumber = 0;
  String operation = "";
  bool isNewNumber = true;

  final List<String> buttons = [
    "C",
    "/",
    "*",
    "-",
    "7",
    "8",
    "9",
    "+",
    "4",
    "5",
    "6",
    "=",
    "1",
    "2",
    "3",
    ".",
    "0",
  ];

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        display = "0";
        firstNumber = 0;
        operation = "";
        isNewNumber = true;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        firstNumber = double.parse(display);
        operation = value;
        isNewNumber = true;
      } else if (value == "=") {
        double secondNumber = double.parse(display);
        double result = 0;

        switch (operation) {
          case "+":
            result = firstNumber + secondNumber;
            break;
          case "-":
            result = firstNumber - secondNumber;
            break;
          case "*":
            result = firstNumber * secondNumber;
            break;
          case "/":
            if (secondNumber != 0) {
              result = firstNumber / secondNumber;
            } else {
              display = "Error";
              return;
            }
            break;
        }

        if (result == result.toInt()) {
          display = result.toInt().toString();
        } else {
          display = result.toString();
        }

        isNewNumber = true;
      } else {
        if (isNewNumber) {
          display = value;
          isNewNumber = false;
        } else {
          if (value == "." && display.contains(".")) {
            return;
          }
          display += value;
        }
      }
    });
  }

  Color getButtonColor(String text) {
    if (text == "=") {
      return Colors.orange;
    }

    if (text == "+" ||
        text == "-" ||
        text == "*" ||
        text == "/" ||
        text == "C") {
      return Colors.blueGrey;
    }

    return Colors.grey.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                display,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    buttonPressed(buttons[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: getButtonColor(buttons[index]),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    buttons[index],
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
