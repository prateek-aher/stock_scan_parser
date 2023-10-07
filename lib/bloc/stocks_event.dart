part of 'stocks_bloc.dart';

@immutable
sealed class StocksEvent {}

class StocksFetchDataEvent extends StocksEvent {
  StocksFetchDataEvent();
}
