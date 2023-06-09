import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/promotion_cubit.dart';
import '../../business_logic/cubit/promotion_state.dart';
import '../../data/models/promotion_model.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';
import '../widgets/group_item_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/promotion_large_widget.dart';
import '../widgets/promotion_me_widget.dart';
import '../widgets/promotion_small_widget.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<PromotionCubit, PromotionState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case PromotionInitial:
              return const SizedBox();
            case PromotionLoading:
              return const Center(
                child: LoadingWidget(),
              );
            case PromotionLoaded:
              state as PromotionLoaded;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: spaceMD,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        txtOutStanding,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: fontLG,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
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
                          txtSeeAll,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.getOutStanding(60)
                          .map(
                            (e) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PromotionLargeWidget(
                                  promotion: e,
                                  onClick: () {

                                  },
                                ),
                                const SizedBox(
                                  width: spaceXS,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: spaceMD,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        txtFromMe,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: fontLG,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
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
                          txtSeeAll,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.getFromMe()
                          .map(
                            (e) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PromotionMeWidget(
                                  promotion: e,
                                  onClick: () {

                                  },
                                ),
                                const SizedBox(
                                  width: spaceXS,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: spaceMD,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        txtFromPartner,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: fontLG,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
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
                          txtSeeAll,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _getFromPartner(
                      state.getFromPartner(),
                      3,
                    ),
                  ),
                  const SizedBox(
                    height: spaceMD,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        txtTypePromotion,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: fontLG,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
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
                          txtSeeAll,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < state.typeList.length; i++)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GroupItemWidget(
                                icon: const Icon(
                                  Icons.star_outline_outlined,
                                  size: fontLG,
                                  color: Colors.black,
                                ),
                                title: state.typeList[i].title,
                                onClick: () {},
                                isTop: i == 0,
                                isBottom: i == state.typeList.length - 1,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: spaceMD),
                                child: Divider(height: 1),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: dimLG,
                  ),
                ],
              );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _getFromPartner(
    List<PromotionModel> promotions,
    int itemInColumn,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < promotions.length; i += itemInColumn)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getItemFromPartner(
                promotions.sublist(
                  i,
                  (i + itemInColumn) > promotions.length
                      ? promotions.length
                      : (i + itemInColumn),
                ),
              ),
              const SizedBox(
                width: spaceXS,
              ),
            ],
          ),
      ],
    );
  }

  Widget _getItemFromPartner(List<PromotionModel> promotions) {
    return SizedBox(
      width: 280,
      child: Column(
        children: promotions
            .map(
              (promotion) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PromotionSmallWidget(
                    promotion: promotion,
                    onClick: () {

                    },
                  ),
                  const SizedBox(
                    height: spaceXS,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
