class Batch {
  final String title;
  final String duration;
  final String price;
  final String description;

  Batch({
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
  });
}

final List<Batch> sampleBatches = [
  Batch(
    title: 'UPSC IAS Foundation 2024',
    duration: '12 Months',
    price: '₹25,000',
    description: 'Complete foundation course for UPSC CSE 2024 with Prelims + Mains coverage.',
  ),
  Batch(
    title: 'SSC CGL Target Batch',
    duration: '6 Months',
    price: '₹5,000',
    description: 'Targeted preparation for SSC CGL Tier 1 & 2 with mock tests.',
  ),
  Batch(
    title: 'Banking PO/Clerk Master',
    duration: '4 Months',
    price: '₹3,500',
    description: 'Comprehensive course for IBPS, SBI PO and Clerk exams.',
  ),
  Batch(
    title: 'Railway NTPC Crash Course',
    duration: '3 Months',
    price: '₹2,000',
    description: 'Fast track course for Railway NTPC exams.',
  ),
  Batch(
    title: 'State PSC Integrated',
    duration: '10 Months',
    price: '₹15,000',
    description: 'Integrated approach for State Public Service Commission exams.',
  ),
];
