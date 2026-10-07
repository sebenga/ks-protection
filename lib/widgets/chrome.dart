import 'package:flutter/material.dart';

import '../design.dart';

/// ---------------------------------------------------------------------------
/// Shared chrome + building blocks used across every page.
/// Mirrors `.runner`, `.folio`, `.kicker`, `.pull`, `.mark` from the handoff.
/// ---------------------------------------------------------------------------

/// Running header: company name left, document title right.
class Runner extends StatelessWidget {
  const Runner({super.key, required this.t, this.color = C.muted});

  final T t;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final style = t.monoLabel(t.runner, color: color);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            'KS Protection Servicez',
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 12),
        Text('Company Profile 2026', style: style),
      ],
    );
  }
}

/// Folio / footer: section name left, brass page number right, over a hairline.
class Folio extends StatelessWidget {
  const Folio({
    super.key,
    required this.t,
    required this.section,
    required this.number,
    this.color = C.muted,
  });

  final T t;
  final String section;
  final String number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: color.withValues(alpha: .9), width: kB1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              section,
              style: t.monoLabel(t.runner, color: color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            number,
            style: t.monoLabel(
              t.runner,
              color: C.brass,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Section eyebrow, e.g. "01 — Introduction".
class Kicker extends StatelessWidget {
  const Kicker(this.text, {super.key, required this.t, this.color = C.brass});

  final String text;
  final T t;
  final Color color;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: t.monoLabel(t.kicker, color: color, em: .2),
  );
}

/// Page shell: background, runner, folio and padded content column.
class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.theme,
    required this.section,
    required this.number,
    required this.children,
    this.cover = false,
    this.bottomPadding = 24,
  });

  final PageTheme theme;
  final String section;
  final String number;
  final List<Widget> children;

  /// Cover pages render their own chrome.
  final bool cover;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return ColoredBox(
      color: theme.background,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, cover ? 0 : 14, 20, bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!cover) ...[Runner(t: t), const SizedBox(height: 18)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
              if (!cover) ...[
                const SizedBox(height: 16),
                Folio(t: t, section: section, number: number),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// One printed page of the deck, rendered as a block inside a chapter scroll.
///
/// Keeps the original page's own background, running header and folio so the
/// light/dark alternation of the print document survives on a phone.
class PageBlock extends StatelessWidget {
  const PageBlock({
    super.key,
    required this.theme,
    required this.child,
    this.section,
    this.number,
    this.showRunner = true,
    this.bleedTop = false,
  });

  final PageTheme theme;
  final Widget child;
  final String? section;
  final String? number;
  final bool showRunner;

  /// Pull the block up to the top of the viewport (photo-led pages).
  final bool bleedTop;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final chromeColor = theme.isDark ? C.muted : C.muted;
    return Container(
      color: theme.background,
      padding: EdgeInsets.fromLTRB(20, bleedTop ? 8 : 26, 20, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showRunner) ...[
            Runner(t: t, color: chromeColor),
            const SizedBox(height: 22),
          ],
          child,
          if (section != null && number != null) ...[
            const SizedBox(height: 22),
            Folio(t: t, section: section!, number: number!, color: chromeColor),
          ],
        ],
      ),
    );
  }
}

/// Closing marker that ends each chapter.
class ChapterEnd extends StatelessWidget {
  const ChapterEnd({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return Container(
      color: C.ink,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 22, height: 2, color: C.brass),
          const SizedBox(width: 12),
          Text(
            label.toUpperCase(),
            style: t.monoLabel(9.5, color: C.muted, em: .18),
          ),
          const SizedBox(width: 12),
          Container(width: 22, height: 2, color: C.brass),
        ],
      ),
    );
  }
}

/// A numbered service row — `grid 16mm / 1fr / 1.25fr` in the print design.
/// On a phone the number and title sit on one line with the bullet list below.
class ServiceRow extends StatelessWidget {
  const ServiceRow({
    super.key,
    required this.number,
    required this.title,
    required this.items,
    required this.last,
    this.showBottomRule = false,
  });

  final String number;
  final String title;
  final List<String> items;
  final bool last;

  /// The print deck draws a bottom rule under the final row of a list.
  final bool showBottomRule;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return Rule(
      side: RuleSide.top,
      width: kB2,
      color: C.ink,
      pad: 16,
      child: Rule(
        side: showBottomRule ? RuleSide.bottom : RuleSide.top,
        width: showBottomRule ? kB2 : 0,
        color: showBottomRule ? C.ink : Colors.transparent,
        pad: showBottomRule ? 16 : 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 52,
                  child: Text(
                    number,
                    style: t.disp(
                      t.rowNum,
                      weight: FontWeight.w800,
                      color: C.brass,
                      height: .85,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: t.disp(
                      t.rowTitle,
                      weight: FontWeight.w700,
                      color: C.onLight,
                      height: .95,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const DiamondBullet(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: t.text(
                          t.small,
                          color: C.onLight,
                          height: 1.45,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Hairline / heavy rule on all four edges, matching the HTML border model.
class BoxBorderAll extends StatelessWidget {
  const BoxBorderAll({
    super.key,
    required this.child,
    this.width = kB1,
    this.color,
    this.padding = EdgeInsets.zero,
    this.radius = kRadius,
  });

  final Widget child;
  final double width;
  final Color? color;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      border: Border.all(color: color ?? C.line, width: width),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}

/// A single-sided rule (top / bottom / left / right).
class Rule extends StatelessWidget {
  const Rule({
    super.key,
    required this.child,
    this.side = RuleSide.top,
    this.color,
    this.width = kB1,
    this.pad = 0,
  });

  final Widget child;
  final RuleSide side;
  final Color? color;
  final double width;

  /// Padding applied on the side opposite the rule (CSS `padding-top` etc.).
  final double pad;

  @override
  Widget build(BuildContext context) {
    final c = color ?? C.line;
    final b = BorderSide(color: c, width: width);
    final edge = switch (side) {
      RuleSide.top => Border(top: b),
      RuleSide.bottom => Border(bottom: b),
      RuleSide.left => Border(left: b),
      RuleSide.right => Border(right: b),
    };
    return Container(
      padding: switch (side) {
        RuleSide.top => EdgeInsets.only(top: pad),
        RuleSide.bottom => EdgeInsets.only(bottom: pad),
        RuleSide.left => EdgeInsets.only(left: pad),
        RuleSide.right => EdgeInsets.only(right: pad),
      },
      decoration: BoxDecoration(border: edge),
      child: child,
    );
  }
}

enum RuleSide { top, bottom, left, right }

/// A photo slot with an `object-fit: cover` image and the design's tinted
/// placeholder showing through while it loads or if the asset is missing.
class Photo extends StatelessWidget {
  const Photo({
    super.key,
    required this.asset,
    this.caption,
    this.fit = BoxFit.cover,
    this.radius = kRadius,
    this.border,
    this.subtle = false,
  });

  final String asset;
  final String? caption;
  final BoxFit fit;
  final double radius;
  final Color? border;

  /// Low emphasis variant (`opacity: 5` in the design's intro slot).
  final bool subtle;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final placeholder = ColoredBox(
      color: C.paper2,
      child: Center(
        child: Text(
          (caption ?? '').toUpperCase(),
          textAlign: TextAlign.center,
          style: t.monoLabel(12, color: C.muted, em: .14, height: 1.6),
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: border == null
              ? null
              : Border.all(color: border!, width: kB1),
        ),
        child: Opacity(
          opacity: subtle ? .55 : 1,
          child: Image.asset(
            asset,
            fit: fit,
            width: double.infinity,
            height: double.infinity,
            // The design's placeholder tint shows through if a photo is absent.
            errorBuilder: (_, __, ___) => placeholder,
            frameBuilder: (_, child, frame, wasSync) {
              if (wasSync || frame != null) return child;
              return placeholder;
            },
          ),
        ),
      ),
    );
  }
}

/// Small square bullet rotated 45° (the design's `.svc li::before`).
class DiamondBullet extends StatelessWidget {
  const DiamondBullet({super.key, this.size = 5, this.color = C.ink});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Transform.translate(
    offset: const Offset(0, -1),
    child: Transform.rotate(
      angle: 0.785398, // 45°
      child: Container(width: size, height: size, color: color),
    ),
  );
}

/// Brass trailing dash used in the "why choose us" rows.
class BrassDash extends StatelessWidget {
  const BrassDash({super.key, this.width = 34});

  final double width;

  @override
  Widget build(BuildContext context) =>
      Container(width: width, height: 2, color: C.brass);
}

/// The client's badge logo. `light` = cream version for dark pages.
class KsLogo extends StatelessWidget {
  const KsLogo({
    super.key,
    required this.width,
    this.light = true,
    this.shadow = false,
  });

  final double width;
  final bool light;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final img = Image.asset(
      light ? 'assets/img/ks-logo-light.png' : 'assets/img/ks-logo-crop.png',
      width: width,
      fit: BoxFit.contain,
    );
    if (!shadow) return img;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .45),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: img,
    );
  }
}
