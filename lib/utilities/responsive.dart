import 'package:flutter/material.dart';
import 'ui_styles.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey widgetKey = GlobalKey();

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive(
      {super.key, required this.mobile, this.tablet, this.desktop});

  static bool isSmallWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isMediumWidth(BuildContext context) =>
      MediaQuery.of(context).size.width >= 850 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isLargeWidth(BuildContext context) =>
      MediaQuery.of(context).size.width >= 100;

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;

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
  final double? basicWidth, verticalSpacing, horizontalSpacing;
  final WrapCrossAlignment? crossAxisAlignment;

  const ResponsiveRow({
    super.key,
    required this.context,
    required this.children,
    this.basicWidth,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    var mobileBaseWidth = 180;
    var desktopBaseWidth = 240;
    var verticalMargin = verticalSpacing ?? defaultPadding;
    var horizontalMargin = horizontalSpacing ?? defaultPadding * 5;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var parentWidth = constraints.maxWidth;
        var columns = parentWidth ~/
                    (basicWidth ??
                        (Responsive.isSmallWidth(context)
                            ? mobileBaseWidth
                            : desktopBaseWidth)) <
                1
            ? 1
            : parentWidth ~/
                (basicWidth ??
                    (Responsive.isSmallWidth(context)
                        ? mobileBaseWidth
                        : desktopBaseWidth));
        var width = parentWidth / columns > parentWidth
            ? parentWidth
            : parentWidth / columns;

        List<Widget> items = [];
        for (var child in children) {
          var elementWidth = child.parentPercentWidth != null
              ? parentWidth * (child.parentPercentWidth ?? 100) / 100
              : width * (child.widthRatio ?? 1);
          var item = Container(
            padding: EdgeInsets.fromLTRB(
                0, verticalMargin / 2, horizontalMargin, verticalMargin / 2),
            width: elementWidth,
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
                  crossAxisAlignment:
                      crossAxisAlignment ?? WrapCrossAlignment.start,
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
  final double? widthRatio, parentPercentWidth;
  final Function(bool)? onHover;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  const ResponsiveItem({
    super.key,
    required this.child,
    this.widthRatio,
    this.parentPercentWidth,
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
