import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey widgetKey = GlobalKey();

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive(
      {super.key, required this.mobile, this.tablet, this.desktop});

  /// small: <850, large: >= 1100, medium: else
  static bool isSmallWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  // static bool isMediumWidth(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 850 &&
  //     MediaQuery.of(context).size.width < 1100;
  //
  // static bool isLargeWidth(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 1100;

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;

  // static bool isLandscape(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width < 850) {
      return mobile;
    } else if (size.width < 1100) {
      return tablet ?? mobile;
    } else {
      return desktop ?? tablet ?? mobile;
    }
  }
}

class ResponsiveRow extends StatelessWidget {
  final BuildContext context;
  final List<ResponsiveItem> children;
  final double? basicWidth, horizontalSpacing, verticalSpacing;
  final WrapCrossAlignment? crossAxisAlignment;

  const ResponsiveRow({
    super.key,
    required this.context,
    required this.children,
    this.basicWidth = 180,
    this.horizontalSpacing = 0,
    this.verticalSpacing = 0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    // var mobileBaseWidth = 180;
    // var desktopBaseWidth = 240;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var parentWidth = constraints.maxWidth;
        // var tempWidth = basicWidth ??
        //     (Responsive.isSmallWidth(context)
        //         ? mobileBaseWidth
        //         : desktopBaseWidth);
        var columns =
            parentWidth ~/ basicWidth! < 1 ? 1 : parentWidth ~/ basicWidth!;
        var width = parentWidth / columns;

        List<Widget> items = [];
        for (var child in children) {
          var elementWidth = child.percentWidthOnParent != null
              ? parentWidth * (child.percentWidthOnParent ?? 100) / 100
              : width * (child.widthRatio!);
          var item = SizedBox(
            width: columns == 1 || parentWidth ~/ elementWidth < 1
                ? parentWidth
                : elementWidth -
                    (parentWidth ~/ elementWidth - 1) * horizontalSpacing!,
            child: child.child,
          );
          items.add(item);
        }
        return SizedBox(
          width: parentWidth,
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: horizontalSpacing!,
                  runAlignment: WrapAlignment.start,
                  runSpacing: verticalSpacing!,
                  crossAxisAlignment: crossAxisAlignment!,
                  children: items,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ResponsiveItem extends StatelessWidget {
  final Widget child;
  final int? widthRatio;
  final double? percentWidthOnParent;
  final Function(bool)? onHover;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  const ResponsiveItem({
    super.key,
    required this.child,
    this.widthRatio = 1,
    this.percentWidthOnParent,
    this.onTap,
    this.onDoubleTap,
    this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onHover: onHover,
      child: child,
    );
  }
}
