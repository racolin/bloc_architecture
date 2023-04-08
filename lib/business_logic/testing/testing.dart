import '../../business_logic/cubit/voucher_state.dart';

import '../../data/models/promotion_model.dart';

void main() {
  var list = List.generate(
    8,
    (index) => PromotionModel(
      id: 'PM-00',
      image:
          'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
      partner: 'Beauty Garden',
      title: 'Giảm 50.000đ cho đơn 199.000đ',
      description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
          '\n- Áp dụng cho toàn bộ menu The Coffee House'
          '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
      expire: DateTime(2023, 3, 29),
      userFor: 86400 * 30,
      score: 99,
      categoryId: index,
      from: 0,
      rate: index * 10,
    ),
  );
}
