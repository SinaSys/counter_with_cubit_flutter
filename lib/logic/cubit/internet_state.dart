import 'package:counter_with_cubit_flutter/constants/enum.dart';
import 'package:flutter/material.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({@required this.connectionType});
}

class InternetDisconnected extends InternetState {}