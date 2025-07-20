import 'package:flutter/material.dart';

class SlideFadeAnimation extends StatefulWidget {
  final Widget child;
  final double offset;
  final Curve curve;
  final Duration delay;

  const SlideFadeAnimation({
    Key? key,
    required this.child,
    this.offset = 100.0,
    this.curve = Curves.easeOut,
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  @override
  State<SlideFadeAnimation> createState() => _SlideFadeAnimationState();
}

class _SlideFadeAnimationState extends State<SlideFadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.offset / 100), // Changed to vertical offset for bottom-to-top animation
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
} 