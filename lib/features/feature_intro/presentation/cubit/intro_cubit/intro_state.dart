class IntroState {
  bool showGetStart;

  IntroState({required this.showGetStart});

  IntroState copyWith({
    bool? newShowGetStatrt,
  }) {
    return IntroState(
      showGetStart: newShowGetStatrt ?? showGetStart,
    );
  }
}
