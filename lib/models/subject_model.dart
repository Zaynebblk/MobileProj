class Subject {
  final String id;
  final String name;      // ex: Traitement du Signal
  final String code;      // ex: TS-201
  final String professor; // ex: Dr. Ahmed
  final double coeff;     // ex: 3.0
  final int semester;     // 1 ou 2
  final String type;      // Cours, TD, TP

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.professor,
    required this.coeff,
    required this.semester,
    required this.type,
  });
}