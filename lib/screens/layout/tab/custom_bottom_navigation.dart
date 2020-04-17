// Copyright (c) 2018 Edwin Jose. All rights reserved.
// Licensed under the MIT license. See LICENSE file for full information.

import 'package:Core/utils/theme.dart';
import 'package:flutter/material.dart';

final Color defaultColor = Colors.grey[700];

final Color defaultOnSelectColor = Colors.blue;
const double BAR_HEIGHT = kBottomNavigationBarHeight;

class BottomNav extends StatefulWidget {
  final int index;
  final void Function(int i) onTap;
  final List<BottomNavItem> items;
  final double elevation;
  final IconStyle iconStyle;
  final Color color;
  final LabelStyle labelStyle;
  final Color indicatorColor;
  final double indicatorWeight;
  BottomNav(
      {this.index,
      this.onTap,
      this.items,
      this.elevation = 8.0,
      this.iconStyle,
      this.color = Colors.white,
      this.labelStyle,
      this.indicatorWeight = 1.0,
      this.indicatorColor = Colors.white})
      : assert(items != null),
        assert(items.length >= 2);

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int currentIndex;
  IconStyle iconStyle;
  LabelStyle labelStyle;
  double indicatorAlignX = 0;

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    setAlignX();
    iconStyle = widget.iconStyle ?? IconStyle();
    labelStyle = widget.labelStyle ?? LabelStyle();
    super.initState();
  }

  @override
  void didUpdateWidget(BottomNav oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (oldWidget.index != widget.index) {
      currentIndex = widget.index;
      setAlignX();
    } else {
      currentIndex = widget.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.biggest.width / widget.items.length;
        final fullWidth = constraints.biggest.width;
        return SafeArea(
          child: Container(
            height: kBottomNavigationBarHeight,
            width: fullWidth,
            // padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, border: Border(top: borderSide)
                // boxShadow: [
                //   BoxShadow(color: Colors.black12, blurRadius: blurRadius),
                // ],
                ),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned.fill(
                  top: 0,
                  child: Row(
                    children: widget.items.map((b) {
                      final int i = widget.items.indexOf(b);
                      final bool selected = i == currentIndex;

                      return BMNavItem(
                        width,
                        key: Key(b.key),
                        icon: selected ? b.activeIcon : b.icon,
                        iconSize: selected
                            ? iconStyle.getSelectedSize()
                            : iconStyle.getSize(),
                        label: parseLabel(b.label, labelStyle, selected),
                        onTap: () => onItemClick(i),
                        textStyle: selected
                            ? labelStyle.getOnSelectTextStyle()
                            : labelStyle.getTextStyle(),
                        color: selected
                            ? iconStyle.getSelectedColor()
                            : iconStyle.getColor(),
                        indicatorWeight: widget.indicatorWeight,
                      );

                      // return _buildItemWidget(i, true);
                    }).toList(),
                  ),
                ),
                Positioned(
                  // bottom: 0,
                  top: 0,
                  width: fullWidth,
                  child: AnimatedAlign(
                    alignment: Alignment(indicatorAlignX, 0),
                    curve: Curves.linear,
                    duration: Duration(milliseconds: 250),
                    child: Container(
                      width: width,
                      height: widget.indicatorWeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            color: widget.indicatorColor,
                            width: width - 40,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onItemClick(int i) {
    setState(() {
      currentIndex = i;
    });
    if (widget.onTap != null) widget.onTap(i);
    setAlignX();
  }

  parseLabel(String label, LabelStyle style, bool selected) {
    if (!style.isVisible()) {
      return null;
    }

    if (style.isShowOnSelect()) {
      return selected ? label : null;
    }

    return label;
  }

  setAlignX() {
    indicatorAlignX = -1 + (2 / (widget.items.length - 1) * currentIndex);
  }
}

class BottomNavItem {
  /// icon lúc chưa active
  final Widget icon;

  ///icon lúc active
  final Widget activeIcon;

  /// text phía dưới icon
  final String label;

  final String key;

  BottomNavItem(this.icon, this.activeIcon, {this.label, this.key});
}

class LabelStyle {
  final bool visible;
  final bool showOnSelect;
  final TextStyle textStyle;
  final TextStyle onSelectTextStyle;

  LabelStyle(
      {this.visible,
      this.showOnSelect,
      this.textStyle,
      this.onSelectTextStyle});

  isVisible() {
    return visible ?? true;
  }

  isShowOnSelect() {
    return showOnSelect ?? false;
  }

  // getTextStyle returns `textStyle` with default `fontSize` and
  // `color` values if not provided. if `textStyle` is null then
  // returns default text style
  getTextStyle() {
    if (textStyle != null) {
      return TextStyle(
        inherit: textStyle.inherit,
        color: textStyle.color ?? defaultOnSelectColor,
        fontSize: textStyle.fontSize ?? 12.0,
        fontWeight: textStyle.fontWeight,
        fontStyle: textStyle.fontStyle,
        letterSpacing: textStyle.letterSpacing,
        wordSpacing: textStyle.wordSpacing,
        textBaseline: textStyle.textBaseline,
        height: textStyle.height,
        locale: textStyle.locale,
        foreground: textStyle.foreground,
        background: textStyle.background,
        decoration: textStyle.decoration,
        decorationColor: textStyle.decorationColor,
        decorationStyle: textStyle.decorationStyle,
        debugLabel: textStyle.debugLabel,
        fontFamily: textStyle.fontFamily,
      );
    }
    return TextStyle(color: defaultColor, fontSize: 12.0);
  }

  // getOnSelectTextStyle returns `onSelectTextStyle` with
  // default `fontSize` and `color` values if not provided. if
  // `onSelectTextStyle` is null then returns default text style
  getOnSelectTextStyle() {
    if (onSelectTextStyle != null) {
      return TextStyle(
        inherit: onSelectTextStyle.inherit,
        color: onSelectTextStyle.color ?? defaultOnSelectColor,
        fontSize: onSelectTextStyle.fontSize ?? 12.0,
        fontWeight: onSelectTextStyle.fontWeight,
        fontStyle: onSelectTextStyle.fontStyle,
        letterSpacing: onSelectTextStyle.letterSpacing,
        wordSpacing: onSelectTextStyle.wordSpacing,
        textBaseline: onSelectTextStyle.textBaseline,
        height: onSelectTextStyle.height,
        locale: onSelectTextStyle.locale,
        foreground: onSelectTextStyle.foreground,
        background: onSelectTextStyle.background,
        decoration: onSelectTextStyle.decoration,
        decorationColor: onSelectTextStyle.decorationColor,
        decorationStyle: onSelectTextStyle.decorationStyle,
        debugLabel: onSelectTextStyle.debugLabel,
        fontFamily: onSelectTextStyle.fontFamily,
      );
    }
    return TextStyle(color: defaultOnSelectColor, fontSize: 12.0);
  }
}

class IconStyle {
  final double size;
  final double onSelectSize;
  final Color color;
  final Color onSelectColor;

  IconStyle({this.size, this.onSelectSize, this.color, this.onSelectColor});

  getSize() {
    return size ?? 24.0;
  }

  getSelectedSize() {
    return onSelectSize ?? 24.0;
  }

  getColor() {
    return color ?? defaultColor;
  }

  getSelectedColor() {
    return onSelectColor ?? defaultOnSelectColor;
  }
}

class BMNavItem extends StatelessWidget {
  final Widget icon;
  final double iconSize;
  final String label;
  final void Function() onTap;
  final Color color;
  final TextStyle textStyle;
  final double width;
  final double indicatorWeight;
  BMNavItem(
    this.width, {
    Key key,
    this.icon,
    this.iconSize,
    this.label,
    this.onTap,
    this.color,
    this.textStyle,
    this.indicatorWeight,
  })  : assert(icon != null),
        assert(iconSize != null),
        assert(color != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          // color: Colors.greenAccent[r * 100],
          padding: getPadding(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: iconSize,
                width: iconSize,
                child: icon,
              ),
              label != null ? Text(label, style: textStyle) : Container()
            ],
          ),
        ),
      ),
    );
  }

  // getPadding returns the padding after adjusting the top and bottom
  // padding based on the fontsize and iconSize.
  getPadding() {
    if (label != null) {
      final double p =
          ((BAR_HEIGHT - textStyle.fontSize) - iconSize) / 2 - indicatorWeight;
      return EdgeInsets.fromLTRB(0.0, p.abs(), 0.0, 0);
    }
    final double p = (BAR_HEIGHT - iconSize) / 2 - indicatorWeight;
    return EdgeInsets.fromLTRB(0.0, p.abs(), 0.0, p.abs());
  }
}
