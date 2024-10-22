part of 'data_cubit.dart';

class DataState extends Equatable {
  const DataState({this.taskStatus = false, this.list = const []});

  final bool? taskStatus;
  final List<int>? list;

  DataState copyWith({
    bool? taskStatus,
    List<int>? list,
  }) {
    return DataState(
      taskStatus: taskStatus ?? this.taskStatus,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [taskStatus, list];
}
