/// ---------------------------------------------------------------------------
/// Company profile copy.
///
/// Verbatim from the signed client profile as transcribed in the design
/// handoff (`KS Protection Servicez profile2026 -signed.pdf`). Spelling was
/// lightly corrected in the handoff and "presidential communities" was read as
/// "residential communities" — both kept as-is here.
/// ---------------------------------------------------------------------------
abstract final class Company {
  static const name = 'KS Protection Servicez';
  static const legalName = 'KS Protection Servicez Pty Ltd';
  static const year = '2026';
  static const tagline = 'South Africa · Private Security';
  static const disciplines = 'Guarding · Patrols · Surveillance · Risk';
  static const operation = '24/7 Security Operation';

  static const contactName = 'Sheriff Nodada';
  static const contactRole = 'CIC · KS Protection Servicez Pty Ltd';
  static const cellDisplay = '079 583 8551';
  static const cellDial = '+27795838551';
  static const email = 'nodadasheriff073@gmail.com';
}

/// 01 — Introduction
abstract final class Intro {
  static const lead =
      'KS Protection Servicez Pty Ltd is a South African security services company, committed to providing '
      'professional, reliable & cost-effective security solutions to businesses, government institutions, '
      'residential communities and private clients.';

  static const body =
      'Our mission is to safeguard people, properties and assets through highly trained security personnel, '
      'advanced security systems and exceptional customer service.';

  static const context =
      'The private security industry in South Africa continues to play a critical role in protecting communities '
      'and businesses — with companies focusing on guarding, patrols, surveillance and risk management services.';
}

/// 02 — Purpose
abstract final class Purpose {
  static const visionLead = 'To become one of South Africa’s ';
  static const visionAccent = 'leading security service providers';
  static const visionTail =
      ' — recognised for integrity and excellence in protection services.';

  static const mission = <String>[
    'To provide reliable and effective security solutions.',
    'To protect clients’ assets, people and information.',
    'To maintain the highest standards of professionalism & ethical conduct.',
    'To build long-term relationships through quality service delivery.',
  ];

  static const values = <String>[
    'Confidentiality',
    'Integrity',
    'Professionalism',
    'Accountability',
    'Excellence',
    'Customer Satisfaction',
  ];
}

/// 03 — Our Services
class ServiceGroup {
  const ServiceGroup({
    required this.number,
    required this.title,
    required this.items,
  });

  final String number;
  final String title;
  final List<String> items;
}

abstract final class Services {
  static const intro =
      'A full spectrum of protection — from officers on the ground to risk strategy in the boardroom.';

  static const all = <ServiceGroup>[
    ServiceGroup(
      number: '01',
      title: 'Guarding Services',
      items: [
        'Static Guard',
        'Residential Security',
        'Industrial Security',
        'Retail Security',
        'Access Control',
      ],
    ),
    ServiceGroup(
      number: '02',
      title: 'Patrol Services',
      items: ['Mobile Patrols', 'Site Inspection', 'Alarm Response'],
    ),
    ServiceGroup(
      number: '03',
      title: 'Event Security',
      items: ['Crowd Control', 'VIP Protection', 'Event Access Management'],
    ),
    ServiceGroup(
      number: '04',
      title: 'Risk Management',
      items: [
        'Security Risk Assessment',
        'Security Consulting',
        'Loss Prevention Strategies',
      ],
    ),
    ServiceGroup(
      number: '05',
      title: 'Surveillance & Monitoring',
      items: [
        'CCTV Monitoring',
        'Control Room Operation',
        'Incident Reporting',
      ],
    ),
    ServiceGroup(
      number: '06',
      title: 'Special Protection',
      items: ['Escort Services', 'Asset Protection', 'Executive Protection'],
    ),
  ];

  /// Services I page (01–03).
  static List<ServiceGroup> get firstThree => all.take(3).toList();

  /// Services II page (04–06).
  static List<ServiceGroup> get lastThree => all.skip(3).toList();
}

/// 04 — The KS Difference
abstract final class Difference {
  static const stats = <(String, String)>[
    ('24/7', 'Security Operation'),
    ('Fast', 'Response Capability'),
  ];

  static const reasons = <String>[
    'Highly trained security officers',
    'Professional & disciplined workforce',
    'Client-focused approach',
    'Competitive pricing',
    'Commitment to safety & compliance',
  ];
}

/// 05 — Target Market
abstract final class Market {
  static const sectors = <String>[
    'Retail Stores',
    'Government Departments',
    'Municipalities',
    'Schools & Universities',
    'Hospitals & Clinics',
    'Shopping Centres',
    'Construction Sites',
    'Residential Estates',
    'Warehouses & Logistics',
    'Events & Entertainment Venues',
  ];
}

/// 06 — Conclusion
abstract final class Conclusion {
  static const compliance = <String>[
    'KS Protection Servicez Pty Ltd is committed to operating in accordance with all applicable South African '
        'security regulations and industry standards.',
    'Our personnel are trained to perform their duties responsibly while maintaining the highest standards of '
        'safety and professionalism.',
  ];

  static const signoff = 'Aluta Continua';
}
