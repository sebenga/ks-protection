import 'package:flutter/material.dart';

import '../../content.dart';
import '../../design.dart';
import '../../widgets/chrome.dart';

/// Chapters 06–07 — The KS Difference and Target Market.
///
/// Print pages: "06 Why Choose Us" (dark) and "07 Target Market" (light).
class DifferenceChapter extends StatelessWidget {
  const DifferenceChapter({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: const [
        _WhyChoosePage(),
        _MarketPage(),
        ChapterEnd(label: 'End of Difference'),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 06 — Why Choose Us
// ---------------------------------------------------------------------------
class _WhyChoosePage extends StatelessWidget {
  const _WhyChoosePage();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return PageBlock(
      theme: PageTheme.dark,
      section: 'Why Choose Us',
      number: '06',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker('04 — The KS Difference', t: t),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'WHY CHOOSE\n'),
                TextSpan(
                  text: 'KS PROTECTION?',
                  style: const TextStyle(color: C.brass),
                ),
              ],
            ),
            style: t.disp(t.h2, weight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 22),

          // Stat cards.
          Row(
            children: [
              for (var i = 0; i < Difference.stats.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    t: t,
                    value: Difference.stats[i].$1,
                    label: Difference.stats[i].$2,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 26),

          // Reasons list — numbered rows with a trailing brass dash.
          for (var i = 0; i < Difference.reasons.length; i++)
            Rule(
              side: RuleSide.top,
              color: C.line,
              pad: 16,
              child: Rule(
                side: i == Difference.reasons.length - 1
                    ? RuleSide.bottom
                    : RuleSide.top,
                color: i == Difference.reasons.length - 1
                    ? C.line
                    : Colors.transparent,
                width: kB1,
                pad: i == Difference.reasons.length - 1 ? 16 : 0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 34,
                      child: Text(
                        (i + 1).toString().padLeft(2, '0'),
                        style: t.monoLabel(10, color: C.brass, em: .12),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Difference.reasons[i].toUpperCase(),
                        style: t.disp(
                          t.rowTitle,
                          weight: FontWeight.w700,
                          color: Colors.white,
                          height: .95,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const BrassDash(width: 30),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.t, required this.value, required this.label});

  final T t;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
    decoration: BoxDecoration(
      color: C.ink2,
      border: Border.all(color: C.line),
      borderRadius: BorderRadius.circular(kRadius),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value.toUpperCase(),
          style: t.disp(
            t.statValue,
            weight: FontWeight.w900,
            color: C.brass,
            height: .8,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label.toUpperCase(),
          style: t.monoLabel(9.5, color: C.onDark2, em: .14, height: 1.4),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 07 — Target Market
// ---------------------------------------------------------------------------
class _MarketPage extends StatelessWidget {
  const _MarketPage();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final sectors = Market.sectors;
    return PageBlock(
      theme: PageTheme.light,
      section: 'Target Market',
      number: '07',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker('05 — Target Market', t: t),
          const SizedBox(height: 12),
          Text(
            'WHO\nWE PROTECT',
            style: t.disp(t.h2, weight: FontWeight.w800, color: C.onLight),
          ),
          const SizedBox(height: 22),

          // Sector grid — heavy rule on top, hairlines between cells.
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: C.ink, width: kB2),
              ),
            ),
            child: Column(
              children: [
                for (var i = 0; i < sectors.length; i += 2)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _SectorCell(
                          t: t,
                          index: i,
                          name: sectors[i],
                          right: true,
                        ),
                      ),
                      Expanded(
                        child: i + 1 < sectors.length
                            ? _SectorCell(
                                t: t,
                                index: i + 1,
                                name: sectors[i + 1],
                                right: false,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 160,
            child: Photo(
              asset: 'assets/img/mkt-strip.jpg',
              caption: 'Estate gate, shopping centre or event',
            ),
          ),
        ],
      ),
    );
  }
}

class _SectorCell extends StatelessWidget {
  const _SectorCell({
    required this.t,
    required this.index,
    required this.name,
    required this.right,
  });

  final T t;
  final int index;
  final String name;
  final bool right;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 78),
    decoration: BoxDecoration(
      border: Border(
        bottom: const BorderSide(color: C.hairLight, width: kB1),
        right: right
            ? const BorderSide(color: C.hairLight, width: kB1)
            : BorderSide.none,
      ),
    ),
    padding: EdgeInsets.fromLTRB(right ? 12 : 18, 14, 12, 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 26,
          child: Text(
            (index + 1).toString().padLeft(2, '0'),
            style: t.monoLabel(9.5, color: C.brass, em: .12),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            name.toUpperCase(),
            style: t.disp(
              t.listItem,
              weight: FontWeight.w700,
              color: C.onLight,
              height: .95,
            ),
          ),
        ),
      ],
    ),
  );
}
