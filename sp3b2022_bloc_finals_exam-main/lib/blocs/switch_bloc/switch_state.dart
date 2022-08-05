part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool switchValue;

  const SwitchState(
      this.switchValue,
      );

  @override
  List<Object> get props => [switchValue];

  Map<String, dynamic> toMap() {
    return {
      'switchValue': switchValue,
    };
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      map['switchValue'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SwitchState.fromJson(String source) =>
      SwitchState.fromMap(json.decode(source));
}

class SwitchBlocInitial extends SwitchState {
  const SwitchBlocInitial() : super(false);
}
