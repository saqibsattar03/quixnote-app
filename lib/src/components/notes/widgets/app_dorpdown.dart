import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DropDownFormField<T> extends StatefulWidget {
  const DropDownFormField({
    super.key,
    required this.onChangeVal,
    this.icon,
    this.label,
    this.errorText,
    this.labelTextColor,
    this.value,
    required this.decoration,
    required this.items,
  });

  final IconData? icon;
  final String? label;
  final String? errorText;
  final Color? labelTextColor;
  final Function(T? value) onChangeVal;
  final T? value;
  final InputDecoration decoration;
  final List<DropdownMenuItem<T>> items;

  @override
  State<DropDownFormField<T>> createState() => _DropDownFormFieldState<T>();
}

class _DropDownFormFieldState<T> extends State<DropDownFormField<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant DropDownFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField(
      value: _value,
      decoration: widget.decoration,
      icon: null,
      items: widget.items,
      onChanged: _onChange,
      validator: (value) {
        if (value == null) {
          print('Here');
          return widget.errorText ?? "";
        }
        return null;
      },
    );
  }

  void _onChange(T? v) {
    _value = v;
    setState(() {});
    widget.onChangeVal(_value);
  }
}
