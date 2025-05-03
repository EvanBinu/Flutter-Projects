import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
);

class RoundedButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;

  const RoundedButton({
    required this.color,
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 50.0,
          child: Text(title),
        ),
      ),
    );
  }
}

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final ValueChanged<String> onChanged;

  const RoundedTextField({
    required this.hintText,
    required this.onChanged,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
