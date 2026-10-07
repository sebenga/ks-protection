import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// Design tokens — KS Protection Servicez · Company Profile 2026
///
/// Ported 1:1 from the HTML design handoff
/// (`design_handoff_company_profile/README.md`). Every colour, weight and
/// geometry value below is traceable to that document:
///   · line weight default 1px (hairline) / 2px (heavy rule), radius 0
///   · print page = 210mm x 297mm, side margin 18mm, content 30mm/28mm
///   · chrome inset 12mm
/// ---------------------------------------------------------------------------

/// Colour tokens.
abstract final class C {
  /// Dark page background, heavy rules on light pages, headline ink.
  static const ink = Color(0xFF0D1117);

  /// Stat card background.
  static const ink2 = Color(0xFF161C25);

  /// Hairlines on dark pages.
  static const line = Color(0xFF2A323D);

  /// Accent — kickers, numbers, highlights, folio.
  static const brass = Color(0xFFC9A24A);

  /// Cover year label.
  static const brass2 = Color(0xFFE2C27A);

  /// Light page background.
  static const paper = Color(0xFFF3F0E8);

  /// Reserved / photo placeholder tint.
  static const paper2 = Color(0xFFE7E2D6);

  /// Runner, folio, secondary labels.
  static const muted = Color(0xFF8A919B);

  /// Body text on light pages.
  static const onLight = Color(0xFF1B1F26);

  /// Body text on dark pages.
  static const onDark = Color(0xFFE9E6DE);

  /// Secondary text on dark pages.
  static const onDark2 = Color(0xFFCFCABD);

  /// Secondary text on light pages.
  static const onLight2 = Color(0xFF4A505A);

  /// Hairlines on light pages (market grid).
  static const hairLight = Color(0xFFC9C3B4);

  /// Cover sub-row label.
  static const coverLabel = Color(0xFFD8D3C6);
}

/// Border weights (`--b1` / `--b2`) and corner radius (`--rad`).
const double kB1 = 1; // hairline
const double kB2 = 2; // heavy rule
const double kRadius = 0; // square, institutional look

/// Font families. Bundled locally so the app matches the design offline.
abstract final class F {
  static const disp = 'BigShouldersDisplay';
  static const body = 'Manrope';
  static const mono = 'JetBrainsMono';
}

/// ---------------------------------------------------------------------------
/// Responsive type scale.
///
/// The handoff prints at A4 (794px logical). Display type is scaled
/// proportionally to the viewport (the designer's own responsive guidance:
/// H1 ≈ 12vw, H2 ≈ 8vw) so the drama of the layout survives. Body / UI copy
/// deliberately does NOT scale proportionally — 11pt on A4 would be ≈10px on
/// a phone — so it uses readable mobile sizes instead.
/// ---------------------------------------------------------------------------
class T {
  const T(this.w);

  /// Clamped content width used to derive display sizes.
  final double w;

  factory T.of(BuildContext context) =>
      T(MediaQuery.sizeOf(context).width.clamp(320.0, 620.0));

  // Display ---------------------------------------------------------------
  double get h1 => (w * 0.128).clamp(40.0, 76.0);
  double get h2 => (w * 0.098).clamp(31.0, 58.0);
  double get h3 => (w * 0.060).clamp(19.0, 30.0);
  double get quote => (w * 0.066).clamp(21.0, 34.0);
  double get rowTitle => (w * 0.060).clamp(20.0, 30.0);
  double get rowNum => (w * 0.070).clamp(22.0, 34.0);
  double get statValue => (w * 0.115).clamp(36.0, 62.0);
  double get name => (w * 0.090).clamp(29.0, 46.0);
  double get signoff => (w * 0.145).clamp(44.0, 76.0);
  double get valueItem => (w * 0.048).clamp(15.0, 22.0);
  double get listItem => (w * 0.049).clamp(16.0, 23.0);
  double get contactLine => (w * 0.062).clamp(20.0, 30.0);

  // Body / UI (mobile-native, not proportional) ----------------------------
  double get lead => 17.5;
  double get body => 15;
  double get small => 13.5;
  double get mono => 10;
  double get kicker => 11;
  double get runner => 9.5;

  // ---------------------------------------------------------------------
  TextStyle disp(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color? color,
    double height = 0.9,
    double em = 0.005,
  }) => TextStyle(
    fontFamily: F.disp,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: size * em,
  );

  /// Mono label style. CSS letter-spacing is expressed in `em`, so the px
  /// value is derived from the font size (e.g. `.12em` at 10px = 1.2px).
  TextStyle monoLabel(
    double size, {
    Color? color,
    double em = 0.12,
    FontWeight weight = FontWeight.w400,
    double? height,
  }) => TextStyle(
    fontFamily: F.mono,
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: size * em,
    height: height,
  );

  TextStyle text(
    double size, {
    Color? color,
    double height = 1.6,
    FontWeight weight = FontWeight.w400,
  }) => TextStyle(
    fontFamily: F.body,
    fontSize: size,
    color: color,
    height: height,
    fontWeight: weight,
  );
}

/// Per-page theme, mirroring the light/dark alternation of the print deck.
class PageTheme {
  const PageTheme({
    required this.background,
    required this.primary,
    required this.secondary,
    required this.hairline,
    required this.rule,
    required this.isDark,
  });

  final Color background;
  final Color primary;
  final Color secondary;
  final Color hairline;
  final Color rule;
  final bool isDark;

  static const light = PageTheme(
    background: C.paper,
    primary: C.onLight,
    secondary: C.onLight2,
    hairline: C.hairLight,
    rule: C.ink,
    isDark: false,
  );

  static const dark = PageTheme(
    background: C.ink,
    primary: C.onDark,
    secondary: C.onDark2,
    hairline: C.line,
    rule: C.line,
    isDark: true,
  );
}
