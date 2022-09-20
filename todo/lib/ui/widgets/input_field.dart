import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/textformat.dart';

class InputField extends StatelessWidget {
  InputField(
      {required this.title, required this.hint, this.controller, this.widget});
  final String title;
  final String hint;
  final TextEditingController? controller;
  late final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.only(top: 8),
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          //  border: Border.all(color: Colors.grey)
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle()),
              SizedBox(height: 10),
              Container(
                height: 52,

                width: SizeConfig.screenWidth,
                padding: const EdgeInsets.only(top: 8, left: 10),
                // margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: widget != null ? true : false,
                        cursorColor: Get.isDarkMode
                            ? Colors.grey[100]
                            : Colors.grey[700],
                        controller: controller,
                        style: subTitleStyle(),
                        autofocus: false,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                color: context.theme.backgroundColor,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                color: context.theme.backgroundColor,
                              ),
                            ),
                            hintText: hint,
                            hintStyle: subTitleStyle()),
                      ),
                    ),
                    widget ?? Container()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
