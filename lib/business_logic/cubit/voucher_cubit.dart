import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/exception_bloc.dart';
import '../../business_logic/cubit/voucher_state.dart';
import '../../business_logic/message_notify.dart';
import '../../presentation/dialogs/message_notify_type.dart';

import '../../data/models/voucher_category_model.dart';
import '../../data/models/voucher_model.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit()
      : super(
          VoucherInitial(),
        );

  Future<MessageNotify?> fetchData() async {
    emit(VoucherLoading());

    List<List<Object>> list;
    try {
      list = await Future.wait([_fetchData(), _fetchDataCategory()]);
    } on ExceptionBloc catch (ex) {
      return ex.message;
    }

    emit(
      VoucherLoaded(
        list: list[0] as List<VoucherModel>,
        typeList: list[1] as List<VoucherCategoryModel>,
      ),
    );
    return null;
  }

  Future<List<VoucherModel>> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      ...List.generate(
        4,
        (index) => VoucherModel(
          id: 'FREESHIP2023$index',
          image:
              'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
          title: 'Giảm 50.000đ cho đơn 199.000đ',
          slider:
              'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
          categoryId: index,
          partner: 'The Coffee House',
          from: DateTime(2023, 3, 29),
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
          expire: DateTime(2023, 4, 29),
        ),
      ),
      ...List.generate(
        4,
        (index) => VoucherModel(
          id: 'FREESHIP2023${4 + index}',
          image:
              'https://stc.shopiness.vn/deal/2020/02/06/6/2/e/1/1580963857029_540.png',
          title: 'Giảm 20K đơn 50K',
          partner: 'Beauty Garden',
          slider:
              'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
          categoryId: index,
          from: DateTime(2023, 3, 29),
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
          expire: DateTime(2023, 4, 29),
        ),
      ),
      ...List.generate(
        2,
        (index) => VoucherModel(
          id: 'FREESHIP2023${8 + index}',
          image:
              'https://stc.shopiness.vn/deal/2020/02/06/6/2/e/1/1580963857029_540.png',
          title: 'Giảm 20K đơn 50K',
          partner: 'Beauty Garden',
          slider:
              'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
          categoryId: index * 2 + 1,
          from: DateTime(2023, 3, 29),
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
          expire: DateTime(2023, 4, 29),
        ),
      ),
    ];
  }

  Future<List<VoucherCategoryModel>> _fetchDataCategory() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      VoucherCategoryModel(id: 0, title: 'Sắp hết hạn'),
      VoucherCategoryModel(id: 1, title: 'Sẵn sàng sử dụng'),
      VoucherCategoryModel(id: 2, title: 'Đã sử dụng'),
      VoucherCategoryModel(id: 3, title: 'Đã hết hạn'),
    ];
  }

  Future<MessageNotify?> loadMoreData() async {
    if (this.state is! VoucherLoaded) {
      return MessageNotify(
        messageType: MessageType.failure,
        title: 'Cảnh báo',
        content: 'Giao diện chưa tải xong, hãy thử lại!',
      );
    }

    var state = this.state as VoucherLoaded;

    if (state.isLoadMore) {
      return MessageNotify(
        messageType: MessageType.failure,
        title: 'Cảnh báo',
        content: 'Thao tác xem thêm dữ liệu đang được thực hiện!',
      );
    }

    emit(state.copyWith(isLoadMore: true));

    List<VoucherModel> list = await _loadMoreData(error: true);

    emit(
      state.copyWith(
        isLoadMore: false,
        list: list,
      ),
    );

    return null;
  }

  Future<List<VoucherModel>> _loadMoreData({bool error = false}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (error) {
      throw ExceptionBloc(
        message: MessageNotify(
          messageType: MessageType.error,
          title: 'Lỗi!',
          content: 'Lỗi xảy ra khi load dữ liệu!',
        ),
      );
    }
    return [
      ...List.generate(
        2,
        (index) => VoucherModel(
          id: 'FREESHIP2023$index',
          image:
              'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
          title: 'Giảm 50.000đ cho đơn 199.000đ',
          slider:
              'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
          categoryId: index * 2,
          partner: 'The Coffee House',
          from: DateTime(2023, 3, 29),
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
          expire: DateTime(2023, 4, 29),
        ),
      ),
      ...List.generate(
        2,
        (index) => VoucherModel(
          id: 'FREESHIP2023$index',
          image:
              'https://stc.shopiness.vn/deal/2020/02/06/6/2/e/1/1580963857029_540.png',
          title: 'Giảm 20K đơn 50K',
          partner: 'Beauty Garden',
          slider:
              'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
          categoryId: index * 2 + 1,
          from: DateTime(2023, 3, 29),
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
          expire: DateTime(2023, 4, 29),
        ),
      ),
    ];
  }

  MessageNotify? selectItem(String id) {
    if (this.state is! VoucherLoaded) {
      return MessageNotify(
        messageType: MessageType.failure,
        title: 'Cảnh báo',
        content: 'Giao diện chưa tải xong, hãy thử lại!',
      );
    }
    var state = this.state as VoucherLoaded;
    emit(state.copyWith(selectedId: id));
    return null;
  }
}
