import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_scan_parser/repository/stocks/stocks_repo.dart';

import '../data/model/stocks_list.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final _stocksRepo = StocksRepo();
  StocksBloc() : super(StocksInitial()) {
    on<StocksFetchDataEvent>(_fetchStocksList);
  }
  FutureOr<void> _fetchStocksList(
      StocksEvent event, Emitter<StocksState> emit) async {
    if (event is StocksFetchDataEvent) {
      emit(StocksLoading());
      await _stocksRepo.getStocksData().onError((error, stackTrace) {
        log(error.toString());
        emit(StocksError(error.toString()));
      }).then((value) {
        StocksList stocksList = StocksList.fromJson(value);
        if (stocksList.data.isNotEmpty) {
          emit(StocksLoaded(stocksList));
        } else {
          emit(StocksError("No data found"));
        }
      });
    }
  }
}
