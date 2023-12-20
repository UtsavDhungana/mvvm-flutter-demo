import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_state_management_app/mvvm/observer.dart';
import 'package:mvvm_state_management_app/task/domain/repository.dart';
import 'package:mvvm_state_management_app/task/presentation/viewmodels/task_view_model.dart';

import '../../data/model.dart';

class TodoViewScreen extends StatefulWidget {
  const TodoViewScreen({super.key});

  @override
  State<TodoViewScreen> createState() => _TodoViewScreenState();
}

class _TodoViewScreenState extends State<TodoViewScreen>
    implements EventObserver {
  final TaskViewModel _viewModel = TaskViewModel(TaskRepository());
  bool _isLoading = false;
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TaskApp 2000"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _viewModel.loadTask();
          },
          child: const Icon(Icons.refresh),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tasks[index].title),
                    subtitle: Text(_tasks[index].description),
                  );
                },
              ));
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is TasksLoadedEvent) {
      setState(() {
        _tasks = event.task;
      });
    }
  }
}
