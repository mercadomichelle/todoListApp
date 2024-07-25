import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:appdev_proj/models/todo_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _calendarFormatLabel = "Month";

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    const primaryColor = Color.fromARGB(255, 250, 205, 126);
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CALENDAR',
          style: TextStyle(
            color: Color.fromARGB(255, 253, 199, 107),
            fontFamily: 'BebasNeue',
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 245, 186, 85),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 247, 198, 114),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              isDarkMode ? 'assets/images/bg3.jpg' : 'assets/images/bg1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Consumer<TodoModel>(
            builder: (context, model, child) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCalendar<Task>(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                              _showTasksForSelectedDay(
                                  context, model, selectedDay);
                            },
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                            eventLoader: (day) {
                              return model.tasks.where((task) {
                                return isSameDay(task.dueDate, day) &&
                                    task.type != 'stickyNote';
                              }).toList();
                            },
                            calendarStyle: CalendarStyle(
                              todayDecoration: const BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              todayTextStyle: TextStyle(
                                color: isDarkMode ? Colors.black : Colors.black,
                              ),
                              selectedTextStyle: TextStyle(
                                color: isDarkMode ? Colors.black : Colors.black,
                              ),
                              weekendTextStyle: TextStyle(
                                color: textColor,
                              ),
                              holidayTextStyle: TextStyle(
                                color: textColor,
                              ),
                            ),
                            headerStyle: const HeaderStyle(
                              titleTextStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              formatButtonVisible: false,
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: primaryColor,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: primaryColor,
                              ),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              weekendStyle: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 30,
                    right: 75,
                    child: ElevatedButton(
                      onPressed: _toggleCalendarFormat,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _calendarFormatLabel,
                        style: TextStyle(
                          color: isDarkMode ? Colors.black : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showTasksForSelectedDay(
      BuildContext context, TodoModel model, DateTime selectedDay) {
    const primaryColor = Color.fromARGB(255, 250, 205, 126);
    final tasks = model.tasks
        .where((task) =>
            isSameDay(task.dueDate, selectedDay) && task.type != 'stickyNote')
        .toList();

    if (tasks.isEmpty) {
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        side: BorderSide(color: primaryColor, width: 2),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;
            final backgroundColor =
                isDarkMode ? Colors.grey[900] : Colors.white;
            final textColor = isDarkMode ? Colors.white : Colors.black;
            final descriptionColor =
                isDarkMode ? Colors.grey[300] : Colors.black87;

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 14,
                            child: Text(
                              '${tasks.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            tasks.length == 1 ? 'Task' : 'Tasks',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          var task = tasks[index];
                          var taskTextColor =
                              task.completed ? Colors.green : Colors.red;
                          var borderColor =
                              task.completed ? Colors.green : Colors.red;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode ? Colors.grey[850] : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: borderColor, width: 2),
                            ),
                            child: ListTile(
                              title: Text(
                                task.title,
                                style: TextStyle(
                                  color: taskTextColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: task.completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Text(
                                _truncateDescription(task.description),
                                style: TextStyle(
                                  color: descriptionColor,
                                  decoration: task.completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: Checkbox(
                                value: task.completed,
                                onChanged: (bool? value) {
                                  setState(() {
                                    task.completed = value!;
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                    model.notifyListeners();
                                  });
                                },
                                checkColor: Colors.white,
                                activeColor: borderColor,
                              ),
                              onTap: () => _showTaskDetails(context, task),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showTaskDetails(BuildContext context, Task task) {
    const primaryColor = Color.fromARGB(255, 250, 205, 126);

    showDialog(
      context: context,
      builder: (context) {
        final brightness = Theme.of(context).brightness;
        final isDarkMode = brightness == Brightness.dark;
        final backgroundColor = isDarkMode ? Colors.black : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final descriptionColor = isDarkMode ? Colors.grey[300] : Colors.black87;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 600,
              maxWidth: 400,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: primaryColor),
                            const SizedBox(width: 5),
                            Text(
                              'Date: ${_formattedDate(task.dueDate)}',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: primaryColor),
                        const SizedBox(height: 10),
                        const Text(
                          'Description:',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          task.description ?? 'No description',
                          style: TextStyle(
                            color: descriptionColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  task.completed ? 'Completed' : 'Incomplete',
                  style: TextStyle(
                    color: task.completed ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _truncateDescription(String? description) {
    if (description == null || description.length <= 50) {
      return description ?? 'No description';
    }
    return '${description.substring(0, 50)}...'; // Truncate and add ellipsis
  }

  String _formattedDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  void _toggleCalendarFormat() {
    setState(() {
      switch (_calendarFormat) {
        case CalendarFormat.month:
          _calendarFormat = CalendarFormat.twoWeeks;
          _calendarFormatLabel = "2 Weeks";
          break;
        case CalendarFormat.twoWeeks:
          _calendarFormat = CalendarFormat.week;
          _calendarFormatLabel = "Week";
          break;
        case CalendarFormat.week:
          _calendarFormat = CalendarFormat.month;
          _calendarFormatLabel = "Month";
          break;
      }
    });
  }
}
