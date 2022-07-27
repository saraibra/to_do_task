
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/presentation/main_screen/view/main_screen.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';
import 'package:to_do_app/presentation/resources/string_manager.dart';

import '../../../services/notification_service.dart';
import '../../schedule/cubit/schedule_cubit.dart';
import 'main_cubit_states.dart';

class MainCubit extends Cubit<MainCubitStates> {
  MainCubit() : super(AppInitialState());
  static MainCubit get(context) => BlocProvider.of(
      context); // to take object from AppCubit to use it in all pages

  TextEditingController titleController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  String pickedTime = '';
  TimeOfDay? startTime;
  List<Color> colorList = [
    ColorManager.error,
    ColorManager.purple,
    ColorManager.cyan,
    ColorManager.pink,
    ColorManager.green,
  ];
  String? timeSelected;
  DateTime? notificationTime;
  String validateMessage = '';
  Future<void> selectTime(BuildContext context) async {
    TimeOfDay time = TimeOfDay.now();
    selectedTime = await showTimePicker(context: context, initialTime: time);
    if (selectedTime != null) {
      pickedTime = selectedTime!.hour.toString() +
          ':' +
          selectedTime!.minute.toString() +
          ':00';
      timeSelected =
          DateFormat.jm().format(DateFormat("hh:mm:ss").parse(pickedTime));

      emit(SelectTimeState());
    }
  }

   selectDate(BuildContext context) async {
    DateTime date = DateTime.now();
    selectedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.utc(2010, 1, 1),
        lastDate: DateTime.utc(2050, 1, 1));
    if (selectedDate != null) {
      
      deadlineController.text = DateFormat("yyyy-MM-dd").format(selectedDate!);}
      emit(SelectDateState());
    
  }

  int? selected = 0;
  Color? selectedColor;
  void selectContainerColor(int index) {
    selected = index;
    selectedColor = colorList[index];
    emit(SelectColorState());
  }

  List<String> menuList = [
    AppStrings.delete,
    AppStrings.favouriteTask,
  ];
  List<String> repeatList = [
    AppStrings.repeatDaily,
    AppStrings.repeatWeekly,
    AppStrings.never
  ];
  List<String> remindList = [
    AppStrings.remind1day,
    AppStrings.remind1hour,
    AppStrings.remind30min,
    AppStrings.remind10min
  ];
  changeRemindValue(value) {
    remindController.text = value;
    emit(RemindChangeState());
  }

  changeRepeatValue(value) {
    repeatController.text = value;
    emit(RepeatChangeState());
  }

  void changeMenuValue(value, int id, String isFavourited) {
    if (value == AppStrings.delete) {
      deleteData(id: id);
    } else if (value == AppStrings.favouriteTask) {
      checkIsTaskFavourited(id, isFavourited);
    }
  }

  var database;
  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favouritedTasks = [];

  void createDatabase() {
    database = openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date DATETIME, startTime DATETIME, endTime DATETIME,isCompleted BOOLEAN,isFavourited BOOLEAN,color INTEGER,remind TEXT ,repeat TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating a table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future<void> insertToDatabase(TaskModel task) async {
    print("$titleController.text");
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title, date, startTime,endTime,isCompleted,isFavourited,color,remind,repeat) VALUES("${task.title}","${task.deadline}", "${task.startTime}","${task.endTime}","${task.isCompleted}","${task.isFavourited}","${task.color!}","${task.remind}","${task.repeat}")')
          .then((value) {
        print('insert successfully');
        emit(AppInsertDataBaseState());
        getDataFromDataBase(database);
      }).catchError((error) {
        print('error when insert data ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDataBase(Database database) {
    allTasks = [];
    completedTasks = [];
    uncompletedTasks = [];
    favouritedTasks = [];
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element) {
        allTasks.add(element);
        if (element['isFavourited'] == 'true') {
          favouritedTasks.add(element);
        }
        if (element['isCompleted'] == 'true') {
          completedTasks.add(element);
        } else {
          uncompletedTasks.add(element);
        }
      });
      emit(AppGetDataBaseState());
    });
  }

   void setTaskCompleted(int id, String value) {
    if (value == 'true') {
      value = 'false';
    } else {
      value = 'true';
    }
    updateData(status: 'isCompleted', value: value, id: id);
  }

  void checkIsTaskFavourited(int id, String value) {
    if (value == 'true') {
      value = 'false';
    } else {
      value = 'true';
    }
    updateData(status: 'isFavourited', value: value, id: id);
  }

  void updateData(
      {required String status, required String value, required int id}) {
    database.rawUpdate('UPDATE Tasks SET $status = ? WHERE id = ?',
        ['$value', id]).then((value) {
      debugPrint("sata $id");
     getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({required int id}) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  void clearData() {
    deadlineController.text = '';
    remindController.text = '';
    repeatController.text = '';
    startTimeController.text = '';
    endTimeController.text = '';
    titleController.text = '';
    selected = 0;
    emit(ClearDataState());
  }

  void navigateAndFinish(context, routeName) => Navigator.pushReplacementNamed(
        context,
        routeName,
      );
  bool validateTime() {
    notificationTime = selectedDate!
        .toLocal()
        .add(Duration(minutes: startTime!.minute, hours: startTime!.hour));
    if (notificationTime!.isBefore(DateTime.now())) {
      return true;
    }
   else{
    return false;
   }
  }

  void setReminderTime() {
    if (remindController.text == AppStrings.remind10min) {
      notificationTime = selectedDate!
          .toLocal()
          .add(Duration(minutes: startTime!.minute, hours: startTime!.hour))
          .subtract(const Duration(minutes: 10));
      print(notificationTime.toString());
      createNotification(notificationTime!);
    } else if (remindController.text == AppStrings.remind30min) {
      notificationTime = selectedDate!
          .toLocal()
          .add(Duration(minutes: startTime!.minute, hours: startTime!.hour))
          .subtract(const Duration(minutes: 30));
      createNotification(notificationTime!);
    } else if (remindController.text == AppStrings.remind1hour) {
      notificationTime = selectedDate!
          .toLocal()
          .add(Duration(minutes: startTime!.minute, hours: startTime!.hour))
          .subtract(const Duration(hours: 1));
      createNotification(notificationTime!);
    } else if (remindController.text == AppStrings.remind1day) {
      notificationTime = selectedDate!
          .toLocal()
          .add(Duration(minutes: startTime!.minute, hours: startTime!.hour))
          .subtract(const Duration(days: 1));
      createNotification(notificationTime!);
    }
  }
}
