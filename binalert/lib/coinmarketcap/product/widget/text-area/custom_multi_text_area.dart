import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/core/component/fitted/fitted_label_medium_text.dart';
import 'package:binalert/coinmarketcap/core/extension/context_extension.dart';
import 'package:binalert/coinmarketcap/product/widget/fitted/fitted_small_text.dart';

class CustomMultiTextArea extends StatelessWidget {
  const CustomMultiTextArea({
    required this.title,
    required this.description,
    super.key,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.multiTextHeight,
      width: context.quarterWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedSmallLabetTextManatee(text: title),
          FittedMediumLabelText(text: description),
        ],
      ),
    );
  }
}
