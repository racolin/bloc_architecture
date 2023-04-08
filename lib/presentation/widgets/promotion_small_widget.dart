import 'package:flutter/material.dart';

import '../../data/models/promotion_model.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class PromotionSmallWidget extends StatelessWidget {
  final PromotionModel promotion;
  final VoidCallback? onClick;
  final bool isReload;

  const PromotionSmallWidget({
    Key? key,
    required this.promotion,
    this.onClick,
    this.isReload = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(spaceXS),
      overlayColor: MaterialStateProperty.all(
        Theme.of(context).primaryColor.withOpacity(opaXS),
      ),
      onTap: onClick,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: spaceXS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(spaceXS),
          color: Colors.white,
        ),
        child: isReload
            ? _getReloadItem()
            : ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(spaceXS),
                  child: Image.network(
                    promotion.image,
                    height: dimXL,
                    width: dimMD,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: spaceXXS),
                  child: Text(
                    promotion.partner,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: fontMD,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                subtitle: Text(
                  promotion.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: fontSM,
                  ),
                ),
                trailing: Column(
                  children: [
                    Container(
                      width: dimMD,
                      padding: const EdgeInsets.all(spaceXXS),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(spaceMD),
                      ),
                      child: Text(
                        promotion.score.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spaceXS,
                    ),
                    const Text(
                      txtScoreName,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  ListTile _getReloadItem() {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(spaceXS),
        child: Container(
          color: Colors.grey.withOpacity(opaSM),
          height: dimXL,
          width: dimMD,
          child: const Icon(Icons.image_outlined),
        ),
      ),
      title: Container(
        margin: const EdgeInsets.only(top: spaceSM),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(opaSM),
          borderRadius: BorderRadius.circular(spaceXXS),
        ),
        width: double.maxFinite,
        child: const Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      subtitle: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(opaSM),
          borderRadius: BorderRadius.circular(spaceXXS),
        ),
        width: double.maxFinite,
        child: const Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      trailing: Column(
        children: [
          Container(
            width: dimMD,
            padding: const EdgeInsets.all(spaceXXS),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(opaSM),
              borderRadius: BorderRadius.circular(spaceMD),
            ),
            child: const Text(
              '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: spaceXS,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(opaSM),
              borderRadius: BorderRadius.circular(spaceMD),
            ),
            width: txtScoreName.length * fontMD,
            child: const Text(
              '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
