import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/presentation/add_task/widgets/color_list.dart';
import 'package:to_do_app/presentation/add_task/widgets/default_button.dart';
import 'package:to_do_app/presentation/add_task/widgets/text_form_field.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit_states.dart';
import 'package:to_do_app/presentation/main_screen/view/main_screen.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';

import '../../../services/notification_service.dart';
import '../../resources/route_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/value_manger.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MainCubit.get(context).remindController.text =
        MainCubit.get(context).remindList[0];
    MainCubit.get(context).repeatController.text =
        MainCubit.get(context).repeatList[0];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(AppStrings.addTaskTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: BlocConsumer<MainCubit, MainCubitStates>(
            listener: (context, state) {},
            builder: (context, state) {
              MainCubit cubit = MainCubit.get(context);
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    DefaultTextFormField(
                      controller: cubit.titleController,
                      type: TextInputType.text,
                      value: AppStrings.title,
                      validate: (value) {
                        if (value.isEmpty) {
                          return AppStrings.taskTitleValidate;
                        }
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    Text(
                      AppStrings.deadline,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    GestureDetector(
                      onTap: () => cubit.selectDate(context),
                      child: DefaultTextFormField(
                          enabled: false,
                          controller: cubit.deadlineController,
                          type: TextInputType.datetime,
                          validate: (value) {
                            if (value.isEmpty) {
                              return AppStrings.taskDateTitleValidate;
                            }
                          },
                          value: AppStrings.deadline),
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.startTime,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.selectTime(context).then((value) {
                                  cubit.startTime = cubit.selectedTime;
                                  cubit.startTimeController.text =
                                      cubit.timeSelected!;
                                });
                              },
                              child: DefaultTextFormField(
                                enabled: false,
                                width: MediaQuery.of(context).size.width * 0.43,
                                controller: cubit.startTimeController,
                                type: TextInputType.datetime,
                                value: AppStrings.startTime,
                                suffixIcon: const Icon(Icons.alarm),
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return AppStrings.taskStartTimeValidate;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.endTime,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.selectTime(context).then((value) {
                                  cubit.endTimeController.text =
                                      cubit.timeSelected!;
                                });
                              },
                              child: DefaultTextFormField(
                                width: MediaQuery.of(context).size.width * 0.43,
                                controller: cubit.endTimeController,
                                enabled: false,
                                type: TextInputType.datetime,
                                value: AppStrings.endTime,
                                suffixIcon: const Icon(Icons.alarm),
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return AppStrings.taskEndTimeValidate;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    Text(
                      AppStrings.remind,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    DefaultTextFormField(
                      controller: cubit.remindController,
                      type: TextInputType.text,
                      value: AppStrings.remind,
                      validate: (value) {
                        if (value.isEmpty) {
                          return AppStrings.taskremindValidate;
                        }
                      },
                      suffixIcon: DropdownButton(
                        items: cubit.remindList.map(
                          (value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          cubit.changeRemindValue(value);
                        },
                        underline: const SizedBox(),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    Text(
                      AppStrings.repeat,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    DefaultTextFormField(
                      controller: cubit.repeatController,
                      type: TextInputType.text,
                      value: AppStrings.repeat,
                      validate: (value) {
                        if (value.isEmpty) {
                          return AppStrings.taskrepeatValidate;
                        }
                      },
                      suffixIcon: DropdownButton(
                        items: cubit.repeatList.map(
                          (value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          cubit.changeRepeatValue(value);
                        },
                        underline: const SizedBox(),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    Text(
                      AppStrings.selectColor,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    ColorList(
                      colorList: cubit.colorList,
                    ),
                    Spacer(),
                    DefaultButton(
                        text: AppStrings.createTask,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            TaskModel task = TaskModel(
                                title: cubit.titleController.text,
                                deadline: cubit.selectedDate,
                                startTime: cubit.startTimeController.text,
                                endTime: cubit.endTimeController.text,
                                isCompleted: 'false',
                                isFavourited: 'false',
                                color: cubit.selectedColor!.value,
                                remind: cubit.remindController.text,
                                repeat: cubit.repeatController.text);
                            if (!cubit.validateTime()) {
                              cubit.insertToDatabase(task).then((value) {
                                cubit.setReminderTime();
                                cubit.clearData();
                                cubit.navigateAndFinish(
                                    context, Routes.mainRoute);
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: AppStrings.validateErrorMessage,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: ColorManager.error,
                                  textColor: ColorManager.white,
                                  fontSize: 16.0);
                            }
                          }
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }
}
