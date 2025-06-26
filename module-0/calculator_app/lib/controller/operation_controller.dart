import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class OperationController {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController resultController = TextEditingController();

  void operation(BuildContext context, String val) {
    if (val == "<-") {
      if (inputController.text.isEmpty) return;
      inputController.text = inputController.text.substring(
        0,
        inputController.text.length - 1,
      );
    } else if (val == "C") {
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
          "Make sure your operation doesn't contain invalid characters and doesn't have two operators next to each other.\nExample: 6*/5 ...",
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
    if (val.trim().isEmpty) {
      return true;
    }

    val = val.replaceAll(' ', '');
    final String exp = "+/*";

    List<String> op = val.split("");

    if (exp.contains(op[op.length - 1]) ||
        op[op.length - 1] == "-" ||
        exp.contains(op[0])) {
      return true;
    }

    for (var i = 0; i < op.length; i++) {
      if (_isDigit(op[i])) continue;

      if (op[i] == ".") {
        if (!_isDigit(op[i + 1])) return true;
      } else if (exp.contains(op[i])) {
        if (i - 1 >= 0 &&
            i + 1 < op.length &&
            op[i] != "-" &&
            op[i + 1] != "-" &&
            (!_isDigit(op[i - 1]) || !_isDigit(op[i + 1]))) {
          return true;
        }
      }

      if (op[i] == "-" && i < val.length && !_isDigit(op[i + 1])) return true;
    }

    return false;
  }

  bool _isDigit(String character) {
    if (character.isEmpty) return false;
    int code = character.codeUnitAt(0);
    return code >= 48 && code <= 57;
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: DialogThemeData(backgroundColor: Colors.red.shade100),
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
