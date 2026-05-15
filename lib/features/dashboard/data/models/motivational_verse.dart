/// Represents a motivational verse to display on the dashboard.
class MotivationalVerse {
  final String id;
  final String arabicText;
  final String translation;
  final String reference; // e.g., "Surah Al-Baqarah 2:255"
  final List<String> tags;

  MotivationalVerse({
    required this.id,
    required this.arabicText,
    required this.translation,
    required this.reference,
    required this.tags,
  });
}