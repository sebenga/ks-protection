import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../content.dart';
import '../design.dart';
import '../widgets/chrome.dart';
import 'profile_document.dart';

/// 01 — Cover.
///
/// Mobile interpretation of the A4 cover: a full-bleed photo under the
/// handoff's four-stop gradient, the logo and edition label at the top, and
/// the display title block anchored near the bottom. A single brass affordance
/// opens the profile document.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _scroll = ScrollController();
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..forward();

  /// Slow ambient drift for the cover photo (repeat with reverse).
  late final AnimationController _drift = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 18),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _scroll.dispose();
    _intro.dispose();
    _drift.dispose();
    super.dispose();
  }

  void _open() {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 380),
        pageBuilder: (_, __, ___) => const ProfileDocument(),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: SlideTransition(
            position: Tween(begin: const Offset(0, .04), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                ),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final t = T.of(context);

    return Scaffold(
      backgroundColor: C.ink,
      // The cover keeps a perpetual affordance animation; stop its ticker as
      // soon as the profile document is pushed on top of it.
      body: TickerMode(
        enabled: ModalRoute.of(context)?.isCurrent ?? true,
        child: _buildCover(t, media),
      ),
    );
  }

  Widget _buildCover(T t, MediaQueryData media) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Full-bleed cover photo with a slow, subtle Ken Burns drift.
        ClipRect(
          child: AnimatedBuilder(
            animation: _drift,
            builder: (_, __) => Transform.scale(
              scale: 1.06 + 0.045 * _drift.value,
              child: Image.asset(
                'assets/img/cover.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => const ColoredBox(color: C.ink2),
              ),
            ),
          ),
        ),

        // Gradient shade — exactly the four stops from the design.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x8C0D1117), // rgba(13,17,23,.55)
                Color(0x260D1117), // rgba(13,17,23,.15)
                Color(0xEB0D1117), // rgba(13,17,23,.92)
                C.ink,
              ],
              stops: [0.0, 0.35, 0.72, 1.0],
            ),
          ),
        ),

        // Content — scrolls so short screens never clip the title block.
        SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            controller: _scroll,
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: media.size.height - media.padding.top,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _top(t),
                      const SizedBox(height: 40),
                      _titleBlock(t),
                      const Spacer(),
                      const SizedBox(height: 40),
                      _bottomRow(t),
                      const SizedBox(height: 12),
                      _exploreBar(t),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Logo left · edition label right (design: top:16mm, logo 52mm wide).
  Widget _top(T t) => FadeTransition(
    opacity: CurvedAnimation(parent: _intro, curve: const Interval(0, .5)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KsLogo(width: 150, light: true, shadow: true),
        const Spacer(),
        Text(
          'COMPANY PROFILE\n2026 EDITION',
          textAlign: TextAlign.right,
          style: t.monoLabel(10, color: C.brass2, em: .2, height: 1.7),
        ),
      ],
    ),
  );

  Widget _titleBlock(T t) {
    final rise = CurvedAnimation(
      parent: _intro,
      curve: const Interval(.15, 1, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: rise,
      builder: (_, child) => Opacity(
        opacity: rise.value,
        child: Transform.translate(
          offset: Offset(0, 26 * (1 - rise.value)),
          child: child,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker(Company.tagline, t: t),
          const SizedBox(height: 12),
          _Headline(t: t),
          const SizedBox(height: 22),
          Row(
            children: [
              Container(width: 48, height: 2, color: C.brass),
              const SizedBox(width: 14),
              Flexible(
                child: Text(
                  Company.disciplines.toUpperCase(),
                  style: t.monoLabel(
                    10.5,
                    color: C.coverLabel,
                    em: .22,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomRow(T t) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Text(
          Company.legalName,
          style: t.monoLabel(9.5, color: C.muted, em: .14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        Company.operation.toUpperCase(),
        style: t.monoLabel(9.5, color: C.muted, em: .14),
      ),
    ],
  );

  Widget _exploreBar(T t) => FadeTransition(
    opacity: CurvedAnimation(parent: _intro, curve: const Interval(.6, 1)),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _open,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(
              color: C.brass.withValues(alpha: .55),
              width: kB1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'READ THE COMPANY PROFILE',
                style: t.monoLabel(10, color: C.brass, em: .18),
              ),
              const SizedBox(width: 12),
              const _BounceChevron(),
            ],
          ),
        ),
      ),
    ),
  );
}

/// "Safeguarding / People, / Property / & Assets." — "Property" in brass.
class _Headline extends StatelessWidget {
  const _Headline({required this.t});

  final T t;

  @override
  Widget build(BuildContext context) {
    final base = t.disp(
      t.h1,
      weight: FontWeight.w900,
      color: Colors.white,
      height: 0.82,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SAFE\u00ADGUARDING', style: base),
        Text('PEOPLE,', style: base),
        Text('PROPERTY', style: base.copyWith(color: C.brass)),
        Text('& ASSETS.', style: base),
      ],
    );
  }
}

class _BounceChevron extends StatefulWidget {
  const _BounceChevron();

  @override
  State<_BounceChevron> createState() => _BounceChevronState();
}

class _BounceChevronState extends State<_BounceChevron>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _c,
    builder: (_, __) {
      final v = math.sin(_c.value * math.pi * 2);
      return Transform.translate(
        offset: Offset(0, v * 3),
        child: const Icon(Icons.keyboard_arrow_down, color: C.brass, size: 20),
      );
    },
  );
}
