import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey widgetKey = GlobalKey();

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive(
      {super.key, required this.mobile, this.tablet, this.desktop});

  /// small: <800, large: >= 1200, medium: else
  static double smallWidthScope = 800;
  static double mediumWidthScope = 1200;

  static bool isSmallWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < smallWidthScope;

  static bool isMediumWidth(BuildContext context) =>
      MediaQuery.of(context).size.width >= smallWidthScope &&
      MediaQuery.of(context).size.width < mediumWidthScope;

  static bool isLargeWidth(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumWidthScope;

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;

  static bool isPortraitAndSmallWidth(BuildContext context) =>
      isSmallWidth(context) && isPortrait(context);

  static bool isSmallWidthParent() =>
      WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width <
      smallWidthScope;

  static bool isMediumWidthParent(BuildContext context) {
    var view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize.width >= smallWidthScope &&
        view.physicalSize.width < mediumWidthScope;
  }

  static bool isLargeWidthParent(BuildContext context) =>
      WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width >=
      mediumWidthScope;

  static bool isMobile() => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static bool isMobileAndPortrait(BuildContext context) =>
      isMobile() && isPortrait(context);

  static bool isNotMobile() =>
      kIsWeb || (!Platform.isAndroid && !Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width < smallWidthScope) {
      return mobile;
    } else if (size.width < mediumWidthScope) {
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
        var columns =
            parentWidth ~/ basicWidth! < 1 ? 1 : parentWidth ~/ basicWidth!;
        var width = parentWidth / columns;

        List<Widget> items = [];
        for (var child in children) {
          if (child.child != null) {
            var elementWidth = child.percentWidthOnParent != null
                ? parentWidth * (child.percentWidthOnParent ?? 100) / 100
                : width * (child.widthRatio!);
            var item = SizedBox(
              width: elementWidth > 0
                  ? columns == 1 || parentWidth ~/ elementWidth < 1
                      ? parentWidth
                      : elementWidth -
                          (parentWidth ~/ elementWidth - 1) * horizontalSpacing!
                  : 0,
              child: child.child,
            );
            items.add(item);
          }
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
  final Widget? child;
  final int? widthRatio;
  final double? percentWidthOnParent;
  final Function(bool)? onHover;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  const ResponsiveItem({
    super.key,
    this.child,
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
