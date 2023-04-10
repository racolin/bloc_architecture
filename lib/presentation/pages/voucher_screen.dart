import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/cubit/voucher_cubit.dart';
import '../business_logic/cubit/voucher_state.dart';
import '../res/dimen/dimens.dart';
import '../widgets/loading_widget.dart';
import '../widgets/voucher_widget.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key? key}) : super(key: key);

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vouchers'),
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: spaceSM),
        child: BlocBuilder<VoucherCubit, VoucherState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case VoucherInitial:
                return const SizedBox();
              case VoucherLoading:
                return const Center(
                  child: LoadingWidget(),
                );
              case VoucherLoaded:
                state as VoucherLoaded;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var type in state.typeList)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: spaceMD,
                          ),
                          Text(
                            type.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: fontLG,
                            ),
                          ),
                          for (var item in state.getByCategoryId(type.id)) ...[
                            const SizedBox(
                              height: spaceXS,
                            ),
                            VoucherWidget(
                              voucher: item,
                              onClick: () {
                                context
                                    .read<VoucherCubit>()
                                    .selectItem(item.id);
                              },
                            ),
                          ],
                          const SizedBox(
                            height: spaceXS,
                          ),
                        ],
                      ),
                    const SizedBox(height: dimLG,),
                  ],
                );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
