import 'package:flutter/material.dart';

import '../../content.dart';
import '../../design.dart';
import '../../widgets/chrome.dart';

/// Chapters 02–03 — Introduction and Purpose.
///
/// Print pages: "02 Introduction" (light) and "03 Mission · Vision · Values"
/// (dark).
class AboutChapter extends StatelessWidget {
  const AboutChapter({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: const [
        _IntroductionPage(),
        _PurposePage(),
        ChapterEnd(label: 'End of Introduction'),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 02 — Introduction
// ---------------------------------------------------------------------------
class _IntroductionPage extends StatelessWidget {
  const _IntroductionPage();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return PageBlock(
      theme: PageTheme.light,
      section: 'Introduction',
      number: '02',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker('01 — Introduction', t: t),
          const SizedBox(height: 12),
          Text(
            'WHO\nWE ARE',
            style: t.disp(t.h2, weight: FontWeight.w800, color: C.onLight),
          ),
          const SizedBox(height: 20),

          // Lead paragraph — company name emphasised, per the design.
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: Company.legalName,
                  style: t.text(
                    t.lead,
                    color: C.ink,
                    height: 1.45,
                    weight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: Intro.lead.substring(Company.legalName.length),
                  style: t.text(
                    t.lead,
                    color: C.ink,
                    height: 1.45,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            Intro.body,
            style: t.text(t.body, color: C.onLight2, height: 1.6),
          ),
          const SizedBox(height: 22),

          // Photo slot — team / officer on site.
          SizedBox(
            height: 250,
            child: Photo(
              asset: 'assets/img/intro.jpg',
              caption: 'Team or officer on site',
            ),
          ),
          const SizedBox(height: 22),

          // Pull block pinned after the photo on mobile (margin-top:auto on A4).
          Rule(
            side: RuleSide.top,
            width: kB2,
            color: C.ink,
            pad: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Kicker('Industry Context', t: t, color: C.onLight2),
                const SizedBox(height: 8),
                Text(
                  Intro.context,
                  style: t.text(t.small, color: C.onLight2, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 03 — Mission · Vision · Values
// ---------------------------------------------------------------------------
class _PurposePage extends StatelessWidget {
  const _PurposePage();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return PageBlock(
      theme: PageTheme.dark,
      section: 'Mission · Vision · Values',
      number: '03',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker('02 — Purpose', t: t),

          // Vision ---------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 26, 0, 30),
            child: Rule(
              side: RuleSide.bottom,
              color: C.line,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Kicker('Our Vision', t: t, color: C.muted),
                  const SizedBox(height: 14),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: Purpose.visionLead),
                        TextSpan(
                          text: Purpose.visionAccent,
                          style: const TextStyle(color: C.brass),
                        ),
                        TextSpan(text: Purpose.visionTail),
                      ],
                    ),
                    style: t.disp(
                      t.quote,
                      weight: FontWeight.w700,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Mission --------------------------------------------------------
          Rule(
            side: RuleSide.bottom,
            color: C.line,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OUR\nMISSION',
                    style: t.disp(
                      t.h3,
                      weight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  for (var i = 0; i < Purpose.mission.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: i == Purpose.mission.length - 1 ? 0 : 16,
                      ),
                      child: Rule(
                        side: RuleSide.top,
                        color: C.line,
                        pad: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (i + 1).toString().padLeft(2, '0'),
                              style: t.monoLabel(9.5, color: C.brass, em: .12),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Purpose.mission[i],
                              style: t.text(
                                t.small,
                                color: C.onDark2,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Core values ----------------------------------------------------
          const SizedBox(height: 30),
          Text(
            'CORE VALUES',
            style: t.disp(t.h3, weight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(height: 14),
          const _ValueGrid(),
        ],
      ),
    );
  }
}

/// Six values in a bordered 2-column grid (a 3-column grid on the A4 page; two
/// columns keeps the type readable at phone width).
class _ValueGrid extends StatelessWidget {
  const _ValueGrid();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: C.line, width: kB1),
          left: BorderSide(color: C.line, width: kB1),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          const gap = 0.0;
          final cellW = (c.maxWidth - gap) / 2;
          return Wrap(
            children: [
              for (var i = 0; i < Purpose.values.length; i++)
                SizedBox(
                  width: cellW,
                  height: 96,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: C.line, width: kB1),
                        bottom: BorderSide(color: C.line, width: kB1),
                      ),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'V.${(i + 1).toString().padLeft(2, '0')}',
                          style: t.monoLabel(9, color: C.muted, em: .12),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              Purpose.values[i].toUpperCase(),
                              style: t.disp(
                                t.valueItem,
                                weight: FontWeight.w700,
                                color: Colors.white,
                                height: .95,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
