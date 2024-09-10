// bloc of add work item screen

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_event.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_state.dart';

class AddWorkItemBloc extends Bloc<AddWorkItemEvent, AddWorkItemState> {
  AddWorkItemBloc() : super(AddWorkItemScreenInitialState()) {
    /// event handler for open calender event
    on<OpenCalenderEvent>(openCalenderEvent);
  }

  FutureOr<void> openCalenderEvent(
      OpenCalenderEvent event, Emitter<AddWorkItemState> emit) {
    emit(OpenCalenderSate());
  }
}
