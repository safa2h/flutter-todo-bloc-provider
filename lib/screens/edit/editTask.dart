import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo4/data/data.dart';

import 'package:todo4/main.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.taskEntity}) : super(key: key);

  final TaskEntity taskEntity;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController textEditingController =
      TextEditingController(text: widget.taskEntity.name);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final box = Hive.box<TaskEntity>(taskBoxName);

            widget.taskEntity.name = textEditingController.text;
            if (widget.taskEntity.isInBox) {
              widget.taskEntity.save();
            } else {
              box.add(widget.taskEntity);
            }
            Navigator.of(context).pop();
          },
          label: Text('Save Changes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flex(direction: Axis.horizontal, children: [
              Flexible(
                flex: 1,
                child: CheckBoxPeriority(
                    lable: 'Highe',
                    value: widget.taskEntity.periority == Periority.high,
                    onTab: () {
                      setState(() {
                        widget.taskEntity.periority = Periority.high;
                      });
                    },
                    color: highPeriority),
              ),
              Flexible(
                flex: 1,
                child: CheckBoxPeriority(
                    lable: 'Normal',
                    value: widget.taskEntity.periority == Periority.normal,
                    onTab: () {
                      setState(() {
                        widget.taskEntity.periority = Periority.normal;
                      });
                    },
                    color: normalperiority),
              ),
              Flexible(
                flex: 1,
                child: CheckBoxPeriority(
                    lable: 'Low',
                    value: widget.taskEntity.periority == Periority.low,
                    onTab: () {
                      setState(() {
                        widget.taskEntity.periority = Periority.low;
                      });
                    },
                    color: lowPeriority),
              ),
            ]),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  label: Text('Add Task For Today...'),
                  border: InputBorder.none),
            )
          ],
        ),
      ),
    );
  }
}

class CheckBoxPeriority extends StatelessWidget {
  const CheckBoxPeriority(
      {Key? key,
      required this.lable,
      required this.value,
      required this.onTab,
      required this.color})
      : super(key: key);
  final String lable;
  final bool value;
  final Function() onTab;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.all(4),
        height: 48,
        decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                lable,
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                right: 4,
                child: Center(
                  child: PerioritycheckBoxShape(value: value, color: color),
                ))
          ],
        ),
      ),
    );
  }
}

class PerioritycheckBoxShape extends StatelessWidget {
  const PerioritycheckBoxShape(
      {Key? key, required this.value, required this.color})
      : super(key: key);

  final bool value;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: value
          ? Icon(
              CupertinoIcons.checkmark,
              color: Colors.white,
              size: 12,
            )
          : null,
    );
  }
}
