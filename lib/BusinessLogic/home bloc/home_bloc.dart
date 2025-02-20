import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(selectedIndex: 0)) {
    on<ItemTapped>((event, emit) {
      emit(HomeState(selectedIndex: event.index));
    });
  }
}
