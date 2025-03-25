import 'package:equatable/equatable.dart';

final class FLN extends Equatable {
  const FLN._({required this.title, required this.body, this.date});

  factory FLN.hello() {
    return const FLN._(
      title: 'Hello! 👋',
      body: 'This is a simple notification',
    );
  }

  factory FLN.scheduled(DateTime date) {
    return FLN._(
      title: 'Time to Feed! ⏰',
      body: "Don't forget to feed your hamster!",
      date: date,
    );
  }

  factory FLN.updatable() {
    return const FLN._(title: 'Hamster is Playing! 🐹', body: 'Activity: 0%');
  }

  final String title;
  final String body;
  final DateTime? date;

  @override
  List<Object?> get props => [title, body, date];

  FLN copyWith({String? title, String? body, DateTime? date}) {
    return FLN._(
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
    );
  }

  FLN copyWithRunning(int i) {
    return copyWith(
      title: 'Hamster is Running! 🏃',
      body: 'Activity: ${i * 10}%',
    );
  }

  FLN copyWithTired() {
    return copyWith(title: 'Hamster is Tired! 😴', body: 'Time to rest');
  }
}
