import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/features/fln/domain/fln.dart';
import 'package:samples/src/features/fln/infra/fln_service.dart';
import 'package:samples/src/shared/core/core.dart';
part 'create.g.dart';

@riverpod
class CreateFLN extends _$CreateFLN with Load<void> {
  late FLNService _service;

  @override
  FutureOr<void> build() async {
    _service = ref.watch(flnServiceProvider);
  }

  FutureOr<void> run() {
    return super.load(() => _service.create(FLN.hello()));
  }

  FutureOr<void> runScheduled(DateTime date) {
    return super.load(() => _service.createScheduled(FLN.scheduled(date)));
  }

  FutureOr<void> runUpdatable() {
    return super.load(() => _service.createUpdatable(FLN.updatable()));
  }
}
