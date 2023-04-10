import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/promotion_category_model.dart';
import '../../../data/models/promotion_model.dart';
import '../../dialogs/message_notify_type.dart';
import 'promotion_state.dart';

import '../message_notify.dart';
import 'exception_bloc.dart';

class PromotionCubit extends Cubit<PromotionState> {
  PromotionCubit()
      : super(
          PromotionInitial(),
        );

  Future<MessageNotify?> fetchData() async {
    emit(PromotionLoading());

    List<List<Object>> list;
    try {
      list = await Future.wait([_fetchData(), _fetchDataCategory()]);
    } on ExceptionBloc catch (ex) {
      return ex.message;
    }

    emit(
      PromotionLoaded(
        list: list[0] as List<PromotionModel>,
        typeList: list[1] as List<PromotionCategoryModel>,
        selectedIndex: null,
      ),
    );

    return null;
  }

  Future<MessageNotify?> reFetchItemData() async {
    if (this.state is! PromotionLoaded) {
      return MessageNotify(
        messageType: MessageType.failure,
        title: 'Cảnh báo',
        content: 'Giao diện chưa tải xong, hãy thử lại!',
      );
    }

    var state = this.state as PromotionLoaded;

    emit(state.copyWith(
      reloadList: List.generate(
        state.list.length,
        (index) => index,
      ),
    ));

    List<List<Object>> list;
    try {
      list = await Future.wait([_fetchData(), _fetchDataCategory()]);
      await Future.delayed(const Duration(seconds: 3));
    } on ExceptionBloc catch (ex) {
      return ex.message;
    }

    list[0] = (list[0] as List<PromotionModel>).sublist(0, 4);

    emit(
      state.copyWith(
        list: list[0] as List<PromotionModel>,
        reloadList: [],
      ),
    );
    return null;
  }

  Future<List<PromotionModel>> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      ...List.generate(
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
      ),
      ...List.generate(
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
          from: 1,
          rate: index * 15,
        ),
      ),
    ];
  }

  Future<List<PromotionCategoryModel>> _fetchDataCategory() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      PromotionCategoryModel(
        id: 0,
        title: 'Tất cả',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategoryModel(
        id: 1,
        title: 'The Coffee House',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategoryModel(
        id: 2,
        title: 'Ăn uống',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategoryModel(
        id: 3,
        title: 'Du lịch',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategoryModel(
        id: 4,
        title: 'Mua sắm',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategoryModel(
        id: 5,
        title: 'Giải trí',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategoryModel(
        id: 6,
        title: 'Dịch vụ',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategoryModel(
        id: 7,
        title: 'Giới hạn',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
    ];
  }

  MessageNotify? selectItem(int index) {
    if (this.state is! PromotionLoaded) {
      return MessageNotify(
        messageType: MessageType.failure,
        title: 'Cảnh báo',
        content: 'Giao diện chưa tải xong, hãy thử lại!',
      );
    }
    var state = this.state as PromotionLoaded;

    emit(state.copyWith(selectedIndex: index));
    return null;
  }

  Future<MessageNotify?> reloadItem(int index) async {
    if (this.state is! PromotionLoaded) {
      return MessageNotify(
        messageType: MessageType.failure,
        title: 'Cảnh báo',
        content: 'Giao diện chưa tải xong, hãy thử lại!',
      );
    }
    var state = this.state as PromotionLoaded;

    emit(state.copyWith(
      selectedIndex: index,
      reloadList: state.reloadList + [index],
    ));

    await Future.delayed(const Duration(seconds: 3));

    state = this.state as PromotionLoaded;

    emit(state.copyWith(
      selectedIndex: index,
      reloadList: state.reloadList.where((e) => e != index).toList(),
    ));

    return null;
  }

  Future<MessageNotify?> selectItemBug(int index) async {
    if (this.state is! PromotionLoaded) {
      return MessageNotify(
        messageType: MessageType.failure,
        title: 'Cảnh báo',
        content: 'Giao diện chưa tải xong, hãy thử lại!',
      );
    }
    var state = this.state as PromotionLoaded;

    emit(
      PromotionFailure(
        message: MessageNotify(
          messageType: MessageType.failure,
          title: 'Lỗi!',
          content: 'Có lỗi xảy ra khi thực hiện thao tác này!',
        ),
      ),
    );

    return null;

    return MessageNotify(
      messageType: MessageType.failure,
      title: 'Lỗi!',
      content: 'Có lỗi xảy ra khi thực hiện thao tác này!',
    );
  }
}
