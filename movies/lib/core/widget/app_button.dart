import 'package:flutter/material.dart';
import 'package:movies/core/constant/color.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final Widget? prefix;
  final Widget? suffix;
  final Size? size;
  final bool loading;
  final bool disabled;
  final bool primary;

  const AppButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.size,
      this.loading = false,
      this.disabled = false,
      this.primary = true,
      this.prefix,
      this.suffix,
      this.margin,
      this.padding = const EdgeInsets.symmetric(vertical: 12),
      this.color = AppColors.red,
      this.textColor = AppColors.white
      });

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      padding: padding,
      fixedSize: size,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: AppColors.red)
      ),
      backgroundColor: loading || disabled ? AppColors.grey : color,
    );

    Widget child = Row(
      children: [
        SizedBox(width: 40, child: prefix),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: suffix,
        ),
      ],
    );
    if (loading) {
      child = const Center(child: CircularProgressIndicator.adaptive());
    }
    return Container(
      margin: margin,
      child: ElevatedButton(
          style: style,
          onPressed: loading || disabled ? null : onTap,
          child: child),
    );
  }
}
