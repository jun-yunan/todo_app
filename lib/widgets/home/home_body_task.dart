import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_app/controllers/new_task_controller.dart';
// import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/task_/task_item.dart';

class HomeBodyTask extends StatefulWidget {
  const HomeBodyTask({super.key});

  @override
  State<HomeBodyTask> createState() => _HomeBodyTaskState();
}

class _HomeBodyTaskState extends State<HomeBodyTask> {
  final NewTaskController newTaskController = Get.put(NewTaskController());
  int? selectedDayIndex;
  late DateTime now;

  late String currentMonthName;

  late List<DateTime> daysOfWeek;

  List<DateTime> getDaysOfWeek(DateTime currentDate) {
    List<DateTime> days = [];
    int currentDayOfWeek = currentDate.weekday;
    for (int i = 1; i <= 7; i++) {
      int difference = i - currentDayOfWeek;
      DateTime newDay = currentDate.add(Duration(days: difference));
      days.add(newDay);
    }
    return days;
  }

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    currentMonthName = DateFormat('MMMM').format(now);
    daysOfWeek = getDaysOfWeek(now);

    for (int index = 0; index < daysOfWeek.length; index++) {
      if (DateFormat("dd").format(daysOfWeek[index]) ==
          DateFormat("dd").format(DateTime.now())) {
        selectedDayIndex = index;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentMonthName,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat("dd").format(DateTime.now()) ==
                            DateFormat("dd")
                                .format(daysOfWeek[selectedDayIndex ?? 0])
                        ? "Today"
                        : DateFormat("EEEE")
                            .format(daysOfWeek[selectedDayIndex ?? 0]),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: daysOfWeek.asMap().entries.map((entry) {
              int index = entry.key;
              DateTime day = entry.value;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDayIndex = index;
                    newTaskController.selectedDayIndex.value = index;
                    print(
                      DateFormat("EEE dd MMMM yyyy").format(
                        newTaskController.daysOfWeek[
                            newTaskController.selectedDayIndex.value],
                      ),
                    );
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: selectedDayIndex == index
                        ? Colors.cyan.shade200
                        : Colors.transparent,
                    border: DateFormat("dd").format(DateTime.now()) ==
                            DateFormat("dd").format(day)
                        ? Border.all(color: Colors.grey)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('EEE').format(day),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat('dd').format(day),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 25,
          ),
          Obx(
            () => StreamBuilder(
              // stream: newTaskController.getTasksByUserStream(),
              stream: newTaskController.getTaskList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No data."),
                  );
                }
                newTaskController.taskListByUser.assignAll(snapshot.data!);
                return ListView.builder(
                  itemCount: newTaskController.taskListByUser.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TaskItem(
                      index: index,
                      key: ValueKey(newTaskController.taskListByUser[index].id),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
