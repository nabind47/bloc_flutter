import 'package:equatable/equatable.dart';

class SwitchStates extends Equatable {
  bool isSwitch;
  double slider;

  SwitchStates({this.isSwitch = false, this.slider = .4});

  SwitchStates copyWith({bool? isSwitch, double? slider}) {
    return SwitchStates(
        isSwitch: isSwitch ?? this.isSwitch, slider: slider ?? this.slider);
  }

  @override
  List<Object?> get props => [isSwitch, slider];
}
