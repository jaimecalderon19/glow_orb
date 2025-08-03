import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:async';

/// A highly customizable animated glow orb widget perfect for AI assistants
class GlowOrb extends StatefulWidget {
  /// Creates a customizable glow orb widget
  const GlowOrb({
    super.key,
    this.size = 250.0,
    this.backgroundColor = Colors.black,
    this.eyeColor = Colors.white,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderOpacity = 0.3,
    this.innerGradientOpacity = 0.2,
    this.floatAnimationDuration = const Duration(seconds: 6),
    this.colorShiftDuration = const Duration(seconds: 20),
    this.glowPulseDuration = const Duration(seconds: 2),
    this.blinkDuration = const Duration(seconds: 4),
    this.lookAroundDuration = const Duration(seconds: 10),
    this.startupDuration = const Duration(seconds: 2),
    this.floatIntensity = 8.0,
    this.eyeWidth = 13.0,
    this.eyeHeight = 39.0,
    this.eyeSpacing = 30.0,
    this.eyeBorderRadius = 3.0,
    this.lookAroundIntensity = 7.0,
    this.enableFloating = true,
    this.enableColorShift = true,
    this.enableBlinking = true,
    this.enableLookAround = true,
    this.enableStartupAnimation = true,
    this.customColorScheme,
    this.onTap,
    this.colorBlobs = const [
      ColorBlobConfig(),
      ColorBlobConfig(
        position: ColorBlobPosition.topRight,
        size: 160,
        colorOffset: 120,
        blurSigma: 35,
        scale: 0.5,
        floatMultiplier: -0.5,
      ),
      ColorBlobConfig(
        position: ColorBlobPosition.bottom,
        size: 170,
        colorOffset: 240,
        blurSigma: 45,
        scale: 0.6,
        floatMultiplier: 1.5,
      ),
    ],
  });

  /// Size of the main orb
  final double size;

  /// Background color of the widget
  final Color backgroundColor;

  /// Color of the eyes
  final Color eyeColor;

  /// Border color (defaults to white with opacity)
  final Color? borderColor;

  /// Border width
  final double borderWidth;

  /// Border opacity
  final double borderOpacity;

  /// Inner gradient opacity
  final double innerGradientOpacity;

  /// Duration of floating animation
  final Duration floatAnimationDuration;

  /// Duration of color shift animation
  final Duration colorShiftDuration;

  /// Duration of glow pulse animation
  final Duration glowPulseDuration;

  /// Duration of blink animation
  final Duration blinkDuration;

  /// Duration of look around animation
  final Duration lookAroundDuration;

  /// Duration of startup animation
  final Duration startupDuration;

  /// Intensity of floating movement
  final double floatIntensity;

  /// Width of eyes
  final double eyeWidth;

  /// Height of eyes when open
  final double eyeHeight;

  /// Spacing between eyes
  final double eyeSpacing;

  /// Border radius of eyes
  final double eyeBorderRadius;

  /// Intensity of look around movement
  final double lookAroundIntensity;

  /// Enable/disable floating animation
  final bool enableFloating;

  /// Enable/disable color shift animation
  final bool enableColorShift;

  /// Enable/disable blinking animation
  final bool enableBlinking;

  /// Enable/disable look around animation
  final bool enableLookAround;

  /// Enable/disable startup animation
  final bool enableStartupAnimation;

  /// Custom color scheme for the orb
  final List<Color>? customColorScheme;

  /// Callback when orb is tapped
  final VoidCallback? onTap;

  /// Configuration for color blobs
  final List<ColorBlobConfig> colorBlobs;

  @override
  State<GlowOrb> createState() => _GlowOrbState();
}

/// Configuration for color blobs
class ColorBlobConfig {
  const ColorBlobConfig({
    this.position = ColorBlobPosition.topLeft,
    this.size = 150.0,
    this.colorOffset = 0.0,
    this.blurSigma = 10.0,
    this.scale = 0.6,
    this.floatMultiplier = 1.0,
    this.opacity = 0.8,
  });

  final ColorBlobPosition position;
  final double size;
  final double colorOffset;
  final double blurSigma;
  final double scale;
  final double floatMultiplier;
  final double opacity;
}

/// Position options for color blobs
enum ColorBlobPosition {
  topLeft,
  topRight,
  bottom,
  center,
  custom,
}

class _GlowOrbState extends State<GlowOrb> with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _floatController;
  late AnimationController _colorShiftController;
  late AnimationController _glowPulseController;
  late AnimationController _blinkController;
  late AnimationController _lookAroundController;
  late AnimationController _startupController;

  // Animations
  late Animation<double> _floatAnimation;
  late Animation<double> _colorShiftAnimation;
  late Animation<double> _blinkAnimation;
  late Animation<double> _lookAroundAnimation;
  late Animation<double> _startupAnimation;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeControllers() {
    _floatController = AnimationController(
      duration: widget.floatAnimationDuration,
      vsync: this,
    );

    _colorShiftController = AnimationController(
      duration: widget.colorShiftDuration,
      vsync: this,
    );

    _glowPulseController = AnimationController(
      duration: widget.glowPulseDuration,
      vsync: this,
    );

    _blinkController = AnimationController(
      duration: widget.blinkDuration,
      vsync: this,
    );

    _lookAroundController = AnimationController(
      duration: widget.lookAroundDuration,
      vsync: this,
    );

    _startupController = AnimationController(
      duration: widget.startupDuration,
      vsync: this,
    );
  }

  void _initializeAnimations() {
    _floatAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _colorShiftAnimation = Tween<double>(begin: 0, end: 1).animate(_colorShiftController);
    _blinkAnimation = Tween<double>(begin: 0, end: 1).animate(_blinkController);
    _lookAroundAnimation = Tween<double>(begin: 0, end: 1).animate(_lookAroundController);

    _startupAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _startupController, curve: Curves.easeOut),
    );
  }

  void _startAnimations() {
    if (widget.enableStartupAnimation) {
      _startupController.forward();
      Timer(widget.startupDuration, _startMainAnimations);
    } else {
      _startMainAnimations();
    }
  }

  void _startMainAnimations() {
    if (widget.enableFloating) _floatController.repeat();
    if (widget.enableColorShift) _colorShiftController.repeat();
    _glowPulseController.repeat();
    if (widget.enableBlinking) _blinkController.repeat();
    if (widget.enableLookAround) _lookAroundController.repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _colorShiftController.dispose();
    _glowPulseController.dispose();
    _blinkController.dispose();
    _lookAroundController.dispose();
    _startupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: widget.backgroundColor,
        child: Stack(
          children: [
            _buildColorBlobs(),
            _buildMainOrb(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorBlobs() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: AnimatedBuilder(
          animation: Listenable.merge([_startupAnimation, _colorShiftAnimation, _floatAnimation]),
          builder: (context, child) {
            double floatOffset = widget.enableFloating 
                ? math.sin(_floatAnimation.value * 2 * math.pi) * 5 
                : 0;

            return Transform.translate(
              offset: Offset(0, floatOffset),
              child: Stack(
                children: widget.colorBlobs.map((config) => _buildColorBlob(config, floatOffset)).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildColorBlob(ColorBlobConfig config, double floatOffset) {
    Offset position = _getColorBlobPosition(config.position, floatOffset * config.floatMultiplier);
    
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Transform.scale(
        scale: widget.enableStartupAnimation 
            ? _startupAnimation.value * config.scale + 0.7 
            : config.scale + 0.7,
        child: Container(
          width: config.size,
          height: config.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: _getColorBlobColors(config),
            ),
          ),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: config.blurSigma, sigmaY: config.blurSigma),
            child: Container(),
          ),
        ),
      ),
    );
  }

  Offset _getColorBlobPosition(ColorBlobPosition position, double floatOffset) {
    switch (position) {
      case ColorBlobPosition.topLeft:
        return Offset(80, 60 + floatOffset);
      case ColorBlobPosition.topRight:
        return Offset(MediaQuery.of(context).size.width - 240, 70 + floatOffset);
      case ColorBlobPosition.bottom:
        return Offset(120, MediaQuery.of(context).size.height * 0.3 + floatOffset);
      case ColorBlobPosition.center:
        return Offset(MediaQuery.of(context).size.width / 2 - 75, MediaQuery.of(context).size.height * 0.2 + floatOffset);
      case ColorBlobPosition.custom:
        return Offset(100, 100 + floatOffset);
    }
  }

  List<Color> _getColorBlobColors(ColorBlobConfig config) {
    if (widget.customColorScheme != null && widget.customColorScheme!.isNotEmpty) {
      int colorIndex = (config.colorOffset / 120).floor() % widget.customColorScheme!.length;
      Color baseColor = widget.customColorScheme![colorIndex];
      return [
        baseColor.withOpacity(config.opacity),
        baseColor.withOpacity(config.opacity * 0.3),
      ];
    }

    // Default HSV color generation
    double hue = widget.enableColorShift 
        ? (_colorShiftAnimation.value * 360 + config.colorOffset) % 360
        : config.colorOffset;
    
    return [
      HSVColor.fromAHSV(config.opacity, hue, 0.9, 1).toColor(),
      HSVColor.fromAHSV(config.opacity * 0.3, hue, 0.9, 1).toColor(),
    ];
  }

  Widget _buildMainOrb() {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_startupAnimation, _floatAnimation, _glowPulseController]),
        builder: (context, child) {
          double floatOffset = widget.enableFloating 
              ? math.sin(_floatAnimation.value * 2 * math.pi) * widget.floatIntensity 
              : 0;

          return Transform.translate(
            offset: Offset(0, floatOffset),
            child: Transform.scale(
              scale: widget.enableStartupAnimation 
                  ? _startupAnimation.value * 0.2 + 0.8 
                  : 1.0,
              child: Opacity(
                opacity: widget.enableStartupAnimation ? _startupAnimation.value : 1.0,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: (widget.borderColor ?? Colors.white).withOpacity(widget.borderOpacity),
                      width: widget.borderWidth,
                    ),
                  ),
                  child: Stack(
                    children: [
                      _buildInnerGradient(),
                      _buildEyes(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInnerGradient() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(widget.innerGradientOpacity),
          ],
        ),
      ),
    );
  }

  Widget _buildEyes() {
    return AnimatedBuilder(
      animation: Listenable.merge([_blinkAnimation, _lookAroundAnimation]),
      builder: (context, child) {
        double eyeHeight = widget.enableBlinking && 
            _blinkAnimation.value > 0.96 && _blinkAnimation.value < 0.98 
            ? 3 
            : widget.eyeHeight;
        
        double eyePosition = (widget.size / 2) - (widget.eyeWidth + widget.eyeSpacing / 2);
        if (widget.enableLookAround) {
          eyePosition += math.sin(_lookAroundAnimation.value * 2 * math.pi) * widget.lookAroundIntensity;
        }

        return Positioned(
          top: widget.size * 0.34, // Aproximadamente donde estaban los ojos
          left: eyePosition,
          child: Row(
            children: [
              Container(
                width: widget.eyeWidth,
                height: eyeHeight,
                decoration: BoxDecoration(
                  color: widget.eyeColor,
                  borderRadius: BorderRadius.circular(widget.eyeBorderRadius),
                ),
              ),
              SizedBox(width: widget.eyeSpacing),
              Container(
                width: widget.eyeWidth,
                height: eyeHeight,
                decoration: BoxDecoration(
                  color: widget.eyeColor,
                  borderRadius: BorderRadius.circular(widget.eyeBorderRadius),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Pre-defined color schemes for the glow orb
class GlowOrbThemes {
  /// Classic rainbow colors
  static const List<Color> rainbow = [
    Color(0xFFFF6B6B), // Red
    Color(0xFFFFE66D), // Yellow  
    Color(0xFF4ECDC4), // Cyan
    Color(0xFF45B7D1), // Blue
    Color(0xFF96CEB4), // Green
    Color(0xFF6C5CE7), // Purple
  ];

  /// Warm sunset colors
  static const List<Color> sunset = [
    Color(0xFFFF8A80),
    Color(0xFFFFAB40),
    Color(0xFFFFCC02),
    Color(0xFFFF7043),
  ];

  /// Cool ocean colors
  static const List<Color> ocean = [
    Color(0xFF00BCD4),
    Color(0xFF03A9F4),
    Color(0xFF3F51B5),
    Color(0xFF009688),
  ];

  /// Neon cyber colors
  static const List<Color> cyber = [
    Color(0xFF00FF88),
    Color(0xFF00D4FF),
    Color(0xFFFF0080),
    Color(0xFFFFFF00),
  ];

  /// Professional colors
  static const List<Color> professional = [
    Color(0xFF667EEA),
    Color(0xFF764BA2),
    Color(0xFFF093FB),
    Color(0xFFF5576C),
  ];
}