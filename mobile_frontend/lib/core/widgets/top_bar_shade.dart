import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// The dark fade behind the white app bar on the auth screens, so the title
/// and back arrow stay readable over the photo. It eases out to fully
/// transparent, so there's no visible line where it ends.
class TopBarShade extends StatelessWidget {
  const TopBarShade({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.54),
            Colors.black.withValues(alpha: 0.36),
            Colors.black.withValues(alpha: 0.16),
            Colors.black.withValues(alpha: 0.04),
            Colors.black.withValues(alpha: 0),
          ],
          stops: const [0, 0.3, 0.6, 0.85, 1],
        ),
      ),
    );
  }
}
