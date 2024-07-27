import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  const OptionCard(this.optionName, this.children, {super.key});

  final String optionName;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
                Row(
                  children: [
                    Text(optionName),
                  ],
                ),
                const SizedBox(height: 8),
              ] +
              children,
        ),
      ),
    );
  }
}
