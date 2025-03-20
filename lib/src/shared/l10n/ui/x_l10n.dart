import 'package:flutter/widgets.dart';
import 'package:samples/src/shared/l10n/domain/l10n.dart';

extension XL10n on BuildContext {
  L10n get l10n => L10n.of(this);
}
