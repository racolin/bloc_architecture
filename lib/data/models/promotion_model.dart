class PromotionModel {
  final String id;
  final String image;
  final String partner;
  final String title;
  final String description;
  final DateTime expire;
  final int from;
  final int categoryId;
  final int userFor;
  final int score;
  final int rate;

  PromotionModel({
    required this.id,
    required this.image,
    required this.partner,
    required this.title,
    required this.description,
    required this.expire,
    required this.from,
    required this.categoryId,
    required this.userFor,
    required this.score,
    required this.rate,
  });

  PromotionModel copyWith({
    String? id,
    String? image,
    String? partner,
    String? title,
    String? description,
    DateTime? expire,
    int? from,
    int? categoryId,
    int? userFor,
    int? score,
    int? rate,
  }) {
    return PromotionModel(
      id: id ?? this.id,
      image: image ?? this.image,
      partner: partner ?? this.partner,
      title: title ?? this.title,
      description: description ?? this.description,
      expire: expire ?? this.expire,
      from: from ?? this.from,
      categoryId: categoryId ?? this.categoryId,
      userFor: userFor ?? this.userFor,
      score: score ?? this.score,
      rate: rate ?? this.rate,
    );
  }

  @override
  String toString() {
    return 'PromotionModel{'
        'id: $id, image: $image, '
        'partner: $partner, '
        'title: $title, '
        'description: $description, expire: $expire, from: $from, categoryId: $categoryId, userFor: $userFor, score: $score, rate: $rate}';
  }
}
