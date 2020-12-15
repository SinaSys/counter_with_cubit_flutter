import 'dart:async';
import 'package:counter_with_cubit_flutter/constants/enum.dart';
import 'package:counter_with_cubit_flutter/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_cubit.dart';
import 'counter_state.dart';
import 'internet_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription internetStreamSubscription;

  CounterCubit({@required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  StreamSubscription monitorInternetCubit() {
    return internetStreamSubscription = internetCubit.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi)
        increment();
      else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) decrement();
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  Future<Function> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
