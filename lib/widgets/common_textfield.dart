import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final Color? fillcolor;
  final Color? bordercolor;
  final bool isTextHidden;
  final bool isRequired;
  final String? hintText;
  final IconData? buttonIcon;
  final IconData? prefixIcon;
  final bool? togglePassword;
  final int? maxlines;
  final int? maxlength;
  final int? maxLength;
  final Function()? toggleFunction;
  final IconData? toggleIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final Function()? prefixIconTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focus;
  final TextInputAction? textInputAction;
  final Widget? suffixicon;
  final double? radius;
  final changeObscureStatus;
  const CommonTextField(
      {super.key,
        @required this.controller,
        this.validator,
        this.radius,
        this.bordercolor,
        this.labelText,
        this.fillcolor,
        this.maxLength,
        this.maxlines,
        this.hintText,
        this.isTextHidden = false,
        this.buttonIcon,
        this.prefixIcon,
        this.onChanged,
        this.togglePassword = false,
        this.toggleFunction,
        this.toggleIcon,
        this.isRequired = true,
        this.keyboardType = TextInputType.text,
        this.textInputAction = TextInputAction.done,
        this.readOnly,
        this.onTap,
        this.inputFormatters,
        this.prefixIconTap,
        this.changeObscureStatus,
        this.onSaved,
        this.focus,
        this.suffixicon,
        this.maxlength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      maxLines: maxlines ?? 1,
      textAlign: TextAlign.left,
      autovalidateMode:
      isRequired ? AutovalidateMode.always : AutovalidateMode.disabled,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      obscureText: isTextHidden,
      readOnly: readOnly == null ? false : true,
      onTap: onTap,
      maxLength: maxLength,
      cursorColor: AppColors.primaryColor,
      focusNode: focus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        // errorText: "This Field is Required",
        suffix: suffixicon,
        prefixIcon: prefixIcon != null
            ? GestureDetector(
          onTap: prefixIconTap,
          child: Icon(
            prefixIcon,
            color: AppColors.blackButtoncolor,
            size: 20.0,
          ),
        )
            : null,
        suffixIcon: IconButton(
            onPressed: toggleFunction,
            icon: Icon(
              toggleIcon,
              color: AppColors.primaryColor,
            )),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bordercolor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bordercolor ?? AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 10.0),
          ),
        ),
        hintText: hintText,
        fillColor: fillcolor ?? Colors.white,
        filled: true,
        hintStyle: TextStyle(color: AppColors.blackColor30, fontSize: 12),

        labelText: labelText ?? hintText,

        labelStyle: TextStyle(color: AppColors.blackColor30, fontSize: 12.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xfff7fbff)),
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 10.0)),
        ),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 15),
      controller: controller,
      validator: validator,
    );
  }
}

class EmailOrNumberInputFormatter extends TextInputFormatter {
  final bool isEmail;

  EmailOrNumberInputFormatter({required this.isEmail});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // If it is email, allow all characters except space
    if (isEmail) {
      String filtered = newValue.text.replaceAll(RegExp(r'[ ]'), '');
      return TextEditingValue(
        text: filtered,
        selection: newValue.selection,
      );
    } else {
      // If it is phone number, allow only digits
      String filtered = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      return TextEditingValue(
        text: filtered,
        selection: newValue.selection,
      );
    }
  }
}
