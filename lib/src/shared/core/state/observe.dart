import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class RiverpodObserver extends ProviderObserver {
  const RiverpodObserver([this._name = 'Riverpod']);

  final String _name;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    log('🧪 add: ${provider.name}', name: _name);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if ('$newValue'.length >= 500) return;
    log('''💉 updated: ${provider.name} $newValue''', name: _name);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    log('🩸 disposed: ${provider.name}', name: _name);
  }
}
