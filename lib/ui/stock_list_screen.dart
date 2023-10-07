import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_scan_parser/bloc/stocks_bloc.dart';
import 'package:stock_scan_parser/data/model/stocks_list.dart';
import 'package:stock_scan_parser/res/app_context_extension.dart';
import 'package:stock_scan_parser/ui/stock_detail_screen.dart';

import 'widget/app_widgets.dart';

class StockListScreen extends StatefulWidget {
  static const String id = "stock_list_screen";
  const StockListScreen({super.key, required this.title});

  final String title;

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  late StocksBloc stocksBloc;
  List<Stock> _stocksList = <Stock>[];

  @override
  void initState() {
    super.initState();
    stocksBloc = BlocProvider.of<StocksBloc>(context);
    stocksBloc.add(StocksFetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(
          context, context.resources.strings?.homeTitle ?? ""),
      body: BlocConsumer<StocksBloc, StocksState>(
          listener: (context, state) => {},
          builder: (context, state) {
            if (kDebugMode) {
              log("${StockListScreen.id} -->> $state");
            }
            if (state is StocksLoading) {
              return AppWidgets.getCenterLoadingView();
            } else if (state is StocksLoaded) {
              if (state.data.data.isNotEmpty) {
                _stocksList = state.data.data;
              } else {
                return AppWidgets.getBuildNoResult(
                    context, context.resources.strings?.noStocksFound ?? "");
              }
            } else if (state is StocksError) {
              return AppWidgets.getBuildNoResult(context, state.errorMessage);
            }
            return _stocksListView();
          }),
    );
  }

  Widget _stocksListView() {
    return ListView.builder(
      itemCount: _stocksList.length,
      itemBuilder: (context, index) {
        return _stocksListItems(_stocksList[index]);
      },
    );
  }

  Widget _stocksListItems(Stock stock) {
    return Card(
      child: ListTile(
        title: Text(
          stock.name,
          style: context.resources.style.headingTextStyle,
        ),
        subtitle: Text(stock.tag,
            style: context.resources.style.subHeadingTextStyle
                .copyWith(color: stock.color)),
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(StockDetailsScreen.id, arguments: stock);
        },
      ),
    );
  }
}
