import 'package:calc1/cubit/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  String input = '0';
  String result = '';
  String operator = '';
  double firstNumber = 0;
  bool isNewNumber = true;
  String history = '';

  void onNumberPressed(String number) {
    setState(() {
      if (isNewNumber) {
        input = number;
        isNewNumber = false;
      } else {
        if (input == '0') {
          input = number;
        } else {
          input += number;
        }
      }
    });
  }

  void onOperatorPressed(String operator) {
    setState(() {
      if (operator.isEmpty) {
        firstNumber = double.parse(input);
        history = '$input $operator';
      } else {
        calculateResult();
        firstNumber = double.parse(result);
        history = '$result $operator';
      }
      operator = operator;
      isNewNumber = true;
    });
  }

  void calculateResult() {
    double secondNumber = double.parse(input);
    history += ' $input =';
    switch (operator) {
      case '+':
        result = (firstNumber + secondNumber).toString();
        break;
      case '-':
        result = (firstNumber - secondNumber).toString();
        break;
      case '×':
        result = (firstNumber * secondNumber).toString();
        break;
      case '÷':
        result = (firstNumber / secondNumber).toString();
        break;
    }
    input = result;
  }

  void onEqualPressed() {
    setState(() {
      if (operator.isNotEmpty) {
        calculateResult();
        operator = '';
        isNewNumber = true;
      }
    });
  }

  void onClearPressed() {
    setState(() {
      input = '0';
      result = '';
      operator = '';
      firstNumber = 0;
      isNewNumber = true;
      history = '';
    });
  }

  void onPercentPressed() {
    setState(() {
      double number = double.parse(input);
      input = (number / 100).toString();
    });
  }

  void onPlusMinusPressed() {
    setState(() {
      double number = double.parse(input);
      input = (number * -1).toString();
    });
  }

  Widget buildButton(String text,
      {Color? color, Color? textColor, double? width}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF2C3E50),
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () {
            if (text.contains(RegExp(r'[0-9.]'))) {
              onNumberPressed(text);
            } else if (['+', '-', '×', '÷'].contains(text)) {
              onOperatorPressed(text);
            } else if (text == '=') {
              onEqualPressed();
            } else if (text == 'C') {
              onClearPressed();
            } else if (text == '%') {
              onPercentPressed();
            } else if (text == '±') {
              onPlusMinusPressed();
            }
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: SafeArea(
          child: BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            history,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            input,
                            style: const TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF262626),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: buildButton('C',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                            Expanded(
                                child: buildButton('±',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                            Expanded(
                                child: buildButton('%',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                            Expanded(
                                child: buildButton('÷',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: buildButton('7')),
                            Expanded(child: buildButton('8')),
                            Expanded(child: buildButton('9')),
                            Expanded(
                                child: buildButton('×',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: buildButton('4')),
                            Expanded(child: buildButton('5')),
                            Expanded(child: buildButton('6')),
                            Expanded(
                                child: buildButton('-',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: buildButton('1')),
                            Expanded(child: buildButton('2')),
                            Expanded(child: buildButton('3')),
                            Expanded(
                                child: buildButton('+',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 2, child: buildButton('0')),
                            Expanded(child: buildButton('.')),
                            Expanded(
                                child: buildButton('=',
                                    color: const Color(0xFF3498DB),
                                    textColor: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
