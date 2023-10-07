import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stock_scan_parser/data/model/stocks_list.dart';
import 'package:stock_scan_parser/res/app_context_extension.dart';

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
                              //TODO: Ridirect to values screen to display values in decresing order
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
                            //TODO: Ridirect to set parameter screen to display to input parameter value
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
