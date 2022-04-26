part of 'appbar_cubit.dart';

abstract class AppbarState extends Equatable {
  final Color color;
  final Color textColor;
  const AppbarState(this.color, this.textColor);

  @override
  List<Object> get props => [color, textColor];
}

class AppbarArgs extends AppbarState {
  final Color newColor;
  final Color newTextColor;
  const AppbarArgs(this.newColor, this.newTextColor)
      : super(newColor, newTextColor);

  @override
  List<Object> get props => [color, textColor];
}
