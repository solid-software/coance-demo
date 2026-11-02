/// A video visit between a patient and a clinician.
class Appointment {
  final String id;
  final String patientId;
  final String clinicianId;
  final DateTime startsAt;
  final Duration length;

  const Appointment({
    required this.id,
    required this.patientId,
    required this.clinicianId,
    required this.startsAt,
    this.length = const Duration(minutes: 20),
  });

  DateTime get endsAt => startsAt.add(length);

  bool overlaps(Appointment other) =>
      startsAt.isBefore(other.endsAt) && other.startsAt.isBefore(endsAt);
}
