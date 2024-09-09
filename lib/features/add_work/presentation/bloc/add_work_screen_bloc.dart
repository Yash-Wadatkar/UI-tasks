import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_event.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_state.dart';

// bloc of add work screen
class AddWorkScreenBloc extends Bloc<AddWorkScreenEvent, AddWorkScreenState> {
  AddWorkScreenBloc() : super(AddWorkScreenInitialState()) {
    /// event handler for open calender event
    on<OpenCalenderEvent>(openCalenderEvent);
  }

  FutureOr<void> openCalenderEvent(OpenCalenderEvent event, Emitter emit) {
    emit(OpenCalenderState(index: event.index));
  }
}
