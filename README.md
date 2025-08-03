# Glow Orb Widget

A highly customizable animated glow orb widget with gradient effects, perfect for AI assistants and interactive applications.

## Preview

![Demo de la Cara de Asistente](https://github.com/jaimecalderon19/glow_orb/blob/main/screenshots/example.png)

*Widget de Cara de Asistente con gradiente animado*

## Features

- 🌈 Advanced multi-color blob system with customizable positions
- ✨ Multiple simultaneous animations (floating, color shifting, blinking, looking around)
- 🎛️ Highly parametrizable (30+ customization options)
- 🎨 Custom color schemes support with pre-defined themes
- 👀 Realistic eye movements and blinking animations
- 🔄 Startup animation sequence
- 📏 Fully adjustable size and positioning
- 🎯 Tap interaction support
- 🚀 Smooth performance with optimized animations

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  glow_orb: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:glow_orb/glow_orb.dart';

GlowOrb(
  size: 200,
  onTap: () {
    print('Orb tapped!');
  },
)
```

### Custom Colors

```dart
GlowOrb(
  size: 250,
  customColorScheme: [
    Colors.purple,
    Colors.blue,
    Colors.cyan,
    Colors.green,
  ],
  floatIntensity: 15.0,
  lookAroundIntensity: 10.0,
)
```

### Using Pre-defined Themes

```dart
GlowOrb(
  size: 200,
  customColorScheme: GlowOrbThemes.cyber,
)
```

### Disabled Animations

```dart
GlowOrb(
  size: 150,
  enableFloating: false,
  enableColorShift: false,
  enableBlinking: false,
  enableLookAround: false,
  enableStartupAnimation: false,
)
```

### Custom Animation Durations

```dart
GlowOrb(
  size: 200,
  floatAnimationDuration: Duration(seconds: 4),
  colorShiftDuration: Duration(seconds: 10),
  blinkDuration: Duration(seconds: 2),
  lookAroundDuration: Duration(seconds: 8),
)
```

## Available Themes

- `GlowOrbThemes.rainbow` - Classic rainbow colors
- `GlowOrbThemes.sunset` - Warm sunset colors  
- `GlowOrbThemes.ocean` - Cool ocean blues
- `GlowOrbThemes.cyber` - Bright neon colors
- `GlowOrbThemes.professional` - Professional purple tones

## Main Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `size` | `double` | `250.0` | Size of the main orb |
| `backgroundColor` | `Color` | `Colors.black` | Background color |
| `eyeColor` | `Color` | `Colors.white` | Color of the eyes |
| `floatIntensity` | `double` | `8.0` | Intensity of floating movement |
| `eyeWidth` | `double` | `13.0` | Width of eyes |
| `eyeHeight` | `double` | `39.0` | Height of eyes when open |
| `eyeSpacing` | `double` | `30.0` | Spacing between eyes |
| `lookAroundIntensity` | `double` | `7.0` | Intensity of look around movement |
| `customColorScheme` | `List<Color>?` | `null` | Custom colors for the orb |
| `onTap` | `VoidCallback?` | `null` | Callback when orb is tapped |

## Animation Controls

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `enableFloating` | `bool` | `true` | Enable floating animation |
| `enableColorShift` | `bool` | `true` | Enable color shift animation |
| `enableBlinking` | `bool` | `true` | Enable blinking animation |
| `enableLookAround` | `bool` | `true` | Enable look around animation |
| `enableStartupAnimation` | `bool` | `true` | Enable startup animation |

## Animation Durations

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `floatAnimationDuration` | `Duration` | `6 seconds` | Duration of floating cycle |
| `colorShiftDuration` | `Duration` | `20 seconds` | Duration of color shift cycle |
| `blinkDuration` | `Duration` | `4 seconds` | Duration of blink cycle |
| `lookAroundDuration` | `Duration` | `10 seconds` | Duration of look around cycle |
| `startupDuration` | `Duration` | `2 seconds` | Duration of startup animation |

## Color Blob Customization

You can customize the background color blobs using the `colorBlobs` parameter:

```dart
GlowOrb(
  colorBlobs: [
    ColorBlobConfig(
      position: ColorBlobPosition.topLeft,
      size: 120,
      colorOffset: 0,
      blurSigma: 20,
    ),
    ColorBlobConfig(
      position: ColorBlobPosition.topRight,
      size: 140,
      colorOffset: 120,
      blurSigma: 30,
    ),
  ],
)
```

## Example

Check out the `/example` folder for a complete example app showing different configurations, themes, and customization options.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.# Animated Assistant Face

A customizable animated face widget with gradient effects, perfect for AI assistants and interactive applications.