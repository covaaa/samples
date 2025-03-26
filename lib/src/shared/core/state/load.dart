import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin Load<T> on AutoDisposeAsyncNotifier<T> {
  Future<void> load(Future<T> Function() future) async {
    state = AsyncLoading<T>();
    state = await AsyncValue.guard<T>(future);
  }
}
