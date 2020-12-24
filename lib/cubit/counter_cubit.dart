import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'counter_state.dart';


class CounterCubit extends HydratedCubit<CounterState>  {
  CounterCubit() : super(CounterState(counterValue: 0));

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1,));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1));

  @override
  CounterState fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);}

  @override
  Map<String, dynamic> toJson(CounterState state) {
    return state.toMap();}

}