import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import '../../models/task.dart';
import '../size_config.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({required this.task});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 20 : 8)),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selectedColor(task.color)),
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(
                  SizeConfig.orientation == Orientation.landscape ? 20 : 4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(task.title!,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_alarm_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text('${task.startTime!}     ${task.endTime}',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ))),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(task.note!,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ))),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(3),
                height: 60,
                width: 0.5,
                color: Colors.grey[100]!.withOpacity(0.3),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  ((task.isCompleted) == 0) ? 'ToDo' : 'Completed',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          )),
    );
  }

  selectedColor(int? color) {
    switch (color) {
      case 0:
        return primaryClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return primaryClr;
    }
  }
}
