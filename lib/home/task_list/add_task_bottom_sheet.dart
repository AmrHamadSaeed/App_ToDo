import 'package:app_to_do/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Task title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter task title',
                        hintStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: MyTheme.colorInput,
                                ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyTheme.greyColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Task description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter task description',
                        hintStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: MyTheme.colorInput,
                                ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyTheme.greyColor),
                        ),
                      ),
                      maxLines: 4,
                    ),
                  ),
                  Text(
                    'Select Date',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        showCalendar();
                      },
                      child: Text(
                        '${DateFormat('dd-MM-yyyy ').format(selectedDate)}',
                        // '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Icon(Icons.check),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState!.validate() == true) {}
  }
}
