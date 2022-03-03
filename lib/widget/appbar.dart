import 'package:flutter/material.dart'; 

class CostumeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? costumeTitle;
  final String? profileTitle;
  final void Function()? onDelete;
  final bool? back, dense;
  final Icon? icon;

  const CostumeAppBar({
    Key? key,
    required this.title,
    this.back,
    this.icon,
    this.dense = false,
    this.profileTitle,
    this.onDelete,
    this.costumeTitle,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      )),
      leading: back != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: [
        if (onDelete != null)
          Padding(
            padding:
                const EdgeInsets.only(right: 2, top: 4),
            child: IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
          )
      ],
      title: costumeTitle ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
                if (dense ?? false) const SizedBox(width: 12),
              ],
              if (profileTitle != null)
                const SizedBox(width: 46 + 3),
              Text(title, ),
              if (profileTitle != null)
                Column(
                  children: [
                    Text(profileTitle!,
                          ),
                    const SizedBox(height: 2),
                    Container(
                      width: 55,
                      height: 2,
                      color: Colors.blue,
                    )
                  ],
                ),
              if (onDelete == null) ...[
                const SizedBox(width: 32),
                const SizedBox(width: 32),
              ],
            ],
          ),
    );
  }
}
