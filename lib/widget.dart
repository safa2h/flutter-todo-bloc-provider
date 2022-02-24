import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo4/main.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/empty_state.svg',
            width: 80,
            height: 100,
          ),
          SizedBox(
            height: 8,
          ),
          Text('You dont have any Task')
        ],
      ),
    );
  }
}

class MycheckBox extends StatelessWidget {
  const MycheckBox({Key? key, required this.isCompleted, required this.onTab})
      : super(key: key);

  final bool isCompleted;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isCompleted ? primeryColor : null,
          borderRadius: BorderRadius.circular(10),
          border: !isCompleted
              ? Border.all(
                  color: secondryextcolor,
                )
              : null,
        ),
        child: isCompleted
            ? Icon(
                CupertinoIcons.checkmark,
                color: Colors.white,
                size: 12,
              )
            : null,
      ),
    );
  }
}
