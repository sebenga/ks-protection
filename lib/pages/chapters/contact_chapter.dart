import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../content.dart';
import '../../design.dart';
import '../../widgets/chrome.dart';

/// Chapter 08 — Conclusion & Contact.
///
/// Print page: "08 Conclusion / Contact" (dark). The cell and email lines are
/// live: tapping opens the dialler or the mail client.
class ContactChapter extends StatelessWidget {
  const ContactChapter({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: [
        PageBlock(
          theme: PageTheme.dark,
          section: 'Contact',
          number: '08',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Kicker('06 — Conclusion', t: t),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'COMPLIANT.\nCOMMITTED.\n'),
                    TextSpan(
                      text: 'ON DUTY.',
                      style: const TextStyle(color: C.brass),
                    ),
                  ],
                ),
                style: t.disp(
                  t.h2,
                  weight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Compliance statements.
              Rule(
                side: RuleSide.bottom,
                color: C.line,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < Conclusion.compliance.length; i++)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: i == Conclusion.compliance.length - 1
                                ? 0
                                : 14,
                          ),
                          child: Text(
                            Conclusion.compliance[i],
                            style: t.text(
                              t.small,
                              color: C.onDark2,
                              height: 1.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const _ContactCard(),

              const SizedBox(height: 36),

              // Sign-off — "Aluta Continua" beside the badge and copyright.
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'ALUTA\nCONTINUA',
                      style: t.disp(
                        t.signoff,
                        weight: FontWeight.w900,
                        color: C.brass,
                        height: .8,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'KS PROTECTION\nSERVICEZ PTY LTD\n© ${Company.year}',
                        textAlign: TextAlign.right,
                        style: t.monoLabel(
                          9,
                          color: C.muted,
                          em: .16,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const KsLogo(width: 118, light: true),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const ChapterEnd(label: 'Thank you'),
      ],
    );
  }
}

/// Contact card — brass border with the "Contact Information" label sitting on
/// the top rule (absolute, top:-2.2mm, left:8mm in the print design).
class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: C.brass, width: kB1),
            borderRadius: BorderRadius.circular(kRadius),
          ),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Company.contactName.toUpperCase(),
                style: t.disp(
                  t.name,
                  weight: FontWeight.w800,
                  color: Colors.white,
                  height: .9,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                Company.contactRole.toUpperCase(),
                style: t.monoLabel(9.5, color: C.muted, em: .16, height: 1.5),
              ),
              const SizedBox(height: 22),
              Rule(
                side: RuleSide.top,
                color: C.line,
                pad: 18,
                child: Column(
                  children: [
                    _DetailLine(
                      t: t,
                      label: 'Cell',
                      value: Company.cellDisplay,
                      valueStyle: t.disp(
                        t.contactLine,
                        weight: FontWeight.w700,
                        color: Colors.white,
                        height: 1,
                      ),
                      onTap: () => _open(
                        context,
                        'tel:${Company.cellDial}',
                        'No dialler available on this device',
                      ),
                    ),
                    const SizedBox(height: 20),
                    _DetailLine(
                      t: t,
                      label: 'Email',
                      value: Company.email,
                      valueStyle: t.text(
                        14.5,
                        color: Colors.white,
                        weight: FontWeight.w600,
                        height: 1.4,
                      ),
                      onTap: () => _open(
                        context,
                        'mailto:${Company.email}',
                        'No mail app available on this device',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -9,
          left: 20,
          child: Container(
            color: C.ink,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'CONTACT INFORMATION',
              style: t.monoLabel(9, color: C.brass, em: .2),
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> _open(
    BuildContext context,
    String url,
    String failureMessage,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri.parse(url);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) throw Exception('unsupported');
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(content: Text(failureMessage), backgroundColor: C.ink2),
      );
    }
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({
    required this.t,
    required this.label,
    required this.value,
    required this.valueStyle,
    required this.onTap,
  });

  final T t;
  final String label;
  final String value;
  final TextStyle valueStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 62,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                label.toUpperCase(),
                style: t.monoLabel(9, color: C.brass, em: .16),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(child: Text(value, style: valueStyle)),
                const SizedBox(width: 8),
                Icon(
                  label == 'Cell'
                      ? Icons.phone_in_talk_outlined
                      : Icons.alternate_email_rounded,
                  size: 15,
                  color: C.brass.withValues(alpha: .8),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
