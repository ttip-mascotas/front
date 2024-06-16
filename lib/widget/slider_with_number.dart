import "package:flutter/material.dart";

class SliderWithNumber extends StatelessWidget {
  final int divisions;
  final double max;
  final double min;
  final double value;
  final void Function(double) onChanged;
  final String text;

  const SliderWithNumber({
    required this.value,
    required this.max,
    required this.min,
    required this.divisions,
    required this.onChanged,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Center(
                child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ))),
        Expanded(
          child: Slider(
            value: value,
            max: max,
            min: min,
            divisions: divisions,
            label: value.round().toString(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
