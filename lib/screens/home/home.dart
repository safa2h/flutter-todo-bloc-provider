import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo4/data/data.dart';
import 'package:todo4/data/repo/repository.dart';
import 'package:todo4/main.dart';
import 'package:todo4/screens/edit/editTask.dart';
import 'package:todo4/widget.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<String> searchNotifire = ValueNotifier('_value');
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    EditTaskScreen(taskEntity: TaskEntity())));
          },
          label: Row(
            children: [Text('Add new Task'), Icon(CupertinoIcons.add)],
          )),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 102,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primeryColor.withOpacity(0.9),
                    primeryColor,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To Do List',
                          style: themeData.textTheme.headline6!
                              .copyWith(color: themeData.colorScheme.onPrimary),
                        ),
                        Icon(
                          Icons.share,
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20)
                          ],
                          color: themeData.colorScheme.surface,
                          borderRadius: BorderRadius.circular(19)),
                      child: TextField(
                        onChanged: (value) {
                          searchNotifire.value = textEditingController.text;
                        },
                        controller: textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: secondryextcolor,
                            ),
                            label: Text(
                              'Search',
                              style: TextStyle(color: secondryextcolor),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: searchNotifire,
                builder: (context, value, child) {
                  final repository =
                      Provider.of<Repository<TaskEntity>>(context);
                  return FutureBuilder<List<TaskEntity>>(
                    future: repository.getAll(
                        searchKeyword: textEditingController.text),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        if (snapShot.data!.isNotEmpty) {
                          return TaskList(
                              items: snapShot.data, themeData: themeData);
                        } else {
                          return EmptyState();
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.items,
    required this.themeData,
  }) : super(key: key);

  final items;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: themeData.textTheme.headline6!
                        .apply(fontSizeFactor: 0.9),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                        color: primeryColor,
                        borderRadius: BorderRadius.circular(1.5)),
                  )
                ],
              ),
              MaterialButton(
                elevation: 0,
                color: Color(0xffeaeff5),
                onPressed: () {
                  final repository =
                      Provider.of<Repository<TaskEntity>>(context);
                  repository.deleteAll();
                },
                child: Row(
                  children: [
                    Text(
                      'delete All',
                      style: TextStyle(color: secondryextcolor),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      CupertinoIcons.delete_solid,
                      size: 18,
                      color: secondryextcolor,
                    )
                  ],
                ),
              )
            ],
          );
        } else {
          final TaskEntity task = items[index - 1];

          return TaskItem(
            task: task,
          );
        }
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskEntity task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final periotiry;
    switch (widget.task.periority) {
      case Periority.low:
        periotiry = lowPeriority;
        break;
      case Periority.normal:
        periotiry = normalperiority;
        break;
      case Periority.high:
        periotiry = highPeriority;
        break;
    }
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditTaskScreen(taskEntity: widget.task)));
      },
      onLongPress: () {
        setState(() {
          widget.task.delete();
        });
      },
      child: Container(
        margin: EdgeInsets.all(4),
        height: 76,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 3, color: secondryextcolor),
            ],
            borderRadius: BorderRadius.circular(8),
            color: themeData.colorScheme.surface),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Row(children: [
            MycheckBox(
              isCompleted: widget.task.isCompleted,
              onTab: () {
                setState(() {
                  widget.task.isCompleted = !widget.task.isCompleted;
                });
              },
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.task.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ),
            Container(
              width: 4,
              height: 76,
              decoration: BoxDecoration(
                  color: periotiry,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
            ),
          ]),
        ),
      ),
    );
  }
}
