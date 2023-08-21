import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanner/config/palette.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.asset,
    required this.title,
    this.isLast = false,
    this.isSeleted = false,
    this.onTap,
  });

  final String title;
  final String asset;
  final bool isLast;
  final bool isSeleted;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(
            width: 20,
            asset,
            color: isSeleted ? Palette.secondaryColor : Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isSeleted ? Palette.secondaryColor : Colors.black,
            ),
          ),
          onTap: onTap,
        ),
        !isLast
            ? Container()
            : const Divider(
                color: Colors.grey,
              ),
      ],
    );
  }
}
