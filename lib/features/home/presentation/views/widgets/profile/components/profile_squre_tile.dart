import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileSqureTile extends StatelessWidget {
  const ProfileSqureTile(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap,
      this.type = "svg"});

  final String label;
  final String icon;
  final String type;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              type == "svg"
                  ? SvgPicture.asset(icon, width: 32, height: 32)
                  : Image.asset(
                      icon,
                      width: 32,
                      height: 32,
                    ),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
