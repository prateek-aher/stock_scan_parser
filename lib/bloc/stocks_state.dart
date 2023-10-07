part of 'stocks_bloc.dart';

@immutable
sealed class StocksState {}

final class StocksInitial extends StocksState {}

final class StocksLoading extends StocksState {}

final class StocksLoaded extends StocksState {
  late final StocksList data;
  StocksLoaded(this.data);
}

final class StocksError extends StocksState {
  late final String errorMessage;
  StocksError(this.errorMessage);
}
