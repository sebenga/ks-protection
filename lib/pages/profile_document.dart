import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../design.dart';
import 'chapters/about_chapter.dart';
import 'chapters/contact_chapter.dart';
import 'chapters/difference_chapter.dart';
import 'chapters/services_chapter.dart';

/// The profile document — the reading half of the app.
///
/// The print deck's seven content pages (02–08) become four chapters:
///   About · Services · Difference · Contact
/// Each chapter keeps the light/dark alternation of the original deck.
class ProfileDocument extends StatefulWidget {
  const ProfileDocument({super.key});

  @override
  State<ProfileDocument> createState() => _ProfileDocumentState();
}

class _ProfileDocumentState extends State<ProfileDocument>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(
    length: _sections.length,
    vsync: this,
  )..addListener(_onTab);
  final _scrolls = List.generate(_sections.length, (_) => ScrollController());
  int _index = 0;

  static const _sections = <_Section>[
    _Section('About', '01 — Introduction', '02–03', C.paper, C.ink),
    _Section('Services', '03 — Our Services', '04–05', C.paper, C.ink),
    _Section('Difference', '04 — The KS Difference', '06–07', C.ink, C.paper),
    _Section('Contact', '06 — Conclusion', '08', C.ink, C.paper),
  ];

  void _onTab() {
    if (_tabs.indexIsChanging) return;
    if (_tabs.index != _index) {
      setState(() => _index = _tabs.index);
    }
  }

  /// Tapping the active tab scrolls that chapter back to the top.
  void _onTapTab(int i) {
    if (i == _index && _scrolls[i].hasClients) {
      _scrolls[i].animateTo(
        0,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    for (final c in _scrolls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final section = _sections[_index];

    // Status bar / system chrome follow the active chapter's page theme.
    final overlay = section.background.computeLuminance() > .5
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: section.background,
        systemNavigationBarIconBrightness:
            section.background.computeLuminance() > .5
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: section.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _Masthead(
                index: _index,
                onBack: () => Navigator.of(context).maybePop(),
              ),
              _TabStrip(controller: _tabs, index: _index, onTap: _onTapTab),
              Expanded(
                child: IndexedStack(
                  index: _index,
                  children: [
                    AboutChapter(controller: _scrolls[0]),
                    ServicesChapter(controller: _scrolls[1]),
                    DifferenceChapter(controller: _scrolls[2]),
                    ContactChapter(controller: _scrolls[3]),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _BottomBar(
          controller: _tabs,
          index: _index,
          onTap: _onTapTab,
          section: section,
        ),
      ),
    );
  }
}

class _Section {
  const _Section(
    this.label,
    this.kicker,
    this.pages,
    this.background,
    this.foreground,
  );

  final String label;
  final String kicker;
  final String pages;
  final Color background;
  final Color foreground;
}

/// Slim masthead: back, document identity, chapter kicker.
class _Masthead extends StatelessWidget {
  const _Masthead({required this.index, required this.onBack});

  final int index;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final section = _ProfileDocumentState._sections[index];
    final fg = section.foreground;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: fg),
            tooltip: 'Back to cover',
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KS PROTECTION SERVICEZ',
                  style: t.monoLabel(
                    10,
                    color: fg,
                    em: .16,
                    weight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  section.kicker.toUpperCase(),
                  style: t.monoLabel(9, color: C.brass, em: .18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            'PAGE ${section.pages}',
            style: t.monoLabel(9.5, color: fg.withValues(alpha: .55), em: .14),
          ),
        ],
      ),
    );
  }
}

/// Swipeable chapter tab strip.
class _TabStrip extends StatelessWidget {
  const _TabStrip({
    required this.controller,
    required this.index,
    required this.onTap,
  });

  final TabController controller;
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final fg = _ProfileDocumentState._sections[index].foreground;
    return SizedBox(
      height: 44,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(height: kB1, color: fg.withValues(alpha: .16)),
            ),
          ),
          TabBar(
            controller: controller,
            onTap: onTap,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            indicatorColor: C.brass,
            labelColor: fg,
            unselectedLabelColor: fg.withValues(alpha: .45),
            labelPadding: EdgeInsets.zero,
            tabs: [
              for (final s in _ProfileDocumentState._sections)
                Tab(
                  height: 42,
                  child: Text(
                    s.label.toUpperCase(),
                    style: t.monoLabel(10, em: .12),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Persistent bottom navigation — jump straight to any chapter.
class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.controller,
    required this.index,
    required this.onTap,
    required this.section,
  });

  final TabController controller;
  final int index;
  final ValueChanged<int> onTap;
  final _Section section;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final icons = [
      Icons.shield_outlined,
      Icons.grid_view_outlined,
      Icons.workspace_premium_outlined,
      Icons.call_outlined,
    ];
    return Container(
      decoration: BoxDecoration(
        color: section.background,
        border: Border(
          top: BorderSide(color: section.foreground.withValues(alpha: .16)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: [
              for (var i = 0; i < _ProfileDocumentState._sections.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onTap(i);
                      if (!controller.indexIsChanging) controller.animateTo(i);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[i],
                          size: 20,
                          color: i == index
                              ? C.brass
                              : section.foreground.withValues(alpha: .45),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _ProfileDocumentState._sections[i].label
                              .toUpperCase(),
                          style: t.monoLabel(
                            8.5,
                            em: .1,
                            color: i == index
                                ? C.brass
                                : section.foreground.withValues(alpha: .45),
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
    );
  }
}
