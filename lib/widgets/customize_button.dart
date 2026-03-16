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
    this.enabled = true,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final double width;
  final double height;
  final String buttonText;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor;
  final bool enabled;
  final bool isLoading;

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
    final effectiveColor = buttonColor ?? context.theme.colorScheme.secondary;
    final effectiveRadius = (borderRadius ?? BorderRadius.circular(12)).resolve(
      Directionality.of(context),
    );
    final effectiveTextStyle =
        textStyle ??
        context.textTheme.bodyMedium?.copyWith(
          color: context.theme.colorScheme.onSecondary,
        );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: effectiveColor,
        borderRadius: effectiveRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled && !isLoading ? onTap : null,
          borderRadius: effectiveRadius,
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding:
                  padding ??
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              child: isLoading
                  ? _LoadingIndicator()
                  : _ButtonContent(
                      buttonText: buttonText,
                      textStyle: effectiveTextStyle,
                      prefix: hasPrefix ? _buildAffix(prefix!) : null,
                      suffix: hasSuffix ? _buildAffix(suffix!) : null,
                      affixSize: affixSize,
                      affixSpacing: affixSpacing,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            context.theme.colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    this.prefix,
    this.suffix,
    required this.buttonText,
    this.textStyle,
    this.affixSize = 20,
    this.affixSpacing = 8,
  });

  final Widget? prefix;
  final Widget? suffix;
  final String buttonText;
  final TextStyle? textStyle;
  final double affixSize;
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

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasPrefix) ...[_buildAffix(prefix!), SizedBox(width: affixSpacing)],
        Text(buttonText, style: textStyle),
        if (hasSuffix) ...[SizedBox(width: affixSpacing), _buildAffix(suffix!)],
      ],
    );
  }
}
