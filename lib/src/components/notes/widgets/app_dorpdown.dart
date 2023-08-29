import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDownFormField<T> extends StatefulWidget {
  const DropDownFormField({
    super.key,
    required this.data,
    required this.onChangeVal,
    this.icon,
    this.label,
    this.errorText,
    this.labelTextColor,
    this.value,
    required this.decoration,
  });

  final List<T> data;
  final IconData? icon;
  final String? label;
  final String? errorText;
  final Color? labelTextColor;
  final Function(T? value) onChangeVal;
  final T? value;
  final InputDecoration decoration;

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
      items: widget.data.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Row(
            children: [
              // SvgPicture.asset(AppAssets.logoIcon),
              // const SizedBox(width: 5),
              Text(
                item.toString(),
                style: textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: _onChange,
      validator: ((value) {
        if (value.toString().isEmpty) {
          return widget.errorText ?? "";
        }
        return null;
      }),
    );
  }

  void _onChange(T? v) {
    _value = v;
    setState(() {});
    widget.onChangeVal(_value);
  }
}