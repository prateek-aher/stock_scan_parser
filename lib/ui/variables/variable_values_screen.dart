import 'package:flutter/material.dart';
import 'package:stock_scan_parser/res/app_context_extension.dart';
import 'package:stock_scan_parser/res/dimensions/app_dimensions.dart';
import 'package:stock_scan_parser/ui/widget/app_widgets.dart';

class VariableValuesScreen extends StatelessWidget {
  static const String id = "variable_values_screen";

  final List<num> values;
  const VariableValuesScreen({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    values.sort(
        // (a, b) => b.compareTo(a),
        );
    return Scaffold(
      appBar: AppWidgets.getAppBar(context, ""),
      body: ListView.builder(
        padding: EdgeInsets.all(AppDimension().defaultMargin),
        itemCount: values.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            values[index].toString(),
            style: context.resources.style.subHeadingTextStyle,
          ),
        ),
      ),
    );
  }
}
