import 'package:flutter/material.dart';

extension AppThemeExtension on BuildContext {
  AppTheme theme() => Theme.of(this).extension<AppTheme>()!;

  Color color(Palette p, [double? opacity]) => theme().color(p, opacity);

  TextStyle text(
    Texts t, {
    Palette? color,
    TextWeight? weight,
    List<FontFeature>? fontFeatures,
    TextOverflow? overflow,
  }) => t.get(
    color: this.color(color ?? Palette.textDefault),
    weight: weight,
    fontFeatures: fontFeatures,
    overflow: overflow,
  );

  ThemeData get themeData => theme().themeData;
}

class AppTheme extends ThemeExtension<AppTheme> {
  AppTheme(this.mode);

  factory AppTheme.light() => AppTheme(ThemeMode.light);

  factory AppTheme.dark() => AppTheme(ThemeMode.dark);

  final ThemeMode mode;

  Color color(Palette p, [double? opacity]) =>
      p.get(mode, opacity);


  ThemeData get themeData {
    return ThemeData(
      extensions: [this],
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) return this;
    return AppTheme(other.mode);
  }

  @override
  ThemeExtension<AppTheme> copyWith({ThemeMode? mode}) {
    return AppTheme(mode ?? this.mode);
  }
}

enum Palette {
  staticWhite.static(color: Colors.white),
  staticBlack.static(color: Colors.black),
  authBg.static(color: Color(0xFFD6E2EA)),
  textDefault(light: Colors.black, dark: Colors.grey);

  const Palette({required this.light, required this.dark});

  const Palette.static({required Color color}) : light = color, dark = color;

  final Color light;
  final Color dark;

  Color get(ThemeMode mode, [double? opacity]) => switch (mode) {
    ThemeMode.dark => opacity == null ? dark : dark.withValues(alpha: opacity),
    _ => opacity == null ? light : light.withValues(alpha: opacity),
  };

}

enum Texts {
  headingRegular(30, TextWeight.normal),
  headingMedium(30, TextWeight.medium),
  headingSemiBold(30, TextWeight.semiBold),
  headlineRegular(20, TextWeight.normal),
  headlineMedium(20, TextWeight.medium),
  headlineSemiBold(20, TextWeight.semiBold),
  bodyLargeMedium(18, TextWeight.medium),
  bodyLargeSemiBold(18, TextWeight.semiBold),
  bodyRegular(16, TextWeight.normal),
  bodyMedium(16, TextWeight.medium),
  bodySemiBold(16, TextWeight.semiBold),
  footnoteRegular(14, TextWeight.normal),
  footnoteMedium(14, TextWeight.medium),
  footnoteSemiBold(14, TextWeight.semiBold),
  captionRegular(13, TextWeight.normal),
  captionMedium(13, TextWeight.medium),
  captionSemiBold(13, TextWeight.semiBold),
  smallRegular(12, TextWeight.normal),
  smallMedium(12, TextWeight.medium),
  smallSemiBold(12, TextWeight.semiBold),
  smallBold(12, TextWeight.bold);

  const Texts(this.fontSize, [this.defaultTextWeight = TextWeight.medium]);

  final double fontSize;
  final TextWeight defaultTextWeight;

  TextStyle get({
    required Color color,
    TextWeight? weight,
    List<FontFeature>? fontFeatures,
    TextOverflow? overflow,
  }) => TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: weight?.value ?? defaultTextWeight.value,
    fontFeatures: fontFeatures,
    overflow: overflow,
  );
}

enum TextWeight {
  normal(FontWeight.w400),
  medium(FontWeight.w500),
  semiBold(FontWeight.w600),
  bold(FontWeight.w700);

  const TextWeight(this.value);

  final FontWeight value;
}
