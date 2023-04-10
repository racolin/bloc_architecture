import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/message_notify.dart';
import '../../data/models/voucher_model.dart';
import '../../presentation/bottom_sheets/voucher_bottom_sheet.dart';
import '../../presentation/dialogs/dialog_widget.dart';
import '../../presentation/dialogs/message_notify_type.dart';
import '../../presentation/pages/voucher_screen.dart';

import '../business_logic/cubit/promotion_cubit.dart';
import '../business_logic/cubit/promotion_state.dart';
import '../business_logic/cubit/voucher_cubit.dart';
import '../business_logic/cubit/voucher_state.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';
import '../widgets/loading_widget.dart';
import '../widgets/promotion_small_widget.dart';
import '../widgets/voucher_widget.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: spaceMD,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                txtYourVoucher,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontLG,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: BlocProvider.of<VoucherCubit>(context),
                        child: const VoucherScreen(),
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.orange.withOpacity(opaXS),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.orange.withAlpha(20),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(spaceLG),
                    ),
                  ),
                ),
                child: const Text(
                  txtSeeAll,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          BlocConsumer<VoucherCubit, VoucherState>(
            listener: (context, state) {
              if (state is VoucherLoaded) {
                if (state.selectedId != null) {
                  VoucherModel? model = state.getItemSelected();
                  if (model != null) {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => BlocProvider.value(
                        value: BlocProvider.of<VoucherCubit>(context),
                        child: VoucherBottomSheet(
                          voucher: model,
                        ),
                      ),
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => DialogWidget(
                        messageNotify: MessageNotify(
                          messageType: MessageType.error,
                          title: 'Lỗi!',
                          content: 'Có lỗi đã xảy ra khi thực hiện mở mục này?',
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  // Navigator.pop(context);
                }
              } else {}
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case VoucherInitial:
                  return const SizedBox();
                case VoucherLoading:
                  return const Center(
                    child: LoadingWidget(),
                  );
                case VoucherLoaded:
                  var list = (state as VoucherLoaded).list;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < list.length; i++)
                        Column(
                          children: [
                            VoucherWidget(
                              voucher: list[i],
                              onClick: () {
                                context
                                    .read<VoucherCubit>()
                                    .selectItem(list[i].id);
                              },
                            ),
                            const SizedBox(
                              height: spaceXS,
                            ),
                          ],
                        ),
                    ],
                  );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(
            height: spaceMD,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                txtPromotionSwap,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontLG,
                ),
              ),
              TextButton(
                onPressed: () async {
                  MessageNotify? message =
                      await context.read<PromotionCubit>().reFetchItemData();
                  if (message != null) {
                    showCupertinoDialog(
                      context: context,
                      builder: (ctx) => DialogWidget(
                        messageNotify: message,
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.orange.withAlpha(20),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(spaceMD),
                    ),
                  ),
                ),
                child: const Text(
                  txtReload,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          BlocBuilder<PromotionCubit, PromotionState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case PromotionInitial:
                  return const SizedBox();
                case PromotionLoading:
                  return const Center(
                    child: LoadingWidget(),
                  );
                case PromotionLoaded:
                  var list = (state as PromotionLoaded).list;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < list.length; i++)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PromotionSmallWidget(
                              promotion: list[i],
                              isReload: state.reloading(i),
                              onClick: () {
                                if (state.reloadList.isNotEmpty) {
                                  if (state.reloading(i)) {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) => DialogWidget(
                                        messageNotify: MessageNotify(
                                          messageType: MessageType.info,
                                          title: 'Thông báo',
                                          content:
                                              'Mục này đang trong quá trình tải lại?',
                                        ),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (ctx) => DialogWidget(
                                        messageNotify: MessageNotify(
                                          messageType: MessageType.info,
                                          title: 'Thông báo',
                                          content:
                                              'Bạn có muốn tải lại thêm mục này không?',
                                        ),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: const Text('Tải lại'),
                                            onPressed: () {
                                              context
                                                  .read<PromotionCubit>()
                                                  .reloadItem(i);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: const Text('Huỷ bỏ'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  context.read<PromotionCubit>().reloadItem(i);
                                }
                              },
                            ),
                            const SizedBox(
                              height: spaceXS,
                            ),
                          ],
                        ),
                    ],
                  );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(
            height: dimLG,
          ),
        ],
      ),
    );
  }
}
