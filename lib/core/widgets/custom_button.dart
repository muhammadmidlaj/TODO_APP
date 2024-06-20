import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.isLoading = false,
      this.padding,
      this.borderRadius,
      this.height});

  final Function onTap;
  final String label;
  final bool isLoading;

  final double? padding;
  final double? borderRadius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(padding ?? 15),
                maximumSize: Size(size.width, height ?? 60),
                shadowColor: context.theme.colorScheme.primary.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10),
                ),
                backgroundColor: context.theme.colorScheme.primary),
            onPressed: () {
              onTap();
            },
            child: isLoading
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelLarge!
                        .copyWith(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }
}
