part of 'calculator_cubit.dart';

sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {}

final class CalculatorLoading extends CalculatorState {}

final class CalculatorSuccess extends CalculatorState {
  final String result;
  CalculatorSuccess({required this.result});
}

final class CalculatorError extends CalculatorState {}
