import "package:flutter/material.dart";
import "package:mascotas/widget/avatar.dart";

class AvatarSelector extends StatelessWidget {
  final String photo;
  final void Function() selectPhoto;

  const AvatarSelector(
      {required this.photo, required this.selectPhoto, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectPhoto,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Avatar.avatarSmall(photo: photo),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
