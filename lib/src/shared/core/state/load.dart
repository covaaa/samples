import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin Load on AutoDisposeNotifier<Action> {
  Future<void> load(Future<void> Function() future) async {
    state = const Action.loading();
    try {
      await future();
      state = const Action.some();
    } on Exception catch (_) {
      state = const Action.error();
    }
  }
}

final class ActionNone extends Action {
  const ActionNone._() : super._();
}

final class ActionLoading extends Action {
  const ActionLoading._() : super._();
}

final class ActionSome extends Action {
  const ActionSome._() : super._();
}

final class ActionError extends Action {
  const ActionError._() : super._();
}

sealed class Action {
  const Action._();
  const factory Action.none() = ActionNone._;
  const factory Action.loading() = ActionLoading._;
  const factory Action.some() = ActionSome._;
  const factory Action.error() = ActionError._;
}
