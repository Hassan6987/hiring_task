part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class ItemTapped extends HomeEvent {
  final int index;

  const ItemTapped(this.index);

  @override
  List<Object> get props => [index];
}
