import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _input = '0';
  String _result = '';
  String _operator = '';
  double _firstNumber = 0;
  bool _isNewNumber = true;
  String _history = '';

  void _onNumberPressed(String number) {
    setState(() {
      if (_isNewNumber) {
        _input = number;
        _isNewNumber = false;
      } else {
        if (_input == '0') {
          _input = number;
        } else {
          _input += number;
        }
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      if (_operator.isEmpty) {
        _firstNumber = double.parse(_input);
        _history = _input + ' ' + operator;
      } else {
        _calculateResult();
        _firstNumber = double.parse(_result);
        _history = _result + ' ' + operator;
      }
      _operator = operator;
      _isNewNumber = true;
    });
  }

  void _calculateResult() {
    double secondNumber = double.parse(_input);
    _history += ' ' + _input + ' =';
    switch (_operator) {
      case '+':
        _result = (_firstNumber + secondNumber).toString();
        break;
      case '-':
        _result = (_firstNumber - secondNumber).toString();
        break;
      case '×':
        _result = (_firstNumber * secondNumber).toString();
        break;
      case '÷':
        _result = (_firstNumber / secondNumber).toString();
        break;
    }
    _input = _result;
  }

  void _onEqualPressed() {
    setState(() {
      if (_operator.isNotEmpty) {
        _calculateResult();
        _operator = '';
        _isNewNumber = true;
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _input = '0';
      _result = '';
      _operator = '';
      _firstNumber = 0;
      _isNewNumber = true;
      _history = '';
    });
  }

  void _onPercentPressed() {
    setState(() {
      double number = double.parse(_input);
      _input = (number / 100).toString();
    });
  }

  void _onPlusMinusPressed() {
    setState(() {
      double number = double.parse(_input);
      _input = (number * -1).toString();
    });
  }

  Widget _buildButton(String text, {Color? color, Color? textColor, double? width}) {
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
              _onNumberPressed(text);
            } else if (['+', '-', '×', '÷'].contains(text)) {
              _onOperatorPressed(text);
            } else if (text == '=') {
              _onEqualPressed();
            } else if (text == 'C') {
              _onClearPressed();
            } else if (text == '%') {
              _onPercentPressed();
            } else if (text == '±') {
              _onPlusMinusPressed();
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
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
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
                      _history,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _input,
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildButton('C', color: const Color(0xFF3498DB), textColor: Colors.white)),
                      Expanded(child: _buildButton('±', color: const Color(0xFF3498DB), textColor: Colors.white)),
                      Expanded(child: _buildButton('%', color: const Color(0xFF3498DB), textColor: Colors.white)),
                      Expanded(child: _buildButton('÷', color: const Color(0xFF3498DB), textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildButton('7')),
                      Expanded(child: _buildButton('8')),
                      Expanded(child: _buildButton('9')),
                      Expanded(child: _buildButton('×', color: const Color(0xFF3498DB), textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildButton('4')),
                      Expanded(child: _buildButton('5')),
                      Expanded(child: _buildButton('6')),
                      Expanded(child: _buildButton('-', color: const Color(0xFF3498DB), textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildButton('1')),
                      Expanded(child: _buildButton('2')),
                      Expanded(child: _buildButton('3')),
                      Expanded(child: _buildButton('+', color: const Color(0xFF3498DB), textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(flex: 2, child: _buildButton('0')),
                      Expanded(child: _buildButton('.')),
                      Expanded(child: _buildButton('=', color: const Color(0xFF3498DB), textColor: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
