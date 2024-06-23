import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:study_stats/settings/constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {key,
      this.loading = false,
      required this.onTap,
      required this.title,
      this.enable = true,
      this.textSize,
      this.color,
      this.textColor,
      this.width,
      this.height,
      this.style,
      this.border});
  final bool loading;
  final bool enable;
  final VoidCallback onTap;
  final String title;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? textSize;
  final BoxBorder? border;
  final TextStyle? style;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.loading || !widget.enable ? 0.5 : 1,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed:
            widget.loading || widget.enable == false ? () {} : widget.onTap,
        child: Container(
          width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
          height: widget.height ?? 50,
          decoration: BoxDecoration(
              color: widget.color ?? Constants.black,
              borderRadius: BorderRadius.circular(10),
              border: widget.border),
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: widget.style ??
                      Constants.Montserrat.copyWith(
                        color: widget.textColor ?? Constants.white,
                        fontWeight: FontWeight.w600,
                        fontSize: widget.textSize ?? 18,
                      ),
                ),
              ),
              if (widget.loading)
                Positioned(
                    right: 15,
                    top: 50 / 3,
                    child: LoadingAnimationWidget.inkDrop(
                      color: Constants.white,
                      // rightDotColor: Constant.generalColor,
                      size: 20,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonSecondary extends StatefulWidget {
  const CustomButtonSecondary(
      {key,
      this.loading = false,
      required this.onTap,
      required this.title,
      this.enable = true,
      this.textSize,
      this.color,
      this.textColor,
      this.width,
      this.height,
      this.style,
      this.border});
  final bool loading;
  final bool enable;
  final VoidCallback onTap;
  final String title;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? textSize;
  final BoxBorder? border;
  final TextStyle? style;
  @override
  State<CustomButtonSecondary> createState() => _CustomButtonSecondaryState();
}

class _CustomButtonSecondaryState extends State<CustomButtonSecondary> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.loading || !widget.enable ? 0.5 : 1,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed:
            widget.loading || widget.enable == false ? () {} : widget.onTap,
        child: Container(
          width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
          height: widget.height ?? 50,
          decoration: BoxDecoration(
            color: widget.color ?? Constants.white,
            borderRadius: BorderRadius.circular(16),
            border: widget.border ?? Border.all(color: Constants.black),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: widget.style ??
                      Constants.Montserrat.copyWith(
                        color: widget.textColor ?? Constants.black,
                        fontWeight: FontWeight.w500,
                        fontSize: widget.textSize ?? 16,
                      ),
                ),
              ),
              if (widget.loading)
                Positioned(
                    right: 10,
                    top: 56 / 4,
                    child: LoadingAnimationWidget.inkDrop(
                      color: Constants.white,
                      // rightDotColor: Constant.generalColor,
                      size: 20,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
