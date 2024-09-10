import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_event.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_state.dart';

// bloc of add work screen
class AddWorkScreenBloc extends Bloc<AddWorkScreenEvent, AddWorkScreenState> {
  AddWorkScreenBloc() : super(AddWorkScreenInitialState()) {
    /// event handler for open calender event
    on<OpenCalenderEvent>(openCalenderEvent);

    /// event handler for add work button clicked event
    on<AddWorkButtonClickedEvent>(addWorButtonClickedEvent);

    /// event handler to rebuild entire screen
    on<RebuildAddWorkScreenEvent>(rebuildAddWorkScreenEvent);
  }

  FutureOr<void> openCalenderEvent(OpenCalenderEvent event, Emitter emit) {
    emit(OpenCalenderState(index: event.index));
  }

  FutureOr<void> addWorButtonClickedEvent(
      AddWorkButtonClickedEvent event, Emitter<AddWorkScreenState> emit) {
    emit(AddWorkScreenButtonClickedState());
  }

  FutureOr<void> rebuildAddWorkScreenEvent(
      RebuildAddWorkScreenEvent event, Emitter<AddWorkScreenState> emit) {
    emit(AddWorkScreenInitialState());
  }
}
