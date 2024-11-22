import 'package:flutter/material.dart';

class InputSwitch extends StatelessWidget {
  const InputSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: value
                ? Colors.black54.withOpacity(0.75) 
                : Colors.black.withOpacity(0.4),
            
          ),
        ),
        SizedBox(
          width: 50,
          child: Transform.scale(
            scale: 0.8,
            alignment: Alignment.centerRight,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color.fromARGB(255, 213, 97, 2),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color.fromARGB(255, 220, 220, 220),
              hoverColor: Colors.black26,
              focusColor: Colors.black,
              splashRadius: 24.0,
            ),
          ),
        ),
      ],
    );
  }
}
