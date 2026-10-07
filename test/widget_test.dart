import 'package:flutter_test/flutter_test.dart';

import 'package:ks_protection_profile/main.dart';
import 'package:ks_protection_profile/pages/profile_document.dart';

void main() {
  /// Opens the profile document from the cover. Uses explicit pumps because
  /// the cover runs a perpetual ambient animation (so `pumpAndSettle` would
  /// never settle while the cover is on screen).
  Future<void> openDocument(WidgetTester tester) async {
    await tester.pumpWidget(const KsProfileApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.text('READ THE COMPANY PROFILE'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
  }

  testWidgets('Cover renders the company identity', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KsProfileApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('COMPANY PROFILE\n2026 EDITION'), findsOneWidget);
    expect(find.text('PROPERTY'), findsOneWidget);
    expect(find.text('READ THE COMPANY PROFILE'), findsOneWidget);
    expect(find.byType(ProfileDocument), findsNothing);
  });

  testWidgets('Opening the document lands on Introduction', (
    WidgetTester tester,
  ) async {
    await openDocument(tester);

    expect(find.byType(ProfileDocument), findsOneWidget);
    expect(find.text('WHO\nWE ARE'), findsOneWidget);
    expect(find.text('02'), findsOneWidget); // chapter folio
  });
}
