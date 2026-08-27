import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CosmeticAvatar extends StatelessWidget {
  final String avatarId;
  final String name;
  final double radius;

  const CosmeticAvatar({
    super.key,
    required this.avatarId,
    required this.name,
    this.radius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    // Lista de avatares lottie que reemplazan la imagen
    final isLottie = avatarId.startsWith('avatar_') && avatarId != 'avatar_default';

    if (isLottie) {
      final lottieName = avatarId.replaceFirst('avatar_', '');
      return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.surfaceContainerHighest,
        ),
        clipBehavior: Clip.antiAlias,
        child: Lottie.asset(
          'assets/$lottieName.lottie',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFallback(initial, colorScheme, theme),
        ),
      );
    }

    return _buildFallback(initial, colorScheme, theme);
  }

  Widget _buildFallback(String initial, ColorScheme colorScheme, ThemeData theme) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primary,
      child: Text(
        initial,
        style: theme.textTheme.titleMedium?.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
