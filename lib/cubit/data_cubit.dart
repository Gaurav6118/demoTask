import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(const DataState());

  void loadItem() async {
    emit(state.copyWith(taskStatus: false));

    await Future.delayed(const Duration(seconds: 1));

    int nextItemIndex = state.list!.length;
    List<int> newItems = List.generate(
      11,
      (index) => nextItemIndex + index + 1,
    );

    List<int> updatedList = List<int>.from(state.list!)..addAll(newItems);

    emit(state.copyWith(list: updatedList, taskStatus: true));
  }

  void removeItem(int index) {
    debugPrint('index $index');
    state.list!.removeWhere((element) => element == index);
    emit(state.copyWith(list: state.list, taskStatus: true));
  }
}
