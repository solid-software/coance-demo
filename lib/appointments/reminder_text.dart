import 'appointment.dart';

/// The text of the reminder sent the day before a visit. It names no
/// condition or clinician, because texts can be read on a locked screen.
String reminderText(Appointment appointment) {
  final time = appointment.startsAt;
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');

  return 'Acme Health: you have a video visit tomorrow at $hour:$minute. '
      'Open the app to join, or reply C to cancel.';
}
