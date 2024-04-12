import 'dart:convert';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;

  const Avatar({
    super.key,
    required this.photo,
    required this.radius,
  });

  final String photo;

  factory Avatar.avatarLarge({required String photo}) {
    return Avatar(
      photo: photo,
      radius: 60,
    );
  }

  factory Avatar.avatarSmall({required String photo}) {
    return Avatar(
      photo: photo,
      radius: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    var image = MemoryImage(base64Decode(photo));

    return CircleAvatar(
      backgroundImage: image,
      radius: radius,
    );
  }
}
