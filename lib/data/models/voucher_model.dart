class VoucherModel {
  final String id;
  final String image;
  final String title;
  final String partner;
  final String slider;
  final int categoryId;
  final DateTime from;
  final DateTime expire;
  final String description;

  VoucherModel({
    required this.id,
    required this.image,
    required this.title,
    required this.partner,
    required this.slider,
    required this.categoryId,
    required this.from,
    required this.expire,
    required this.description,
  });
}