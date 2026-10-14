import 'package:flutter/material.dart' hide Ink;

import '../theme.dart';

/// The seesaw-style logo pill: ONE ✦ DOSE in a bordered capsule that
/// tilts slightly on hover.
class BrandMark extends StatefulWidget {
  final VoidCallback? onTap;
  const BrandMark({super.key, this.onTap});

  @override
  State<BrandMark> createState() => _BrandMarkState();
}

class _BrandMarkState extends State<BrandMark> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedRotation(
          turns: _hover ? -3 / 360 : 0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _hover ? const Color(0xFFFAFAFA) : Colors.white,
              border: Border.all(
                color: _hover ? const Color(0xFFD4D4D4) : Ink.line,
              ),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ONE',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Ink.ink,
                    height: 1,
                  ),
                ),
                SizedBox(width: 6),
                Text('✦', style: TextStyle(fontSize: 12, color: Ink.ink)),
                SizedBox(width: 6),
                Text(
                  'DOSE',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Ink.ink,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
