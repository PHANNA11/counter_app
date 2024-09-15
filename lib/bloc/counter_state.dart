part of 'counter_bloc.dart';

class CounterState {
  CounterState({required this.number});
  int? number;
}

final class CounterInitial extends CounterState {
  CounterInitial() : super(number: 0);
}
