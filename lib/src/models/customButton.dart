// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? function;
  IconData? icon;

  //final Function? function;
  final String text;
  final bool isIconButton;
  final bool? customSize;
  final IconData? iconHover;

  CustomButton({
    Key? key,
    this.function,
    this.icon,
    this.iconHover,
    this.customSize,
    required this.text,
    required this.isIconButton,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late IconData icon;

  @override
  void initState() {
    icon = widget.icon!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onHover: (bool value) {
          setState(() {
            if (value) {
              icon = widget.iconHover!;
            } else {
              icon = widget.icon!;
            }
          });
        },
        style: Theme.of(context).textButtonTheme.style,
        onPressed: widget.function,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: widget.isIconButton
              ? SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.ltr,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Icon(
                        icon,
                        size: 24,
                        color: const Color(0xffFAFAFB),
                      ),
                      const SizedBox(width: 8),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          widget.text,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      widget.text,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
        ));
  }
}
