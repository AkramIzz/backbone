import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Example Usage: The infamous flutter counter example
//
// class CounterBloc extends BaseBloc<CounterState> {
//   CounterBloc() : super(CounterState(0));
// } // or just use BaseBloc<CounterState>(CounterState(0))
//   // or let the event.toState handle null current state.
//
// class CounterState extends BlocState {
//   int count;
//
//   CounterState([this.count = 0]) : super([count]);
//   
//   @override
//   toString() => "CounterState(count: $count)";
// }
//
// class CounterIncrementEvent extends BlocEvent<CounterState, CounterBloc> {
//   final int by;
//   
//   CounterIncrementEvent({this.by = 1}) : super([by])
//
//   @override
//   toState(current, bloc) {
//     return CounterState(current.count + by);
//   }
//   
//   @override
//   toString() => "CounterIncrementEvent(by: $by)";
// }


abstract class BlocEvent<S extends BlocState, B extends BaseBloc>
    extends Equatable {
  BlocEvent([List props = const []]) : super(props);

  S toState(S current, B bloc);
}

abstract class BlocState extends Equatable {
  BlocState([List props = const []]) : super(props);
}

class BaseBloc<S extends BlocState> extends Bloc<BlocEvent, S> {
  BaseBloc([this._initialState]);

  final S _initialState;

  @override
  S get initialState => _initialState;

  @override
  Stream<S> mapEventToState(BlocEvent event) async* {
    yield event.toState(currentState, this);
  }

  @override
  void onEvent(event) {
    print("-----");
    print("Event dispatched for bloc: $this");
    print("\tevent: $event");
    print("\t currentState: $currentState");
    print("-----");
  }

  @override
  void onTransition(transition) {
    print("");
    print("-----");
    print("Event successfully dispatched for bloc: $this");
    print("\tevent: ${transition.event}");
    print("\tcurrentState: ${transition.currentState}");
    print("\tnextState: ${transition.nextState}");
    print("-----");
    print("");
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print("");
    print("-----");
    print("Error occured while dispatching event for bloc: $this");
    print("\terror: $error");
    print("\tstacktrace: $stacktrace");
    print("-----");
    print("");
  }

  @override
  String toString() => runtimeType.toString();
}