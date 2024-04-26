library ichached_network_image;

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A widget for displaying network images with caching support.
class ICachedNetworkImage extends StatelessWidget {
  /// The URL of the image to display.
  final String url;

  /// The height of the image.
  final double height;

  /// The width of the image.
  final double width;

  /// The asset image to use as a placeholder while the network image is loading.
  final String placeholderAssetImage;

  /// The local file path of the placeholder image.
  final String? filePlaceholderPath;

  /// The fit of the image within its container.
  final BoxFit fit;

  /// Determines whether to always show the placeholder image, even when the network image is available.
  final bool alwaysShowPlaceHolder;

  /// The shape of the container.
  late final BoxShape shape;

  /// The border of the container.
  final BoxBorder? border;

  /// The border radius of the container.
  final BorderRadiusGeometry? borderRadius;

  /// The old file used for comparison when updating the cached image.
  late final File? oldFile;

  /// Creates an [ICachedNetworkImage] widget.
  ///
  /// [url] is the URL of the image to display.
  /// [height] is the height of the image container.
  /// [width] is the width of the image container.
  /// [placeholderAssetImage] is the asset image to use as a placeholder while the network image is loading.
  /// [fit] is the fit of the image within its container.
  /// [alwaysShowPlaceHolder] determines whether to always show the placeholder image, even when the network image is available.
  /// [shape] is the shape of the container.
  /// [borderRadius] is the border radius of the container.
  /// [filePlaceholderPath] is the local file path of the placeholder image.
  /// [border] is the border of the container.
  /// [oldFile] is the old file used for comparison when updating the cached image.
  ICachedNetworkImage(
    this.url, {
    super.key,
    this.height = 50,
    this.width = 50,
    this.placeholderAssetImage =
        'packages/icached_network_image/assets/placeholder.png',
    this.fit = BoxFit.cover,
    this.alwaysShowPlaceHolder = false,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.filePlaceholderPath,
    this.border,
    this.oldFile,
  });

  /// The default cache manager used for downloading and caching the network image.
  final DefaultCacheManager manager = DefaultCacheManager();

  @override
  Widget build(BuildContext context) {
    // If the shape is set to 'rectangle' and a border radius is provided, assign the shape to 'rectangle'.
    if (borderRadius != null && shape != BoxShape.rectangle) {
      shape = BoxShape.rectangle;
    }

    // Check and update the file after downloading it from the specified URL.
    checkAndUpdateFile();

    return StreamBuilder<FileResponse?>(
      stream: manager.getFileStream(url, key: url),
      builder: (_, snapshot) {
        var data = snapshot.data;

        if (data is FileInfo) {
          oldFile = data.file;
        }

        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: alwaysShowPlaceHolder
                  ? placeHolder
                  : (data is FileInfo ? FileImage(data.file) : placeHolder),
              fit: fit,
            ),
            shape: shape,
            border: border,
            borderRadius: borderRadius,
          ),
        );
      },
    );
  }

  /// Check and update the file after downloading it from the specified URL, replacing the old file if necessary.
  void checkAndUpdateFile() async {
    try {
      var newFile = await manager.downloadFile(url, force: true);
      if (newFile.file != oldFile) {
        manager.putFile(url, newFile.file.readAsBytesSync(), key: url);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Get the placeholder image provider.
  ImageProvider get placeHolder {
    if (filePlaceholderPath != null && filePlaceholderPath!.isNotEmpty) {
      var file = File(filePlaceholderPath!);
      if (file.existsSync()) {
        return FileImage(file);
      }
    }
    return AssetImage(placeholderAssetImage);
  }
}
