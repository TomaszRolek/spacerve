import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spacerve/utils/spacerve_colors.dart';
import 'package:spacerve/utils/spacerve_textstyles.dart';
import 'package:spacerve/widgets/stateful_widget_mounted.dart';
import '../generated/l10n.dart';

const double defHeight = 48.0;
const double defRadius = 32.0;
const defTextHorizontalPadding = 24.0;

class SpacerveTextField extends StatefulWidgetMounted {
  final TextEditingController textEditingController;
  final bool isEnabled;
  final bool isPassword;
  final String hint;
  final String error;
  final bool showError;
  final bool Function(String value) validator;
  final TextInputType inputType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value) onChanged;

  SpacerveTextField(
      {Key? key,
        required this.textEditingController,
        required this.onChanged,
        this.isEnabled = true,
        this.isPassword = false,
        this.hint = '',
        this.inputFormatters,
        String? error,
        bool Function(String value)? validator,
        TextInputType? inputType,
        TextCapitalization? textCapitalization,
        this.showError = false})
      : validator = validator ?? ((String value) => value.isNotEmpty),
        inputType = inputType ?? TextInputType.text,
        textCapitalization = textCapitalization ?? TextCapitalization.none,
        error = error ?? S.current.cant_be_empty,
        super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends StatefulWidgetMountedState<SpacerveTextField> {
  bool isInputEmpty = true;
  bool isPasswordVisible = false;
  final FocusNode _focus = FocusNode();
  bool _hasFocus = false;
  late bool showError;

  @override
  void initState() {
    isInputEmpty = widget.textEditingController.text.isEmpty;
    showError = widget.showError;
    _focus.addListener(() {
      onFocusChanged();
    });
    super.initState();
  }

  onFocusChanged() {
    setState(() {
      if (_hasFocus && !_focus.hasFocus) {
        if (!widget.validator(widget.textEditingController.text)) {
          showError = true;
        }
      }
      _hasFocus = _focus.hasFocus;
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                  height: defHeight,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(defRadius)),
                  child: _textFormField),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _errorText
      ],
    );
  }

  Widget get _textFormField {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isPassword && !isPasswordVisible,
      enabled: widget.isEnabled,
      focusNode: _focus,
      keyboardType: widget.inputType,
      textCapitalization: widget.textCapitalization,
      controller: widget.textEditingController,
      onChanged: (value) {
        setState(() {
          widget.onChanged(value);
          isInputEmpty = value.isEmpty;
        });
      },
      onTap: () {
        if (showError) {
          setState(() {
            showError = false;
          });
        }
      },
      style: SpacerveTextStyles.normal12
          .copyWith(color: showError ? SpacerveColors.redColor : Colors.white),
      decoration: _inputDecoration,
    );
  }

  InputDecoration get _inputDecoration {
    return InputDecoration(
      hintStyle: SpacerveTextStyles.normal12
          .copyWith(color: showError ? SpacerveColors.redColor : Colors.white),
      hintText: widget.hint,
      filled: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defRadius),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      contentPadding: const EdgeInsets.symmetric(horizontal: defTextHorizontalPadding, vertical: 12.0),
    );
  }

  Widget get _errorText {
    return Visibility(
        visible: showError,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: defTextHorizontalPadding),
          child: Text(widget.error,
              style: SpacerveTextStyles.normal12.copyWith(color: SpacerveColors.redColor)),
        ));
  }
}
