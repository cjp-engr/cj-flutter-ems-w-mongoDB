import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'side_navigation_event.dart';
part 'side_navigation_state.dart';

class SideNavigationBloc
    extends Bloc<SideNavigationEvent, SideNavigationState> {
  SideNavigationBloc() : super(SideNavigationState.initial()) {
    on<SwitchActivePageEvent>((event, emit) {
      emit(state.copyWith(activePage: event.activePage));
    });
  }
}
