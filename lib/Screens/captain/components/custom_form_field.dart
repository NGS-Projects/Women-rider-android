// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:womentaxi/untils/export_file.dart';

class CustomFormField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic ontap;
  dynamic contentPadding;
  bool obscureText;
  bool readOnly;
  bool enabled;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  Widget? prefix;
  dynamic keyboardType;
  dynamic inputFormatters;
  dynamic maxLength;
  String label;
  TextStyle? hintStyle;
  TextStyle? textStyle;
  double? fontSize;
  FontWeight? fontWeight;

  final textColor;
  final labelColor;
  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  CustomFormField(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
      required this.enabled,
      required this.maxLines,
      required this.obscureText,
      this.inputFormatters,
      this.suffix,
      this.textStyle,
      this.hintStyle,
      this.maxLength,
      this.value,
      this.onChanged,
      this.contentPadding,
      this.validator,
      this.ontap,
      required this.readOnly,
      this.textColor,
      this.labelColor,
      this.fontSize,
      this.fontWeight,
      required this.label,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(
              fontSize: fontSize,
              //  letterSpacing: 1,
              color: labelColor ?? KTextgery,
              fontWeight: fontWeight),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Kwhite,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3FD3D1D8),
                  blurRadius: 30,
                  offset: Offset(15, 15),
                  spreadRadius: 0,
                )
              ]),
          child: TextFormField(
            maxLength: maxLength,
            obscureText: obscureText,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLines,
            enabled: enabled,
            focusNode: focusNode,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: textStyle ??
                TextStyle(fontSize: 14.sp, fontWeight: kFW500, color: kblack),
            decoration: InputDecoration(
              focusColor: Kwhite,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: contentPadding,
              // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Kbordergery, width: 0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: kblack.withOpacity(0.6), width: 0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: kblack.withOpacity(0.6), width: 0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Kpink.withOpacity(0.6), width: 0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Kpink.withOpacity(0.6), width: 1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              fillColor: Kwhite,
              suffixIcon: suffix,
              prefixIcon: prefix,
              hintText: hintText,
              alignLabelWithHint: true,
              //make hint text
              hintStyle: hintStyle ??
                  TextStyle(
                    color: KTextgery.withOpacity(0.5),
                    fontSize: 14.sp,
                    fontWeight: kFW500,
                  ),

              //create lable
            ),
            validator: validator,
            onChanged: onChanged,
            onTap: ontap,
          ),
        ),
      ],
    );
  }
}

// class CustomSearchField extends StatelessWidget {
//   TextEditingController? controller;
//   String hintText;
//   dynamic validator;
//   dynamic onTap;
//   dynamic contentPadding;
//   bool obscureText;
//   bool readOnly;
//   bool enabled;
//   dynamic value;
//   dynamic focusNode;
//   int maxLines;
//   dynamic onChanged;
//   Widget? prefix;
//   dynamic keyboardType;

//   TextStyle? hintStyle;
//   double? fontSize;
//   FontWeight? fontWeight;

//   final textColor;

//   //keyboardType: TextInputType.datetime,

//   Widget? suffix;
//   CustomSearchField(
//       {Key? key,
//       this.keyboardType,
//       this.prefix,
//       this.focusNode,
//       required this.enabled,
//       required this.maxLines,
//       required this.obscureText,
//       this.suffix,
//       this.hintStyle,
//       this.value,
//       this.onChanged,
//       this.contentPadding,
//       this.validator,
//       this.onTap,
//       required this.readOnly,
//       this.textColor,
//       this.fontSize,
//       this.fontWeight,
//       this.controller,
//       required this.hintText})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: Kwhite,
//           boxShadow: const [
//             BoxShadow(
//               color: Color(0x3FD3D1D8),
//               blurRadius: 30,
//               offset: Offset(15, 15),
//               spreadRadius: 0,
//             )
//           ]),
//       child: TextFormField(
//           enabled: enabled,
//           onTap: onTap,
//           obscureText: obscureText,
//           controller: controller,
//           maxLines: maxLines,
//           focusNode: focusNode,
//           keyboardType: keyboardType,
//           style: GoogleFonts.roboto(fontSize: 14.sp, fontWeight: kFW500, color: kblack),
//           decoration: InputDecoration(
//             focusColor: Kwhite,
//             filled: true,

//             contentPadding: contentPadding,
//             // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide:
//                   BorderSide(color: Ktextcolor.withOpacity(0.3), width: 1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderSide:
//                   BorderSide(color: Ktextcolor.withOpacity(0.3), width: 1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderSide:
//                   BorderSide(color: Ktextcolor.withOpacity(0.3), width: 1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderSide:
//                   BorderSide(color: Kgreen.withOpacity(0.6), width: 0.5),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Kgreen.withOpacity(0.6), width: 1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             fillColor: Kwhite,
//             // fillColor: Ktextcolor.withOpacity(0.12),
//             suffixIcon: suffix,
//             prefixIcon: prefix,
//             hintText: hintText,
//             alignLabelWithHint: true,
//             //make hint text
//             hintStyle: hintStyle ??
//                 TextStyle(
//                   color: KTextgery.withOpacity(0.5),
//                   fontSize: 14.sp,
//                   fontWeight: kFW500,
//                 ),

//             //create lable
//           ),
//           validator: validator),
//     );
//   }
// }
