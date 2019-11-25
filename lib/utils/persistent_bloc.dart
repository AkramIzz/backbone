import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class BlocEvent<S, B extends PersistentBloc>
    extends Equatable {
  BlocEvent([List props = const []]) : super(props);

  Stream<S> toState(S current, B bloc);
}

abstract class PersistentBloc<S> extends HydratedBloc<BlocEvent<S, PersistentBloc>, S> {
  PersistentBloc([this._initialState]) : super();

  final S _initialState;

  @override
  S get initialState {
    final savedState = super.initialState;
    print('\n');
    print('=======');
    if (savedState == null) {
      print("\tNo saved state found for bloc: $runtimeType");
    } else {
      print("\tLoaded saved state successfully for bloc: $runtimeType");
      print("\t$savedState");
    }
    print('=======');
    print('\n');
    return savedState ?? _initialState;
  }

  @override
  Stream<S> mapEventToState(BlocEvent<S, dynamic> event) async* {
    yield* event.toState(state, this);
  }

  @override
  void onEvent(event) {
    print("\n");
    print("======");
    print("Event dispatched for bloc: $this");
    print("\tevent: $event");
    print("\t currentState: $state");
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
