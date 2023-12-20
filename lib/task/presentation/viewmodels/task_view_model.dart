import '../../../mvvm/viewmodel.dart';
import '../../../mvvm/observer.dart';
import '../../domain/repository.dart';
import '../../data/model.dart';

class TaskViewModel extends EventViewModel {
  TaskRepository _repository;
  TaskViewModel(this._repository);

  void loadTask() async {
    notify(LoadingEvent(isLoading: true));
    final resp = await _repository.loadTask();
    notify(TasksLoadedEvent(task: resp));
    notify(LoadingEvent(isLoading: false));
  }
}

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class TasksLoadedEvent extends ViewEvent {
  final List<Task> task;
  TasksLoadedEvent({required this.task}) : super("TasksLoadedEvent");
}

class TaskCreatedEvent extends ViewEvent {
  final Task task;
  TaskCreatedEvent(this.task) : super("TaskCreatedEvent");
}
