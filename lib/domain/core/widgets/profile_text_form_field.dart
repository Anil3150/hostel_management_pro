import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/theme/colors.dart';
import '../../../../../infrastructure/theme/styles/text_styles.dart';

class ProfileTextFormField extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final TextInputType keyboardType;
  int maxLines;
  final double editorHeight;
  String hintText;
  List<TextInputFormatter> inputformate;
  final TextStyle? lableStyle;
  final TextStyle? hintStyle;
  final int maxLength;
  final bool showTextFieldLable;
  final Color fieldBgColor;
  final bool isEnabled;
  final bool isReadOnly;
  final Widget? showSufixIcon;
  final Widget? showPrefixIcon;
  final BoxDecoration? containerDecoration;
  final EdgeInsets? containerPadding;
  final EdgeInsets? contentPadding;
  final Function()? ontap;
  final Function()? onEditingC;
  final Function(String)? cOnChanged;
  final String? Function(String?)? cValidator;
  final bool showText;
  final ElevatedButton? dropdown;
  final bool enableFilePicker;
  final Function(File?)? onFileSelected;
  final bool showBorder;
  final BorderRadius? borderRadius;
  final Color? containerColor;
  FocusNode? focusNode;

  static const BorderSide _defaultBorderSide = BorderSide(color: Color(0xFF676767));

  ProfileTextFormField({
    super.key,
    this.lable = '',
    required this.controller,
    this.maxLines = 1,
    this.lableStyle,
    this.hintStyle,
    this.hintText = '',
    this.showTextFieldLable = false,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.fieldBgColor = colorWhite,
    this.maxLength = 100,
    this.inputformate = const [],
    this.keyboardType = TextInputType.name,
    this.showSufixIcon,
    this.containerDecoration,
    this.containerPadding,
    this.ontap,
    this.editorHeight = 0,
    this.onEditingC,
    this.cOnChanged,
    this.cValidator,
    this.showPrefixIcon,
    this.showText = false,
    this.contentPadding = EdgeInsets.zero,
    this.dropdown,
    this.enableFilePicker = false,
    this.onFileSelected,
    this.showBorder = false,
    this.borderRadius,
    this.containerColor,
    this.focusNode,
  });

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      controller.text = result.files.single.name; // Show file name in field
      if (onFileSelected != null) {
        onFileSelected!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle lableStyleFinal = lableStyle ?? TextStyles.kTSNFS14;
    TextStyle hintStyleFinal = hintStyle ?? TextStyles.kTSNFS14;
    // final colors = Get.find<ThemeController>().appColors;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 14, bottom: 4),
            child: Text(
              lable,
              style: lableStyle,
            ),
          ),
        Container(
          padding:
              containerPadding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          color: containerColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: editorHeight == 0 ? Get.height / 20 : editorHeight,
                child: TextFormField(
                  focusNode: focusNode,
                  cursorColor: colorBlack,
                  obscureText: showText,
                  onTap: enableFilePicker
                      ? () => pickFile(context)
                      : ontap,
                  onEditingComplete: onEditingC,
                  onChanged: cOnChanged,
                  controller: controller,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  buildCounter: null,
                  enabled: isEnabled,
                  readOnly: isReadOnly,
                  inputFormatters: inputformate,
                  style: lableStyleFinal,
                  decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: contentPadding,
                    hintStyle: hintStyleFinal,
                    prefixIcon: showPrefixIcon,
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: borderRadius ?? BorderRadius.circular(10),
                      borderSide: showBorder ? _defaultBorderSide : BorderSide.none,
                    ),
                    errorStyle:
                        TextStyles.kTSFS10W500.copyWith(color: colorRedW800),
                    suffixIcon: showSufixIcon,
                    counterText: '',
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
