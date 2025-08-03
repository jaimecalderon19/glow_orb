# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-08-03

### Added
- Initial release of the `GlowOrb` widget
- Highly customizable animated glow orb with gradient effects
- Multiple simultaneous animations:
  - Floating movement animation
  - Color shifting animation with HSV color space
  - Realistic blinking animation
  - Eye look-around movement
  - Startup sequence animation
- Advanced multi-color blob system with configurable positions
- 30+ customization parameters including:
  - Size, colors, and animation durations
  - Movement intensities and eye properties
  - Individual animation enable/disable controls
  - Custom color schemes support
- Pre-defined color themes:
  - `GlowOrbThemes.rainbow` - Classic rainbow colors
  - `GlowOrbThemes.sunset` - Warm sunset colors
  - `GlowOrbThemes.ocean` - Cool ocean blues
  - `GlowOrbThemes.cyber` - Bright neon colors
  - `GlowOrbThemes.professional` - Professional purple tones
- Color blob configuration system with `ColorBlobConfig` class
- Tap interaction support with customizable callbacks
- Smooth performance with optimized animation controllers
- Comprehensive example app with multiple demo screens
- Full documentation with usage examples and parameter descriptions

### Features
- **Performance**: Optimized animation controllers with proper disposal
- **Accessibility**: Proper gesture detection and user interaction
- **Customization**: All parameters are optional with sensible defaults
- **Themes**: Ready-to-use color schemes for different aesthetics
- **Flexibility**: Granular control over every aspect of appearance and behavior

### Technical Details
- Built with Flutter 3.0+ compatibility
- Uses `TickerProviderStateMixin` for smooth animations
- Implements `BackdropFilter` for realistic blur effects
- Custom `HSVColor` generation for dynamic color shifting
- Proper animation lifecycle management
- Memory efficient with automatic controller cleanup