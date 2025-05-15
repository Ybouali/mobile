import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class OperationController {
  final logger = Logger();

  final TextEditingController inputController = TextEditingController();
  final TextEditingController resultController = TextEditingController();

  void operation(BuildContext context, String val) {
    if (val == "C") {
      inputController.clear();
    } else if (val == "AC") {
      inputController.clear();
      resultController.clear();
    } else if (val == "=") {
      // check for error's
      if (_errorHandling(inputController.text)) {
        // Show a popup for the error
        showErrorDialog(
          context,
          "Make sure your operation doesn't contain invalid characters and doesn't have two operators next to each other.\nExample: 6*/5",
        );
      } else {
        // do the operatios
        _handleOperationAndSetResult();
      }
    } else {
      inputController.text += val;
    }
  }

  void _handleOperationAndSetResult() {
    final expression = Expression.parse(inputController.text);

    final eva = const ExpressionEvaluator();
    resultController.text = eva.eval(expression, {}).toString();
  }

  bool _errorHandling(String val) {
    String op = "+-/*";

    if (val.endsWith(op)) {
      return true;
    }

    for (var i = 0; i < val.length; i++) {
      if (op.contains(val[i]) || val[i] == "%") {
        if (i + 1 < val.length) {
          i += 1;
        }
        if (op.contains(val[i]) || val[i] == "%") {
          return true;
        }
      } else if (!_isDigit(val[i])) {
        return true;
      }
    }

    return false;
  }

  bool _isDigit(String char) {
    return char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => Theme(
            data: Theme.of(context).copyWith(
              dialogTheme: DialogThemeData(
                backgroundColor: Colors.red.shade100,
              ),
            ),
            child: AlertDialog(
              title: const Text("Error"),
              content: Text(message),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
