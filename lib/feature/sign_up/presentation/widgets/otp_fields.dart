import 'package:flutter/material.dart';

class OTPTextFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool isOtpInvalid;
  final Function(String value, int index) onOtpChanged;

  const OTPTextFields({
    Key? key,
    required this.controllers,
    required this.focusNodes,
    required this.isOtpInvalid,
    required this.onOtpChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 50,
          child: TextField(
            cursorColor: Colors.white,
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            onChanged: (value) => onOtpChanged(value, index),
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isOtpInvalid
                      ? const Color(0xFFF71756)
                      : const Color.fromARGB(
                          20,
                          255,
                          255,
                          255,
                        ),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isOtpInvalid
                      ? const Color(0xFFF71756)
                      : Colors.amber.shade200,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      }),
    );
  }
}
