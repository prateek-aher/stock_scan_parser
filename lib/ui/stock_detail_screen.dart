import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stock_scan_parser/data/model/stocks_list.dart';
import 'package:stock_scan_parser/res/app_context_extension.dart';
import 'package:stock_scan_parser/ui/variables/variable_indicator_screen.dart';
import 'package:stock_scan_parser/ui/variables/variable_values_screen.dart';

import 'widget/app_widgets.dart';

class StockDetailsScreen extends StatelessWidget {
  static const String id = "news_detail_screen";
  final Stock stockData;
  const StockDetailsScreen({super.key, required this.stockData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(context, stockData.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stockData.tag,
                style: context.resources.style.headingTextStyle
                    .copyWith(color: stockData.color),
              ),
              ...stockData.criteria.map((criterion) {
                Widget getTitle() {
                  if (criterion.type == CriteriaType.plainText) {
                    return Text(
                      criterion.text,
                      style: context.resources.style.subHeadingTextStyle,
                    );
                  }
                  return Wrap(
                    children: criterion.text.split(" ").map((word) {
                      if (criterion.variable?.keys.contains(word) ?? false) {
                        log("$word : ${criterion.variable?[word]?.type?.text}");
                        if (criterion.variable?[word]?.type ==
                            VariableType.value) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, VariableValuesScreen.id,
                                  arguments: criterion.variable?[word]?.values
                                          ?.toSet()
                                          .toList() ??
                                      <num>[]);
                            },
                            child: Text(
                              "${(criterion.variable?[word]?.values?.isNotEmpty ?? false) ? "(${criterion.variable?[word]?.values?.first.toString() ?? ""})" : word} ",
                              style: context.resources.style.linkTextStyle
                                  .copyWith(
                                      decoration: TextDecoration.underline),
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, VariableIndicatorScreen.id,
                                arguments: criterion.variable?[word]);
                          },
                          child: Text(
                            "(${(criterion.variable?[word]?.defaultValue)}) ",
                            style: context.resources.style.linkTextStyle
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        );
                      }
                      return Text(
                        "$word ",
                        style: context.resources.style.subHeadingTextStyle,
                      );
                    }).toList(),
                  );
                }

                return Card(
                  child: ListTile(
                    title: getTitle(),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
