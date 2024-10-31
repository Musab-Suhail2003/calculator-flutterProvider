import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  final compController = TextEditingController();
  List<double> numbers = [];
  List<String> operators = [];

  setValue(String value) {
    String str = compController.text;

    switch (value) {
      case "AC":
        compController.clear();
        break;
      case "+/-":
        var num = int.tryParse(str);
        if(num != null){compController.text = "${(num * -1)}";}
        break;
      case "x":
        compController.text += "*";
        break;
      case "÷":
        compController.text += "/";
        break;
      case "=":
        compController.text = compute(str);
        break;
      default:
        compController.text += value;
    }
    compController.selection = TextSelection.fromPosition(
        TextPosition(offset: compController.text.length));
  }

  String compute(String exp) {
    List<String> tokens = splitIntoTokens(exp);

    for (var token in tokens) {
      if (double.tryParse(token) != null) {
        // If it's a number, push it to the numbers stack
        numbers.add(double.parse(token));
      } else {
        // If it's an operator, handle the operation
        while (operators.isNotEmpty &&
            _precedence(operators.last) >= _precedence(token)) {
          double right = numbers.removeLast();
          double left = numbers.removeLast();
          String op = operators.removeLast();
          numbers.add(_applyOperator(left, right, op));
          if(kDebugMode) {
            debugPrint('${right}');
            debugPrint('${left}');
            debugPrint('${op}');
          }
        }

        operators.add(token);
      }
    }
    while (operators.isNotEmpty) {
      double right = numbers.removeLast();
      double left = numbers.removeLast();
      String op = operators.removeLast();
      numbers.add(_applyOperator(left, right, op));
    }

    // The result will be the last number left in the numbers stack
    return '${numbers.last}';
  }

  int _precedence(String operator) {
    switch (operator) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
        return 2;
      default:
        return 0;
    }
  }

  double _applyOperator(double left, double right, String operator) {
    switch (operator) {
      case '+':
        return left + right;
      case '-':
        return left - right;
      case '*':
        return left * right;
      case '/':
        return left / right;
      case '%':
        return left % right;
      default:
        throw Exception('Invalid operator: $operator');
    }
  }

  @override
  void dispose() {
    super.dispose();
    compController.dispose();
  }

  void errorShake(){
    compController.clear();
  }

  List<String> splitIntoTokens(String expression) {

    // Regular expression to match numbers and operators
    RegExp regExp = RegExp(r'(\d+(\.\d+)?|\+|\-|\*|\/|%)');

  // Find all matches
    Iterable<Match> matches = regExp.allMatches(expression);

  // Extract the matched numbers and operators
    List<String> tokens = matches.map((match) => match.group(0)!).toList();
    if(kDebugMode){debugPrint('${tokens}');}
        return tokens; // Output: [12, +, 12, -, 1, /, 3]
  }


}
