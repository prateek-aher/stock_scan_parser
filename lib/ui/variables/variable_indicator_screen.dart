import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_scan_parser/data/model/stocks_list.dart';
import 'package:stock_scan_parser/res/app_context_extension.dart';
import 'package:stock_scan_parser/ui/widget/app_widgets.dart';

class VariableIndicatorScreen extends StatelessWidget {
  static const String id = "variable_indicator_screen";

  final Variable variable;
  const VariableIndicatorScreen({super.key, required this.variable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(
          context, variable.studyType?.toUpperCase() ?? ""),
      body: Padding(
        padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.resources.strings?.setParameters ?? "",
              style: context.resources.style.subHeadingTextStyle,
            ),
            AppWidgets.getDefaultSizedBox(context),
            Row(
              children: [
                Expanded(
                  child: Text(
                    (variable.parameterName?.substring(0, 1).toUpperCase() ??
                            "") +
                        (variable.parameterName?.substring(1).toLowerCase() ??
                            ""),
                    style: context.resources.style.drawerTextStyle,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  initialValue: variable.defaultValue?.toString(),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => ((num.tryParse(value ?? "") ?? 0) >=
                              (variable.minValue ?? 0)) &&
                          ((num.tryParse(value ?? "") ?? 0) <=
                              (variable.maxValue ?? 0))
                      ? null
                      : "Enter between ${variable.minValue} and ${variable.maxValue}",
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
