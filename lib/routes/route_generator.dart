import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_scan_parser/bloc/stocks_bloc.dart';
import 'package:stock_scan_parser/data/model/stocks_list.dart';
import 'package:stock_scan_parser/ui/stock_detail_screen.dart';
import 'package:stock_scan_parser/ui/stock_list_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case StockListScreen.id:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<StocksBloc>.value(
            value: StocksBloc(),
            child: const StockListScreen(title: 'Stock Scan Parser'),
          ),
        );
      case StockDetailsScreen.id:
        return MaterialPageRoute(
          builder: (context) {
            return StockDetailsScreen(stockData: args as Stock);
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: const Center(
              child: Text('Error while loading new page'),
            ),
          ),
        );
    }
  }
}
