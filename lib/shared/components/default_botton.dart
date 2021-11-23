import 'package:flutter/material.dart';
class DefaultButton extends StatelessWidget {
  Function function;
  double width;
  String text;
  double height;
  DefaultButton({
    required this.function,
    required this.text,
    required this.height,
    this.width = double.infinity,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed:(){
          function();
        },
        color: Colors.blue,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
      ),
    );
  }
}
