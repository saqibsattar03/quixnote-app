import 'package:flutter/material.dart';


class NoDataWidget extends StatelessWidget {
   const NoDataWidget({super.key,required this.message});

  final String message;
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Center(
      child: Text(message,style: textTheme.titleMedium!.copyWith(),),
    );
  }
}
