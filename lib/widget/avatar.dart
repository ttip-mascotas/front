import 'dart:io';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final ImageProvider? image;

  const Avatar({
    super.key,
    required this.image,
    required this.radius,
  });

  factory Avatar.avatarSmall({required String photo}) {
    return Avatar(
      image: getImageFromBytes(photo),
      radius: 40,
    );
  }

  factory Avatar.avatarLargeURL({required String url}) {
    return Avatar(image: getImageFromUrl(url), radius: 60);
  }

  factory Avatar.avatarSmallURL({required String url}) {
    return Avatar(image: getImageFromUrl(url), radius: 40);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: image,
    );
  }

  static NetworkImage? getImageFromUrl(String url) {
    const host = "10.0.2.2";
    return url.isNotEmpty
        ? NetworkImage(
            url
                .replaceFirst("localhost", host)
                .replaceFirst("127.0.0.1", host)
                .replaceFirst("minio", host),
          )
        : null;
  }

  static MemoryImage? getImageFromBytes(String photo) {
    return photo.isNotEmpty ? MemoryImage(File(photo).readAsBytesSync()) : null;
  }
}
