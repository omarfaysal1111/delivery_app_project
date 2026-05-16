import 'package:flutter/material.dart';

/// Validation runs only after the first primary-button submit attempt.
AutovalidateMode authAutovalidateMode(bool hasAttemptedSubmit) {
  return hasAttemptedSubmit
      ? AutovalidateMode.onUserInteraction
      : AutovalidateMode.disabled;
}
