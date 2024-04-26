
**icached_network_image**

**A Flutter widget for displaying network images with efficient caching.**

This package provides a convenient way to display network images in your Flutter applications while taking advantage of caching to improve performance and reduce data usage.

**Installation**

1. Add the following dependency to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     icached_network_image: ^1.0.0 (or latest version)
   ```

2. Run `flutter pub get` to install the package.

**Usage**

Import the package in your Dart code:

```dart
import 'package:icached_network_image/icached_network_image.dart';
```

Use the `ICachedNetworkImage` widget to display your network images:

```dart
ICachedNetworkImage(
  'https://example.com/image.jpg',
  height: 100,
  width: 150,
  placeholderAssetImage: 'assets/placeholder.png',
  fit: BoxFit.cover,
),
```

**Features**

- Caches downloaded images for faster loading in subsequent uses.
- Provides a placeholder image to display while the network image is loading.
- Supports local file paths for placeholder images.
- Allows customization of the image container's shape (rectangle, circle) and border.
- Offers flexibility in specifying image dimensions (height, width) and fit within the container.
- Handles checking and updating cached images to ensure they stay fresh.

**Optional Parameters**

- `height`: Controls the height of the image container (defaults to 50).
- `width`: Controls the width of the image container (defaults to 50).
- `placeholderAssetImage`: The asset path of the placeholder image.
- `fit`: The fit of the image within its container (defaults to `BoxFit.cover`). Can be any `BoxFit` value.
- `alwaysShowPlaceHolder`: Set to `true` to always display the placeholder image, even when the network image is available (defaults to `false`).
- `shape`: The shape of the image container (defaults to `BoxShape.circle`). Can be `BoxShape.rectangle` or `BoxShape.circle`.
- `borderRadius`: The border radius of the image container (defaults to `null`).
- `filePlaceholderPath`: The local file path of an alternative placeholder image (optional).
- `border`: The border of the image container (optional). Use a `BoxBorder` object to define the border style and color.

**Contributing**

We welcome contributions to this package! Feel free to fork the repository on GitHub ([https://github.com/MicroProgramer/icached_network_image](https://github.com/MicroProgramer/icached_network_image)), create pull requests for bug fixes or new features, and raise issues for any problems you encounter.

**License**

This package is licensed under the MIT License ([https://opensource.org/license/mit](https://opensource.org/license/mit)).

**Additional Notes**

- Consider including an example in the README that showcases a more complex usage scenario, demonstrating how to combine different options like custom shapes, file-based placeholders, and borders.
- If you plan to distribute a placeholder image with the package, ensure appropriate licensing is in place.
- You might want to add support for error handling to display a different widget or text if the image fails to load.

This enhanced README provides a comprehensive overview of your `icached_network_image` package, making it easy for developers to understand and integrate it into their Flutter projects.