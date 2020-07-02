part of 'initial_bloc.dart';

abstract class InitialState extends Equatable {
  const InitialState();
  @override
  List<Object> get props => [];
}

class StartingState extends InitialState {}

class ShowSampleEventState extends InitialState {
  final List<Widget> widgets;
  const ShowSampleEventState(this.widgets);

  @override
  List<Object> get props => [widgets];
}
