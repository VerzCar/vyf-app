import 'package:equatable/equatable.dart';

class SharedSetting extends Equatable {
  final bool initialUseOfApp;

  const SharedSetting({
    required this.initialUseOfApp,
  });

  factory SharedSetting.fromJson(Map<String, dynamic> json) {
    return SharedSetting(
      initialUseOfApp: json['initialUseOfApp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'initialUseOfApp': initialUseOfApp,
    };
  }

  @override
  List<Object> get props => [
        initialUseOfApp,
      ];
}
