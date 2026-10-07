import 'package:flutter/material.dart';

import '../../content.dart';
import '../../design.dart';
import '../../widgets/chrome.dart';

/// Chapters 04–05 — Our Services.
///
/// Print pages: "04 Services I" and "05 Services II" (both light).
class ServicesChapter extends StatelessWidget {
  const ServicesChapter({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: const [
        _ServicesIntroPage(),
        _ServicesContPage(),
        ChapterEnd(label: 'End of Services'),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 04 — Services I
// ---------------------------------------------------------------------------
class _ServicesIntroPage extends StatelessWidget {
  const _ServicesIntroPage();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final groups = Services.firstThree;
    return PageBlock(
      theme: PageTheme.light,
      section: 'Our Services',
      number: '04',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker('03 — Our Services', t: t),
          const SizedBox(height: 12),
          Text(
            'WHAT\nWE DO',
            style: t.disp(t.h2, weight: FontWeight.w800, color: C.onLight),
          ),
          const SizedBox(height: 16),
          Text(
            Services.intro,
            style: t.text(t.small, color: C.onLight2, height: 1.6),
          ),
          const SizedBox(height: 22),

          // Two photo slots — static guard / patrol vehicle.
          SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 14,
                  child: Photo(
                    asset: 'assets/img/svc-guard.jpg',
                    caption: 'Static guard / access control',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 10,
                  child: Photo(
                    asset: 'assets/img/svc-patrol.jpg',
                    caption: 'Patrol vehicle',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          for (var i = 0; i < groups.length; i++)
            ServiceRow(
              number: groups[i].number,
              title: groups[i].title,
              items: groups[i].items,
              last: i == groups.length - 1,
              showBottomRule: i == groups.length - 1,
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 05 — Services II
// ---------------------------------------------------------------------------
class _ServicesContPage extends StatelessWidget {
  const _ServicesContPage();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final groups = Services.lastThree;
    return PageBlock(
      theme: PageTheme.light,
      section: 'Our Services',
      number: '05',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Kicker('03 — Our Services (cont.)', t: t),
          ),
          for (var i = 0; i < groups.length; i++)
            ServiceRow(
              number: groups[i].number,
              title: groups[i].title,
              items: groups[i].items,
              last: i == groups.length - 1,
              showBottomRule: i == groups.length - 1,
            ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: Photo(
              asset: 'assets/img/svc-control.jpg',
              caption: 'Control room / CCTV monitoring',
              border: C.hairLight,
            ),
          ),
        ],
      ),
    );
  }
}
