import 'dart:io';

void main() {
  performTasks();
}

Future<void> performTasks() async {
  task1();
  String task2data = await task2();
  task3(task2data);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  Duration threeSeconds = const Duration(seconds: 3);

  return await Future.delayed(threeSeconds, () {
    print('Task 2 complete');
    return 'task 2 data'; // ✅ Return the value properly
  });
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2Data');
}
