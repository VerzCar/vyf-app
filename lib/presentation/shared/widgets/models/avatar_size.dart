import 'dart:ui';

enum AvatarSize {
  xs,
  sm,
  base,
  md,
  lg,
  xl,
  xxl,
}

extension AvatarPreSize on AvatarSize {
  Size get preSize {
    switch (this) {
      case AvatarSize.xs:
        return const Size(24, 24);
      case AvatarSize.sm:
        return const Size(36, 36);
      case AvatarSize.base:
        return const Size(48, 48);
      case AvatarSize.md:
        return const Size(60, 60);
      case AvatarSize.lg:
        return const Size(72, 72);
      case AvatarSize.xl:
        return const Size(96, 96);
      case AvatarSize.xxl:
        return const Size(108, 108);
    }
  }
}
