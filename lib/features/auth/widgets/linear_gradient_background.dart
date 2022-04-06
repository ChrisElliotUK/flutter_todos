import 'package:flutter/material.dart';

/// A linear gradient background.
/// the default [height] and [width] are [double.infinity].
/// You can set the the [colors] which will be used to create the gradient.
/// [colors] can be a [List<Color>]. The defualt[colors] are the theme
/// primary and seconday color. In that order.
/// You can also set the [stops] which will be used to create the gradient.
/// [stops] can be a [List<double>]. [stops] is nullable.
class LinearGradientBackground extends StatelessWidget {
  const LinearGradientBackground({
    Key? key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.colors,
    this.begin = Alignment.topRight,
    this.end = Alignment.bottomLeft,
    this.stops,
  }) : super(key: key);

  final double height;
  final double width;
  final List<Color>? colors;
  final Alignment begin;
  final Alignment end;
  final List<double>? stops;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ??
              <Color>[
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
          stops: stops,
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}
