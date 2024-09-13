import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_event.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_state.dart';
import 'package:ui_tasks/core/repository/work_repository.dart';

// bloc of add work screen
class AddWorkScreenBloc extends Bloc<AddWorkScreenEvent, AddWorkScreenState> {
  final WorkRepository workRepository;

  AddWorkScreenBloc({required this.workRepository})
      : super(AddWorkScreenInitialState()) {
    /// event handler for open calender event
    on<OpenCalenderEvent>(openCalenderEvent);

    /// event handler for add work button clicked event
    on<AddWorkButtonClickedEvent>(addWorkButtonClickedEvent);

    /// event handler to rebuild entire screen
    on<RebuildAddWorkScreenEvent>(rebuildAddWorkScreenEvent);
  }

  FutureOr<void> openCalenderEvent(OpenCalenderEvent event, Emitter emit) {
    emit(OpenCalenderState(index: event.index));
  }

  FutureOr<void> addWorkButtonClickedEvent(
      AddWorkButtonClickedEvent event, Emitter<AddWorkScreenState> emit) {
    emit(AddWorkScreenButtonClickedState());
  }

  FutureOr<void> rebuildAddWorkScreenEvent(
      RebuildAddWorkScreenEvent event, Emitter<AddWorkScreenState> emit) {
    emit(AddWorkScreenInitialState());
  }

  // Method to get data from repository
  Map<int, Map<String, String>> getData() {
    return workRepository.getData();
  }
}
