import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/product/init/locale/project_keys.dart';
import 'package:binalert/coinmarketcap/product/widget/text-area/custom_multi_text_area.dart';
import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';

class DayLowView extends StatelessWidget {
  const DayLowView({
    required this.crypto,
    super.key,
  });

  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return CustomMultiTextArea(
      title: ProjectKeys.twentyFourHourLowEuro,
      description: crypto.quote?.uSD?.percentChange30d?.toStringAsFixed(2) ?? ProjectKeys.notFound,
    );
  }
}
