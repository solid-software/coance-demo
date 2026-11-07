import 'appointment.dart';

/// How a patient cancelled a visit.
enum CancellationKind { inTime, late, noShow }

/// Visits cancelled less than this long before they start are late.
const lateCancellationWindow = Duration(hours: 24);

/// Whether cancelling [appointment] at [now] is in time, late or a no-show.
CancellationKind classifyCancellation(Appointment appointment, DateTime now) {
  if (!now.isBefore(appointment.startsAt)) return CancellationKind.noShow;
  final notice = appointment.startsAt.difference(now);

  return notice < lateCancellationWindow
      ? CancellationKind.late
      : CancellationKind.inTime;
}
