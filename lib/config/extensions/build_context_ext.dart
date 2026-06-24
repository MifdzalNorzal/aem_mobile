import 'package:flutter/material.dart';
import 'package:aem_mobile/l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
