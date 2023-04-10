import 'package:flutter/foundation.dart';
import '../../../data/models/voucher_category_model.dart';
import '../../../data/models/voucher_model.dart';

@immutable
abstract class VoucherState {}

class VoucherInitial extends VoucherState {
  VoucherInitial() {
    print(runtimeType);
  }
}

class VoucherLoading extends VoucherState {
  VoucherLoading() {
    print(runtimeType);
  }
}

class VoucherLoaded extends VoucherState {
  final List<VoucherModel> list;
  final List<VoucherCategoryModel> typeList;
  final String? selectedId;
  final bool isLoadMore;

  VoucherLoaded({
    required this.list,
    required this.typeList,
    this.selectedId,
    this.isLoadMore = false,
  }) {
    print(runtimeType);
  }

  VoucherModel? getItemSelected() {
    if (selectedId != null) {
      var index = list.indexWhere((e) => e.id == selectedId);
      if (index != -1) {
        return list[index];
      }
    }
    return null;
  }

  List<VoucherModel> getByCategoryId(int id) {
    return list.where((e) => e.categoryId == id).toList();
  }

  VoucherLoaded copyWith({
    List<VoucherModel>? list,
    List<VoucherCategoryModel>? typeList,
    String? selectedId,
    bool? isLoadMore,
  }) {
    return VoucherLoaded(
      list: list ?? this.list,
      typeList: typeList ?? this.typeList,
      selectedId: selectedId,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }
}

class VoucherFailure extends VoucherState {
  VoucherFailure() {
    print(runtimeType);
  }
}
