import 'package:flutter/material.dart';

class AvatarDisplay extends StatelessWidget {
  final String avatarPath;

  const AvatarDisplay({required this.avatarPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundImage: AssetImage(avatarPath.isNotEmpty ? avatarPath : 'assets/images/avatars/avatar1.png'),
      onBackgroundImageError: (_, __) => const AssetImage('assets/images/avatars/avatar1.png'), // Utilisation d'une image de secours
    );
  }
}
