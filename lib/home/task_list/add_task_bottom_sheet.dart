import 'package:app_to_do/dialog_yutils.dart';
import 'package:app_to_do/firebase_utils.dart';
import 'package:app_to_do/model/task.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/app_Config_provider.dart';
import 'package:app_to_do/providers/auth_providers.dart';
import 'package:app_to_do/providers/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hot_toast/flutter_hot_toast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  late ListProvider listProvider;
  late AuthProviders authProviders;

  @override
  Widget build(BuildContext context) {
    authProviders = Provider.of<AuthProviders>(context, listen: false);
    var provider = Provider.of<ProviderConfig>(context);
    listProvider = Provider.of<ListProvider>(context);
    return GlobalLoaderOverlay(
      child: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.add_new_task,
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
                        style: TextStyle(
                            color: provider.isDarkMode()
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor),
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_task_title;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.task_title,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyTheme.greyColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: provider.isDarkMode()
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor),
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_task_description;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.description_title,
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
                      AppLocalizations.of(context)!.select_date,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          showCalendarPicker();
                        },
                        child: Text(
                          DateFormat(
                            'dd-MM-yyyy ',
                          ).format(selectedDate),
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
                          checkTask();
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
      ),
    );
  }

  void showCalendarPicker() async {
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

  void checkTask() {
    if (formKey.currentState!.validate() == true) {
      /// create object from class Task to found var
      DialogUtils.showLoading(context: context, message: 'Loding...');

      Task task = Task(
        dateTime: selectedDate,
        description: description,
        title: title,
      );

      FirebaseUtils.writingTaskToFireStoreAfterChecked(
              task, authProviders.currentUser!.id!)
          .then((value) {
        DialogUtils.hideLoading(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("👌 Tasks Added successfully 👌"),
        ));
        print('task added successfully');
        listProvider.getTaskFromFireStore(authProviders.currentUser!.id!);
        Navigator.pop(context);

        // DialogUtils.showMessage(
        //     context: context,
        //     message: 'task added successfully',
        //     posAction: () {
        //       Navigator.pop(context);
        //     });
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        print('task added successfully');
        listProvider.getTaskFromFireStore(authProviders.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}

// timeout(Duration(milliseconds: 500), onTimeout: () {
// /// alert dialog -- tosk -- snakbar  // 8.00 offline
// print('task added successfully');
// listProvider.getTaskFromFireStore();
// Navigator.pop(context);
// }
