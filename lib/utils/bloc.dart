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
//     yield CounterState(current.count + by);
//   }
//   
//   @override
//   toString() => "CounterIncrementEvent(by: $by)";
// }


abstract class BlocEvent<S, B extends BaseBloc>
    extends Equatable {
  BlocEvent([List props = const []]) : super(props);

  Stream<S> toState(S current, B bloc);
}

class BaseBloc<S> extends Bloc<BlocEvent<S, BaseBloc>, S> {
  BaseBloc([this._initialState]) : super();

  final S _initialState;

  @override
  S get initialState => _initialState;

  @override
  Stream<S> mapEventToState(BlocEvent<S, dynamic> event) async* {
    yield* event.toState(currentState, this);
  }

  @override
  void onEvent(event) {
    print("\n");
    print("======");
    print("Event dispatched for bloc: $this");
    print("\tevent: $event");
    print("\t currentState: $currentState");
    print("======");
    print("\n");
  }

  @override
  void onTransition(transition) {
    print("\n");
    print("======");
    print("Event successfully dispatched for bloc: $this");
    print("\tevent: ${transition.event}");
    print("\tcurrentState: ${transition.currentState}");
    print("\tnextState: ${transition.nextState}");
    print("======");
    print("\n");
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print("\n");
    print("======");
    print("Error occured while dispatching event for bloc: $this");
    print("\terror: $error");
    print("\tstacktrace: $stacktrace");
    print("======");
    print("\n");
  }

  @override
  String toString() => runtimeType.toString();
}
