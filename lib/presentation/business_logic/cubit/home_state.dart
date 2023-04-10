enum HomeType {
  voucher('Voucher'),
  promotion('Promotion');

  const HomeType(this.title);

  final String title;
}

class HomeState {
  final HomeType type;

  HomeState({
    required this.type,
  });

  HomeState copyWith({
    HomeType? type,
  }) {
    return HomeState(
      type: type ?? this.type,
    );
  }
}
