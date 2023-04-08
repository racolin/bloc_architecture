class PromotionCategoryModel {
  final int id;
  final String image;
  final String title;

  PromotionCategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  String toString() {
    return 'PromotionCategoryModel{id: $id, image: $image, title: $title}';
  }
}
