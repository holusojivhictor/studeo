import 'package:flutter/material.dart';
import 'package:studeo/src/utils/utils.dart';

class LinkIconButton extends StatelessWidget {
  const LinkIconButton({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Open this story in browser',
      icon: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.5),
        child: const Icon(Icons.public, color: Colors.white),
      ),
      onPressed: () => LinkUtils.launch(
        'https://unsplash.com/photos/$id',
      ),
    );
  }
}
