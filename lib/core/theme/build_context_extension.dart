import 'package:flutter/material.dart';
import 'quran_journey_palette.dart';

extension QuranJourneyContextExtension on BuildContext {
  QuranJourneyPalette get qjPalette => Theme.of(this).extension<QuranJourneyPalette>()!;
}