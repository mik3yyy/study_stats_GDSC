import 'package:flutter/material.dart';

import '../settings/constants.dart';

class ButtonTile extends StatelessWidget {
  const ButtonTile(
      {key,
      required this.title,
      this.leading,
      this.traling,
      required this.onTap,
      this.color,
      this.subTitle});

  final String title;
  final String? subTitle;
  final Widget? leading;
  final Widget? traling;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Card(
        child: Container(
          // width: MediaQuery.of(context).size.width *,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(
            //   color: Constants.white,
            // ),
          ),
          child: InkWell(
            onTap: onTap,
            child: ListTile(
              minVerticalPadding: 0.0,
              leading: leading,
              subtitle: subTitle != null
                  ? Text(
                      subTitle ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: color != null ? Color(0xFF696969) : null,
                      ),
                    )
                  : null,
              title: Container(
                width: 100,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: color != null ? Constants.white : null,
                  ),
                  // maxLines: 2,
                ),
              ),
              trailing: traling,
            ),
          ),
        ),
      ),
    );
  }
}
