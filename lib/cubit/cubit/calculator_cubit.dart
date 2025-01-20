import 'package:bloc/bloc.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  void calculate(String input) async {
    emit(CalculatorLoading());
    try {
     
      String result = processCalculation(input);
      emit(CalculatorSuccess(result: result));
    } catch (e) {
      emit(CalculatorError());
    }
  }

  String processCalculation(String input) {
  
    return input.isNotEmpty ? (double.tryParse(input) ?? 0).toString() : 'Error';
  }
}
