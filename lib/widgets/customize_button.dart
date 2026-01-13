import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizeButton extends StatelessWidget {
  const CustomizeButton({
    super.key,
    required this.onTap,
    this.width = double.infinity,
    this.height = 48,
    required this.buttonText,
    this.textStyle,
    this.borderRadius,
    this.padding,
    this.buttonColor,
    this.prefix,
    this.suffix,
    this.affixSize = 20,
    this.affixSpacing = 8,
  });

  final VoidCallback onTap;
  final double width;
  final double height;
  final String buttonText;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor;

  /// Optional widget shown before the text.
  ///
  /// Use this for `SvgPicture`, images, icons, or any custom widget.
  final Widget? prefix;

  /// Optional widget shown after the text.
  ///
  /// Use this for `SvgPicture`, images, icons, or any custom widget.
  final Widget? suffix;

  /// The square size applied to [prefix] and [suffix] when provided.
  ///
  /// The affix is wrapped with `SizedBox.square` + `FittedBox(scaleDown)` to
  /// avoid overflow and allow SVGs/other widgets to scale down cleanly.
  final double affixSize;

  /// Horizontal spacing between [prefix]/[suffix] and the text.
  final double affixSpacing;

  Widget _buildAffix(Widget child) {
    return SizedBox.square(
      dimension: affixSize,
      child: FittedBox(fit: BoxFit.scaleDown, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPrefix = prefix != null;
    final hasSuffix = suffix != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
          color: buttonColor ?? context.theme.colorScheme.primary,
          borderRadius: borderRadius ?? .circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasPrefix) ...[
              _buildAffix(prefix!),
              SizedBox(width: affixSpacing),
            ],
            Text(
              buttonText,
              style:
                  textStyle ??
                  context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.onPrimary,
                  ),
            ),
            if (hasSuffix) ...[
              SizedBox(width: affixSpacing),
              _buildAffix(suffix!),
            ],
          ],
        ),
      ),
    );
  }
}
