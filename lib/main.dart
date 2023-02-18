import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  ValueNotifier<String> userInput = ValueNotifier<String>("");
  ValueNotifier<String> result = ValueNotifier<String>("");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.20,
              alignment: Alignment.bottomRight,
              child: ValueListenableBuilder(
                valueListenable: userInput,
                builder: (context, value, child) {
                  return Text(
                    value,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  );
                },
              )),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.20,
              alignment: Alignment.bottomRight,
              child: ValueListenableBuilder(
                valueListenable: result,
                builder: (context, value, child) {
                  return Text(
                    value,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  );
                },
              )),
          const Divider(
            color: Colors.black,
            thickness: 5,
            indent: 0,
            endIndent: 0,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              calculatorBtn('1', Colors.brown, Colors.grey),
              calculatorBtn('2', Colors.brown, Colors.grey),
              calculatorBtn('3', Colors.brown, Colors.grey),
              calculatorBtn('+', Colors.brown, Colors.grey),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                calculatorBtn('4', Colors.brown, Colors.grey),
                calculatorBtn('5', Colors.brown, Colors.grey),
                calculatorBtn('6', Colors.brown, Colors.grey),
                calculatorBtn('-', Colors.brown, Colors.grey),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                calculatorBtn('7', Colors.brown, Colors.grey),
                calculatorBtn('8', Colors.brown, Colors.grey),
                calculatorBtn('9', Colors.brown, Colors.grey),
                calculatorBtn('*', Colors.brown, Colors.grey),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                calculatorBtn('c', Colors.brown, Colors.grey),
                calculatorBtn('0', Colors.brown, Colors.grey),
                calculatorBtn('/', Colors.brown, Colors.grey),
                calculatorBtn('=', Colors.brown, Colors.grey),
              ],
            ),
          )
        ]));
  }

  void calculation() {
    double num1 = 0, num2 = 0;
    String temp = "", operator = "";
    bool flag = false;

    for (int i = 0; i < userInput.value.length; i++) {
      if (userInput.value[i] == "+" ||
          userInput.value[i] == "-" ||
          userInput.value[i] == "*" ||
          userInput.value[i] == "/" ||
          userInput.value[i] == "%") {
        operator = userInput.value[i];
        temp = "";
        flag = true;
      } else {
        if (flag == false) {
          temp += userInput.value[i];
          num1 = double.parse(temp);
        } else {
          temp += userInput.value[i];
          num2 = double.parse(temp);
        }
      }
    }

    switch (operator) {
      case '+':
        result.value = (num1 + num2).toString();

        break;

      case '-':
        result.value = (num1 - num2).toString();

        break;

      case '*':
        result.value = (num1 * num2).toString();

        break;
      case '/':
        result.value = (num1 / num2).toString();

        break;
    }
  }

  Widget calculatorBtn(String btnText, Color textColor, Color btnColor) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
          ),
          onPressed: () {
            if (btnText != '=' && btnText != 'c') {
              userInput.value += btnText;
            } else if (btnText == 'c') {
              userInput.value = "";
              result.value = "";
            } else {
              calculation();
            }
          },
          child: Text(
            btnText,
            style: TextStyle(fontSize: 30, color: textColor),
          )),
    );
  }
}
